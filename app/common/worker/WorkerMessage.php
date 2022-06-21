<?php
/**
 * Created by : PhpStorm
 * Web: https://www.kaadon.com
 * User: ipioo
 * Date: 2022/1/11 06:47
 */

namespace app\common\worker;

use app\common\model\MemberAccount;
use GatewayWorker\Lib\Gateway;
use Kaadon\Jwt\JwtCache;


class WorkerMessage
{
    protected $redis;
    protected $client_id;
    protected $uid;

    public function __construct($client_id = null)
    {
        $redis = new \Redis();
        $redis->connect('127.0.0.1', 6379);
        $redis->auth('123456');
        $this->redis = $redis;
        try {
            /*执行主体*/
            $this->client_id = $client_id;
            $this->uid       = Gateway::getUidByClientId($client_id);
        } catch (\Exception $e) {
            var_dump('ERROR_' . $client_id);
        }
    }

    public function login($data)
    {
        if (!array_key_exists('token', $data)) {
            Gateway::sendToClient($this->client_id, json_encode([
                'type' => 'error1',
                'data' => 'No token! Please get token first'
            ], true));
            return;
        }
        $token = $data['token'];

        $result = [];
        try {
            /*执行主体*/
            $jwtData        = jwt_verify(strToUtf8($token));
            $selfUid        = $jwtData->data->identification;
            $this->uid      = $selfUid;
            $result['type'] = 'logined';
            $result['data'] = $jwtData->data;

            Gateway::bindUid($this->client_id, $selfUid);
        } catch (\Exception $e) {
            $result['type'] = 'error';
            $result['data'] = $e->getMessage();
            $result['err']  = $e->getTrace();
            Gateway::sendToClient($this->client_id, json_encode($result, true));
            return;
        }
        switch ($jwtData->data->type) {
            case "merchant":

                break;
            case "customer":
                MemberAccount::where('uuid', $jwtData->data->uuid)->update([
                    'login_time' => time()
                ]);
                break;
            default:
                $result['type'] = 'error';
                $result['data'] = '非法请求,无权限!';
        }
        $this->redis->set('u_' . $this->client_id, $selfUid);
        Gateway::sendToClient($this->client_id, json_encode($result, true));
        if ($result['type'] == 'error') {
            Gateway::closeClient($this->client_id);
            $this->redis->set('errorIp' . $jwtData->data->ip, $jwtData->data->ip, 60 * 60);
        }
    }

    public function tocontent($data)
    {
        $result    = [];
        $loginData = $this->redis->get($this->uid);
        if (empty($loginData)) {
            $result['type'] = 'tologin';
            $result['data'] = [
                'uuid' => $data['uuid']
            ];
            Gateway::sendToClient($this->client_id, json_encode($result, true));
            return;
        } else {
            $loginData = json_decode($loginData, true);
        }
        if (!array_key_exists('uuid', $data) || !array_key_exists('data', $data)
            || ($loginData['type'] == 'customer' && !array_key_exists('memberId', $data))
        ) {
            $result['type'] = 'error';
            $result['data'] = '数据格式错误!';
            Gateway::sendToUid($this->uid, json_encode($result));
            return;
        }
        switch ($loginData['type']) {
            case "customer":
                $toUid             = $data['memberId'];
                $result['type']    = 'fromcustomer';
                $result['uuid']    = $data['uuid'];
                $result['receive'] = [
                    'type' => 'member',
                    'uid'  => $data['memberId']
                ];
                $result['data']    = $data['data'];

                break;
            default:
                $result['type'] = 'error';
                $result['data'] = '非法请求,无权限!';
        }

        Gateway::sendToUid($toUid, json_encode($result));
    }

    public function close($client_id)
    {
        $uid = $this->redis->get('u_' . $client_id);
        if (!$uid) {
            return;
        }
        $this->redis->unlink('record_' . $uid);
        $this->redis->del('u_' . $client_id);
    }


}