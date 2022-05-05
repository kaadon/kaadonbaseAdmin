<?php

namespace app\api\controller;



use app\BaseController;
use app\common\model\ProductProject;
use app\common\model\UserClient;
use app\common\model\UserProject;
use app\admin\service\TriggerService;
use app\Request;
use think\facade\Db;

class Product extends Base
{

    /**
     * 项目提交
     * @param Request $request
     *@return string
     * @throws \Exception
     */
    public function submit(Request $request)
    {
        $param = $request->param();
        $cid = UserClient::info(['name'=>$param['username']]);

        Db::startTrans();
        try {
            if (empty($cid)){
                $cid = (new UserClient())->insertGetId([
                    'name'=>$param['username'],
                    'phone'=>$param['phone'],
                    'create_time'=>time(),
                    'update_time'=>'',
                    'from'=>$param['from']
                ]);
            }else{
                $cid = $cid['id'];
            }
            $uid = $param['uid'];
            $sid = $this->username;
            $product = [
                'title'=>$param['title'],
                'uid'=>$uid,
                'cid'=>$cid,
                'money'=>$param['money'],
                'pay'=>$param['pay'],
                'Reviewer'=>$param['Reviewer'],
                'remainder'=>$param['money']-$param['pay'],
                'consumption'=>$param['consumption'],
                'overtime_pay'=>$param['overtime_pay'],
                'begin_time'=>time(),
                'end_time'=>strtotime('10 day'),
                'create_at'=>time(),
                'update_at'=>'',
            ];
            $pro_id = (new ProductProject())->insertGetId($product);
            (new UserProject())->insert(['p_id'=>$pro_id,'s_id'=>$sid,'create_at'=>date('y-m-d H:i:s')]);
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            return $e->getMessage();
        }
        return success("添加成功");
    }

    //项目修改
    public function edit(Request $request){
        $param = $request->param();
        $pid = $param['id'];
        $cid = $param['cid'];
        $proData = ProductProject::info(['id'=>$pid]);
        $clientData = UserClient::info(['id'=>$cid]);
        Db::startTrans();
        try {
            if ($proData && $clientData){
                $res = ProductProject::where(['id'=>$pid])->update([
                    'cid'  => $param['cid'],
                    'title'=> $param['title'],
                    'uid'=> $param['uid'],
                    'Reviewer'=> $param['Reviewer'],
                    'money'=> $param['money'],
                    'pay'=> $param['pay'],
                    'remainder'=> $param['remainder'],
                    'consumption'=> $param['consumption'],
                    'update_at'=> time(),
                ]);
                UserClient::where(['id'=>$cid])->update([
                    'name' => $param['name'],
                    'phone' => $param['phone'],
                    'from' => $param['from'],
                    'update_time' => time(),
                ]);
            }
            Db::commit();
        }catch (\Exception $exception){
            Db::rollback();
            return $exception->getMessage();
        }
        return success('修改成功');
    }

    //项目删除
    public function delete($id)
    {
        $proData = ProductProject::info(['id'=>$id]);
        if(!$proData){
            return json_encode([
                'code'=>405,
                'msg'=> '没有这一条数据'
            ]);
        }
        Db::startTrans();
        try {
            UserClient::del(['id'=>$proData['cid']]);
            (new ProductProject())->del(['id'=>$id]);
            Db::commit();
        }catch (\Exception $exception){
            Db::rollback();
            return $exception->getMessage();
        }
        return success('删除成功');
    }

    //项目进度更新
    public function updatePro($p_id){
        if (!empty($p_id)){
            $data = (new UserProject())->where(['p_id'=>$p_id])->select();
            if ($data){
                Db::startTrans();
                try {
                    (new UserProject())->where(['p_id'=>$p_id])->update(['is_over'=>1]);
                    Db::commit();
                }catch (\Exception $exception){
                    Db::rollback();
                    return $exception->getMessage();
                }
                return success('更新成功');
            }
        }
    }
}
