<?php

namespace app\api\controller;
use app\api\validate\UserValidate;
use app\BaseController;
use app\common\model\ProductProject;
use app\common\model\UserStaff;
use think\exception\ValidateException;

class Login extends BaseController
{

    /**
     * 前台登录
     * @return string|\think\response\Json
     * @throws \Exception
     */
    public function login()
    {
        $account = $this->request->param('account', null);
        $password = $this->request->param('password', null);
        $data = [
            'account'        => $this->request->param('account', null),
            'password'        => $this->request->param('password', null),
        ];
        $scene = strpos($data['account'],'@')?'emailLogin':'Login';
        try {
            validate(UserValidate::class)
                ->scene($scene)
                ->check($data);
        } catch (ValidateException $e) {
            return error($e->getMessage());
        }
        $accountData = (new UserStaff())->where('account',$data['account'])->find();
        $user = empty($accountData) ? array():$accountData->toArray();
        $token   = 'kaadon ' . jwt_create($user['id'], [
                'type' => 'merchant',
                'id'   => $user['id']
            ]);
//        $token = JwtCache::set($user['uid'], substr($token, 7));
        if (!$token) {
            return error(lang('loginError'));
        }
        return json([
            'code' => 200,
            'token' =>$token,
            'msg' => '登录成功',
        ]);
    }
}
