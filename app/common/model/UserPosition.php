<?php

// +----------------------------------------------------------------------
// | kaadonAdmin
// +----------------------------------------------------------------------
// | AUTHOR: KAADON@GMAIL.COM
// +----------------------------------------------------------------------
// | 开源协议  https://mit-license.org
// +----------------------------------------------------------------------
// | github开源项目：https://github.com/kaadon/kaadonAdmin
// +----------------------------------------------------------------------

namespace app\common\model;

/**
 * Class UserClient(职位管理)
 * @package app\common\model
 */
class UserPosition extends TimeModel
{
    protected $table = "ea_user_position";

    public static function add($data){
        return UserPosition::create($data);
    }
    public static function info($where){
        $row = UserPosition::where($where)->find();
        return empty($row)?[]:$row->toArray();
    }
    public static function del($where){
        return UserPosition::where($where)->delete();
    }
}