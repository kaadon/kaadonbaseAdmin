<?php
namespace app\api\controller;

use app\BaseController;
use app\common\model\UserAttendance;
use app\common\model\UserStaff;
use app\common\model\UserPosition;
use app\common\model\UserProject;
use app\common\model\ProductProject;
use app\common\model\UserLateTime;
use think\facade\Db;
use think\facade\View;
use think\App;
use think\Exception;
use think\facade\Lang;


class Index extends Base
{
 public function index()
    {
        //21的是员工管理员账号
        if ($this->username == 22){
            $data = $this->adminSalary();
            View::assign('data' , $data);
            return View::fetch();
        }
        $data = $this->salary();
        View::assign('data' , $data);
        return View::fetch('index1');
    }
    //薪资详情
    public function details($sta_id){
        $month = date('m');
        $staData = (new UserStaff())->info(['id'=>$sta_id]);
        $mixSalary = (new UserPosition())->info(['id'=>$staData['p_id']])['salary'];//底薪
        $Attendance = (new UserAttendance())->Info(['sta_id'=>$sta_id,'month'=>$month]);
        $data = (new UserProject)->Infos(['s_id'=>$sta_id,'is_over'=> 1,'is_settlement'=>0]);//员工对应的所有完工的项目,参与结算的
        $timeData = (new UserLateTime())->where(['sta_id'=>$sta_id])->select();
        $days = 0;//出勤天数
        $late = 0;//迟到次数
        $num = 0;//项目提成
        if ($Attendance){
            $days = $Attendance['days'];//出勤天数
            $late = $Attendance['late'];//迟到次数
        }
        $allSalary = $mixSalary;
        if ($data){
            foreach ($data as $v){
                $rpoData = ProductProject::Infos(['id'=>$v['p_id']]);//员工对应的具体项目
                foreach ($rpoData as $val){
                    $money = $val['money'];
                }
                $num += $money / 100;//项目提成1%
            }
            $allSalary = $allSalary + $num;
        }
        //有全勤
        if ($days >= 25){
            $allSalary = $allSalary + 500.00;
        }
        //有迟到
        if($late){
            $allSalary = $allSalary - $late * 10;//迟到一次扣10
        }
        $allSalary = sprintf("%.2f",$allSalary);
        $detail = [
            'mixSalary' => $mixSalary,
            'days' => $days,
            'late' => $late,
            'timeData' => $timeData,
            'num' => $num,
            'allSalary' => $allSalary
        ];
        View::assign('data',$detail);
        return View::fetch('details');
    }

    //签到打卡
    public function signIn(){
        $month = date('m');
        $ymd = date('d');
        $status = date('H:i:s');
        if ($status > "09:00:00" and $status <= "09:30:59"){
            if ((new UserAttendance())->Info(['sta_id'=>$this->username,'ymd'=>$ymd,'month'=>$month])){
                return '今日已签到';
            }
            Db::startTrans();
            try {
                /*执行主体*/
                (new UserAttendance())->setAdd($this->username,$month,$ymd);
                /*提交事务*/
                Db::commit();
            }catch (Exception $exception){
                /*回滚事务操作*/
                Db::rollback();
                return error(lang::Get('signInError'));
            }
            return success(lang::Get('signInSuccess')) ;
        }else if($status > "09:30:59" and $status < "10:00:59"){
            if ((new UserAttendance())->Info(['sta_id'=>$this->username,'ymd'=>$ymd,'month'=>$month])){
                return '今日已签到';
            }
            $late = 1;
            $late_time = date('y-m-d H:i:s');
            (new UserAttendance())->setAdd($this->username,$month,$ymd,$late,$late_time);
            return json_encode([
                'code' => '203',
                'msg'  => '迟到打卡'
            ]);
        }else{
            return json_encode([
                'code' => '202',
                'msg'  => '不在打卡时间段'
            ]);
        }
     }

    /**
     * 员工薪资
     */
    public function salary($status=0,$user_id=0){
        $month = date('m');
         if ($status){
             $Attendance =(new UserAttendance())->Info(['sta_id'=>$user_id,'month'=>$month]);//出勤表数据
             $staData = (new UserStaff())->info(['id'=>$user_id]);//员工数据
             $data = (new UserProject)->Infos(['s_id'=>$user_id,'is_over'=> 1,'is_settlement'=>0]);//员工对应的所有完工的未结算的项目
         }else{
             $Attendance =(new UserAttendance())->Info(['sta_id'=>$this->username,'month'=>$month]);//出勤表数据
             $staData = (new UserStaff())->info(['id'=>$this->username]);//员工数据
             $data = (new UserProject)->Infos(['s_id'=>$this->username,'is_over'=> 1,'is_settlement'=>0]);//员工对应的所有完工的未结算的项目
         }
        if (!$data){
            $data = [];
        }
             $mixSalary = (new UserPosition())->info(['id'=>$staData['p_id']])['salary'];//底薪
             $Salary = $mixSalary;//底薪工资
             $num = 0;
             if ($data){
                 //有提成
                 foreach ($data as $v){
                     $rpoData = ProductProject::Infos(['id'=>$v['p_id']]);//员工对应完工具体项目
                     foreach ($rpoData as $val){
                         $money = $val['money'];
                     }
                     $num += $money / 100;//项目提成
                 }
                 $Salary = $Salary + $num;//底薪加提成
                 if ($Attendance && $Attendance['days'] >= 25){
                     $Salary = $Salary + 500.00;//有全勤加500
                 }
                 if ($Attendance && $Attendance['late']){
                     $Salary = $Salary - ($Attendance['late'] * 10);//有迟到减
                 }
             }else{
                 //没提成
                 if ($Attendance && $Attendance['days'] >= 25){
                     $Salary = $Salary + 500.00;//有全勤
                 }
                 if ($Attendance && $Attendance['late']){
                     $Salary = $Salary - ($Attendance['late'] * 10);//有迟到
                 }
             }
            $Salary = sprintf("%.2f",$Salary);
             $data = [
                 'sta_id' => $staData['id'],
                 'name' =>  $staData['name'],
                 'Salary' => $Salary
             ];
             return $data;
    }
    /**
     * 管理员查询全部员工薪资
     */
    public function adminSalary(){
            $status = 1;
            $data = (new UserStaff())->select();
            $all = [];
            foreach ($data as $k => $v){
                $user_id = $v['id'];
                $allSalary  = $this->salary($status,$user_id);
                $all[$k] = $allSalary;
            }
            return $all;
    }
}
