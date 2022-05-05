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

use think\Model;
//客户模型
class UserClient extends TimeModel
{
    protected $table = "ea_user_client";

    public static function info($where){
        $row = (new UserClient)->where($where)->find();
        return empty($row)?null:$row->toArray();
    }
    public static function del($where){
        (new UserClient)->where($where)->delete();
    }
}