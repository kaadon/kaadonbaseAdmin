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

class ProductProject extends TimeModel
{
    protected $table = "ea_product_project";
    public static function info($where = 1){
        $row = ProductProject::where($where)->find();
        return empty($row)?[]:$row->toArray();
    }
    public static function Infos($where){
        $row = ProductProject::where($where)->select();
        return empty($row)?[]:$row->toArray();
    }

    public static function del($where){
        ProductProject::where($where)->delete();
    }
}