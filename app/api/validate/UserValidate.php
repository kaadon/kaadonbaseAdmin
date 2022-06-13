<?php
declare (strict_types = 1);

namespace app\api\validate;

use app\common\validate\CommonValidate;

/**
 * Class UserValidate
 * @package app\api\validate
 */
class UserValidate extends CommonValidate
{
    /**
     * 定义更新安全密码验证场景
     * @return UserValidate
     */
    public function sceneForget()
    {
//        return $this->only(['username','newpassword','verify_code','type'])
        return $this->only(['newpassword','type'])
            ->append('username','usernameOnly:existent');
    }
    /**
     * 定义更新邮箱验证场景
     * @return UserValidate
     */
    public function sceneupdataemail()
    {
        return $this->only(['username','email','verify_code','type']);
    }
    /**
     * 定义更新手机号验证场景
     * @return UserValidate
     */
    public function sceneupdataphone()
    {
        return $this->only(['username','phone','verify_code','type']);
    }
    /**
     * 定义更新支付宝验证场景
     * @return UserValidate
     */
    public function sceneAlipay()
    {
        return $this->only(['username','realname'])
            ->append('username','usernameOnly:existent');
    }
    /**
     * 定义更新银行验证场景
     * @return UserValidate
     */
    public function sceneBank()
    {
        return $this->only(['username','realname','bankname','bankcard'])
            ->append('username','usernameOnly:existent');
    }
//    /**
//     * 定义更新安全密码验证场景
//     * @return UserValidate
//     */
//    public function sceneUpdateProfile()
//    {
//        return $this->only(['username','realname','idcard','wechat','qq','avatar','nickname','verify_img_id','verify_img_code'])
//            ->append('username','usernameOnly:existent')
//            ->append('idcard','profileOnly')
//            ->remove('avatar','require')
//            ->remove('wechat','require')
//            ->remove('nickname','require')
//            ->remove('qq','require');
//    }
    /**
     * 重构定义更新安全密码验证场景
     * @return UserValidate
     */
    public function sceneUpdateProfile()
    {
        return $this->only(['nickname','verify_img_id','verify_img_code'])
            ->remove('nickname','require');
    }
    /**
     * 定义更新实名认证
     * @return UserValidate
     */
    public function sceneUpdateAuthen()
    {
        return $this->only(['username','front','back','hold']);
    }
    /**
     * 定义更新安全密码验证场景
     * @return UserValidate
     */
    public function sceneUpdateSafeword()
    {
//        return $this->only(['username','password','newsafeword','verify_img_id','verify_img_code'])
        return $this->only(['username','password','newsafeword'])
            ->append('username','usernameOnly:existent')
            ->append('password','verifySecret');
    }
    /**
     * 定义更新安全密码验证场景
     * @return UserValidate
     */
    public function sceneExchange()
    {
        return $this->only(['username','safeword','verify_img_id','verify_img_code'])
            ->append('username','usernameOnly:existent')
            ->append('safeword','verifySecret');
    }
    /**
     * 定义登录验证场景
     * @return UserValidate
     */
    public function sceneUpdatePassword()
    {
        return $this->only(['username','password','newpassword','verify_img_id','verify_img_code'])
            ->append('username','usernameOnly:existent')
            ->append('password','verifySecret');
    }
    /**
     * 定义登录验证场景
     * @return UserValidate
     */
    public function sceneLogin()
    {
//        return $this->only(['username','password','verify_img_id','verify_img_code'])
        return $this->only(['account','password'])
            ->append('account','usernameOnly:existent')
            ->append('password','verifySecret');
    }
    public function sceneemailLogin()
    {
//        return $this->only(['email','password','verify_img_id','verify_img_code'])
        return $this->only(['account','password'])
            ->append('password','verifySecret');
    }
    /**
     * 定义手机号注册验证场景
     * @return object
     */
    public function sceneRegister()
    {
        return $this->only(['username','password','safeword','inviter','verify_img_id','verify_img_code','type'])
//        return $this->only(['username','password','safeword','inviter','type'])
            ->append('safeword','different:password')
            ->append('username','usernameOnly:non-existent')
            ->append('inviter','inviterExistent');
    }
    /**
     * 定义员工注册验证场景
     * @return object
     */
    public function sceneStaffRegister()
    {
        return $this->only(['name','password','p_id','phone','account'])
            ->append('p_id','number')
            ->append('account','usernameOnly:non-existent');
    }

    /**
     * 定义用户验证场景
     * @return object
     */
    public function sceneUserMode()
    {
        return $this->only(['username'])
            ->append('username', ['usernameOnly:existent,status,authen']);
    }
    /**
     * 定义短信验证场景
     * @return object
     */
    public function sceneCommonsms()
    {
        return $this->only(['username','type','verify_img_id','verify_img_code'])
            ->append('username', ['usernameOnly:existent']);
    }
    /**
     * 定义短信验证场景
     * @return object
     */
    public function sceneOrdinarysms()
    {
        return $this->only(['username','type','verify_img_id','verify_img_code'])
            ->append('username', ['usernameOnly:non-existent']);
    }

    /**
     * 定义邮箱验证场景
     */
    public function sceneSendemailsms()
    {
        return $this->only(['email','type','verify_img_id','verify_img_code'])
            ->append('email', ['usernameOnly:non-existent']);
    }
    /**
     * 定义短信验证场景
     * @return object
     */
    public function sceneSendbeemailsms()
    {
        return $this->only(['username','type','verify_img_id','verify_img_code'])
            ->append('username', ['usernameOnly:existent']);
    }
    /**
     * 定义支付验证场景
     * @return UserValidate
     */
    public function scenePay()
    {
        return $this->only(['username','safeword'])
//            ->append('username','usernameOnly:existent,status,authen')
            ->append('username','usernameOnly:existent')
            ->append('safeword','verifySecret');
    }
}
