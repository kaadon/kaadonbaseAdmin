<?php

namespace app\common\controller\member;

use app\common\controller\MemberController;
use app\common\model\MemberAccount;
use app\common\model\MemberDashboard;
use app\common\model\MemberProfile;
use app\common\model\MemberWallet;
use app\common\model\MerchantAccount;
use app\common\model\MerchantDashboard;
use app\common\service\Uuids;
use think\facade\Db;

class Account extends MemberController
{
    public function __construct()
    {

    }

    public function add($username,$password,$inviter = null,$analog = 0)
    {
        $data = [];
        if (empty($inviter)) {
            return false;

            $inviter = get_config('site','setting','inviter');
        }
        $agent = MemberAccount::where('uuid',$inviter)->find();
        if (empty($agent)){
            $agent = MerchantAccount::where('uuid',$inviter)->find();
            if (empty($agent)){
                return false;
            }else{
                $agent_line = $agent->agent_line . $agent->id . '|';
            }
        }else{
            $agent_line = $agent->agent_line;
        }
        $data['agent_line']    = $agent_line;
        $data['uuid']   = Uuids::getUuid(2);
        $data['analog']   = $analog;
        $data['password'] = password_hash($password, PASSWORD_DEFAULT);
        $data['safeword'] = password_hash($password, PASSWORD_DEFAULT);
        if ($inviter){
            $data['inviter'] = $inviter;
        }
        // 启动事务
        Db::startTrans();
        try {
            $agent_line = explode('|',$agent_line);
            if ($analog == "0"){
                MerchantDashboard::where([
                    ['uid','in',$agent_line]
                ])
                    ->inc('day_register',1)
                    ->inc('day_active',1)
                    ->inc('team_member',1)
                    ->update();
            }
            //添加账户
            $MemberAccount = new MemberAccount();
            $MemberAccount->save($data);
            //添加钱包
            $MemberWallet = new MemberWallet();
            $wallet = [
                'mid' => $MemberAccount->id,
            ];
            $MemberWallet->save($wallet);
            //添加资料
            $MemberProfile = new MemberProfile();
            $profile = [
                'mid' => $MemberAccount->id,
                'mobile' => $username,
                'nickname' => $data['uuid']
            ];
            $MemberProfile->save($profile);
            //添加仪表盘
            $MemberDashboard = new MemberDashboard();
            $dashboard = [
                'mid' => $MemberAccount->id,
            ];
            $MemberDashboard->save($dashboard);
            // 提交事务
            Db::commit();
        } catch (\Exception $e) {
//            var_dump($e->getMessage());
            // 回滚事务
            Db::rollback();
            return false;
        }
        return true;
    }


    public function update(string $cardid, array $meta)
    {
        if (empty($cardid)) {
            throw new \Exception('客服ID不能为空');
        }
        if (empty($meta)) {
            throw new \Exception('无更新数据');
        }

        $Customer = MemberAccount::getInfo($cardid);

        if (empty($Customer)) {
            throw new \Exception('客服不存在!');
        }

        $data = [];
        $arr  = ['status', 'status', 'nickname', "cardid", "password"];
        foreach ($arr as $item) {
            if (in_array($item, $meta)) {
                if ($item == "password") {
                    $data[$item] = password_hash($meta[$item], PASSWORD_DEFAULT);
                } else {
                    $data[$item] = $meta[$item];
                }
            }
        }

        $result = CustomerAccount::setUpdate(['cardid' => $cardid], $data);

        return $result;
    }

}