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
    //查询单条
    public static function info($where = 1){
        $row = ProductProject::where($where)->find();
        return empty($row)?[]:$row->toArray();
    }
    //查询多条
    public static function Infos($where = 0){
        $row = ProductProject::select();
        if ($where){
            $row = ProductProject::where($where)->select();
        }
        return empty($row)?[]:$row->toArray();
    }
    public static function del($where){
        ProductProject::where($where)->delete();
    }
    //获取客户名称
    public function getCidAttr($value){
       $data = (new UserClient())->where(['id'=>$value])->find();
        return $data['name'];
    }
    //开始时间
    public function getBeginTimeAttr($value){
        return date('y-m-d H:i:s',$value);
    }
    //结束时间
    public function getEndTimeAttr($value){
        return date('y-m-d H:i:s',$value);
    }
    //创建时间
    public function getCreateAtAttr($value){
        return date('y-m-d H:i:s',$value);
    }
    //修改时间
    public function getUpdateAtAttr($value){
        return date('y-m-d H:i:s',$value);
    }
    //删除时间
    public function getDeleteAtAttr($value){
        return date('y-m-d H:i:s',$value);
    }
}