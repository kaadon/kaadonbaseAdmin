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
use function Composer\Autoload\includeFile;

class UserAttendance extends TimeModel
{
    protected $table = "ea_user_attendance";

    //打卡签到
    public function setAdd($id,$month,$ymd,$late = 0,$late_time = 0){
        $data = (new UserAttendance)->where(['sta_id'=>$id,'month'=>$month])->find();//当月打卡记录
        if(!empty($data)){
            $num = $data['days'];
            if($late){
                $late1 = $data['late'];
                (new UserLateTime)->create(['time'=>$late_time,'sta_id'=>$id]);
                (new UserAttendance)->where(['sta_id'=>$id,'month'=>$month])->update(['days'=>$num+1,'ymd'=>$ymd,'late'=>$late1+1]);
            }else{
                (new UserAttendance)->where(['sta_id'=>$id,'month'=>$month])->update(['days'=>$num+1,'ymd'=>$ymd]);
            }
        }else{
            if($late){
                (new UserLateTime)->create(['time'=>$late_time,'sta_id'=>$id]);
                (new UserAttendance)->create(['sta_id'=>$id,'month'=>$month,'days'=>1,'ymd'=>$ymd,'late'=>1]);
            }else{
                (new UserAttendance)->create(['sta_id'=>$id,'month'=>$month,'days'=>1,'ymd'=>$ymd]);
            }
        }
    }
    //查询
    public function Info($where){
        $row = (new UserAttendance)->where($where)->find();
        return empty($row)?[]:$row->toArray();
    }
}