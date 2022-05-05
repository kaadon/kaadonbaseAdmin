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

class UserAttendance extends TimeModel
{
    protected $table = "ea_user_attendance";

    //打卡签到
    public function setAdd($id,$month,$ymd,$late = 0,$late_time = 0){
        $data = (new UserAttendance)->where(['sta_id'=>$id,'month'=>$month])->find();
        if(!empty($data)){
            if($late){
                $late1 = $data['late'];
                $late_id = (new UserLateTime)->insertGetId(['time'=>$late_time]);
                (new UserAttendance)->where(['sta_id'=>$id,'month'=>$month])->update(['late'=>$late1+1,'late_id'=>$late_id]);
            }
            $num = $data['days'];
            (new UserAttendance)->where(['sta_id'=>$id,'month'=>$month])->update(['days'=>$num+1,'ymd'=>$ymd]);
        }
            (new UserAttendance)->create(['sta_id'=>$id,'month'=>$month,'days'=>1,'ymd'=>$ymd]);

    }
    //查询
    public function Info($where){
        $row = (new UserAttendance)->where($where)->find();
        return empty($row)?[]:$row->toArray();
    }
}