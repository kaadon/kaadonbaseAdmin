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

class UserProject extends Model
{
    protected $table = "ea_user_project";

    public function Infos($where){
        $row = UserProject::where($where)->select();
        return empty($row)?[]:$row->toArray();
    }
}