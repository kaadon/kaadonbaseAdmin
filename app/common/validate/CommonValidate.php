<?php

namespace app\common\validate;


use app\common\model\UserStaff;
use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Validate;
use think\facade\Db;
/**
 * Class CommonValidate
 * @package app\common\validate
 */
class CommonValidate extends Validate
{
    /**
     * 正则表达式过滤
     * @var array
     */
    protected $regex = [
        'path'     => '/^[a-zA-Z0-9\/\.\:]+$/',
        //        'realname' => '/^[\x80-\xff\.]{2,30}$/',
        //        'wechat'   => '/^[a-zA-Z0-9_-]+$/',
    ];
    /**
     * 定义验证规则
     * 格式：'字段名'    =>    ['规则1','规则2'...]
     *
     * @var array
     */
    protected $rule = [
        'qq|qq号'                => 'require|number',
        'mobile|手机号'            => 'require|mobile|number',
        'cardid|客服登录账号'            => 'require|alphaNum|length:6,15',
        'nickname|昵称'           => 'require|chsAlphaNum|length:6,32',
        'password|登录密码'         => 'require|length:6,32',
        'payment|支付方式'         => 'require|length:1,2|paymentNum',
        'newpassword|新登录密码'     => 'require|length:6,32',
        'safeword|交易密码'         => 'require|length:6,32',
        'newsafeword|新安全密码'     => 'require|length:6,32',
        'inviter|推荐人'           => 'require|length:12',
        'verify_code|短信验证码'     => 'require|number|length:6|smsCode',
        'type|类型'               => 'require|in:Common,Ordinary',//短信发送类型验证
        //        'realname|姓名'           => 'require|regex:realname|length:2,16',
        'realname|姓名'           => 'require|length:2,16',
        'idcard|身份证'            => 'require|idCard|length:18',
        'amount|充值数额'            => 'require|number|length:1,10',
        'usdt|USDT收款地址'         => 'require|length:15,64',
        //        'wechat|微信'             => 'require|regex:wechat|length:4,32',
        'wechat|微信'             => 'require|length:4,32',
        'alipay|支付宝'            => 'require|length:4,32',
        'bankname|银行名称'         => 'require|chs|length:4,16',
        'bankcard|银行卡'          => 'require|number|length:15,20',//银行卡验证
        'verify_img_id|图片验证ID'  => 'requireWith:verify_img_code',//图片验证ID验证
        'verify_img_code|图片验证码' => 'require|length:4|verifyImgcode',//图片验证码型验证
        'image|图片'              => 'require|file|fileMime:image/bmp,image/png,image/gif,image/jpeg,image/x-ms-bmp',//图片验证码型验证
        'file|文件'               => 'require|file|fileMime:application/x-rar,text/plain,audio/mpeg,video/mp4,application/vnd.android.package-archive,application/iphone',//图片验证码型验证
        'avatar|头像'             => 'require|regex:path',
        'front|身边证正面照片'         => 'require|regex:path',
        'back|身份证反面照片'          => 'require|regex:path',
        'hold|手持身份证照片'          => 'require|regex:path',
        'bank|银行名称'          => 'require',
    ];

    /**
     * 定义错误信息
     * 格式：'字段名.规则名'    =>    '错误信息'
     *
     * @var array
     */

    protected $message = [
        'image.fileMime' => '文件类型只支持jpg,png,gif,jpeg,bmp格式',
        'file.fileMime'  => '文件类型只支持rar,txt,mp3,mp4,apk,ipa格式',
        'realname.regex' => '姓名只能是中文和"."的组合',
        'wechat.regex'   => '微信号只能是小写字母大写字母和"_-"的组合',
        'avatar.regex'   => '头像路径格式不正确!',
        'cardid.alphaNum'   => '只能为6-15位数字和字母!',
        'front.regex'    => '身份证正面照片路径格式不正确!',
        'back.regex'     => '身份证反面照片路径格式不正确!',
        'hold.regex'     => '手持身份证照片路径格式不正确!',
    ];

    /**
     * 定义验证场景
     * UploadImage 上传图片验证场景
     * UploadFile 上传文件验证场景
     * @var array
     */
    protected $scene = [
        'UploadImage' => ['image'],
        'UploadFile' => ['file'],
    ];

    /**
     * 自定义验证规则
     * 判断用户存在或者不存在
     * @param $value
     * @param $rule
     * @return bool|string
     */
    protected function usernameOnly($value, $rule)
    {
        if (is_string($rule)) {
            $rules = explode(',', $rule);
        }
        if (strpos($value, "@")) {
            $username = (new UserStaff())->where('account', $value)->find();
            $res = empty($username) ? array() : $username->toArray();
        }elseif (strlen($value) == "11" && !strpos($value, "@")) {
            $username = (new UserStaff())->where('account', $value)->find();
            $res = empty($username) ? array() : $username->toArray();
        }else{
            return '请输入正确的账号';
//            $username = (new UserStaff())->where('account', $value)->find();
//            $res = empty($username) ? array() : $username->toArray();
        }
//        if (strlen($value) == 7) {
//            $res = UserStaff::info($value);
//        }
        if (in_array('existent', $rules)) {
            if (empty($res)) {
                return $value . lang('noUser');
            }
            if (in_array('status', $rules) && $res['status'] != 1) {
                return lang('statusError');
            }
            if (in_array('authen', $rules) && $res['authen'] != 1) {

                return lang('authenError');
            }
            return true;
        }
        if (in_array('non-existent', $rules)) {
            return empty($res) ? true : $value . '已存在!';
        }
    }

    /**
     * 自定义验证规则
     * 判断密码是否正确
     * @param $value
     * @param string $rule
     * @param array $data
     * @param string $name
     * @param string $Abbreviation
     * @return bool|string
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function profileOnly($value, $rule = '', array $data = [], $name = '', $Abbreviation = '')
    {
        if (!$data['username']) {
            return '用户名不能为空,不能验证' . ($Abbreviation ?: $name) . '!';
        }
        $key = UserProfile::where('username', '<>', $data['username'])
            ->where($name, '<>', $value)
            ->find();

        if (empty($key)) {
            return true;
        } else {
            return ($Abbreviation ?: $name) . '已存在!';
        }
    }

    /**
     * 自定义验证规则
     * 判断用户存在或者不存在
     * @param $value
     * @return bool|string
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function inviterExistent($value)
    {
        if (strlen($value) == 6) {
            $res = (new UserStaff())->where('uid', $value)->find();
        } else {
            $res = UserStaff::info($value);
        }
        return empty($res) ? '邀请码:' . $value . '不存在!' : true;
    }

    /**
     * 自定义验证规则
     * 判断短信验证码是否正确
     * @param $value
     * @param $rule
     * @param array $data
     * @return bool|string
     */
    protected function smsCode($value, $rule, $data = [])
    {
        $type = $data['type'];
        $value = strval($value);
        $raw = SmsCache::get($data['username'], $type);
//        var_dump($value);
//        var_dump($raw);
        if ($raw == $value) {
            SmsCache::del($data['username'], $type);
            return true;
        }
        return '短信验证码不正确!';
    }

    /**
     * 自定义验证规则
     * 判断密码是否正确
     * @param $value
     * @param string $rule
     * @param array $data
     * @param string $name
     * @param string $Abbreviation
     * @return bool|string
     * @throws DataNotFoundException
     * @throws DbException
     * @throws ModelNotFoundException
     */
    protected function verifySecret($value, $rule = '', array $data = [], $name = '', $Abbreviation = '')
    {
        if (!$data['account']) {
            return '用户名不能为空,不能验证密码!';
            }
//        if (strlen($data['account']) == "7") {
//            $user = UserStaff::info($data['account']);
//        }
        if (strlen($data['account']) == "11" && !strpos($data['account'], "@")) {
            $users = (new UserStaff())->where('account', $data['account'])->find();
            if (empty($users)){
                return '账号不存在';
            }
            $user = $users->toArray();
//            $user = empty($users) ? array() : $users->toArray();
        }
        if (strpos($data['account'], '@')) {
            $users = (new UserStaff())->where('account', $data['account'])->find();
            if (empty($users)){
                return '账号不存在';
            }
            $user = $users->toArray();
//            $user = empty($users) ? array() : $users->toArray();
        }
        if (empty($user)){
            $users = (new UserStaff())->where('account', $data['account'])->find();
            $user = empty($users) ? array() : $users->toArray();
            return '账号不存在';
        }
        if (password_verify($value, $user['password'])) {
            return true;
        } else {
//            return ($Abbreviation ?: $name) . '不正确!';
            return '密码不正确!';
        }
    }

    /**
     * 自定义验证规则
     * 判断图片验证码是否正确
     * @param $value
     * @param string $rule
     * @param array $data
     * @param string $name
     * @param string $Abbreviation
     * @return bool|string
     */
    protected function verifyImgcode($value, $rule = '', array $data = [], $name = '', $Abbreviation = '')
    {
        $check_verify = (new capcha)->check($data['verify_img_id'], $value);
        if (empty($check_verify)) {
            return ($Abbreviation ?: $name) . '错误或已过期!';
        }
        return true;
    }
}
