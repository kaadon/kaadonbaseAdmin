<?php

namespace app\api\controller;



use app\api\validate\UserValidate;
use app\BaseController;
use app\common\model\ProductProject;
use app\common\model\UserClient;
use app\common\model\UserStaff;
use app\admin\service\TriggerService;
use app\Request;
use think\exception\ValidateException;
use think\facade\Db;
use think\facade\Lang;
use think\response\Json;

class Staff extends BaseController
{

    /**
     * 员工注册
     * @return string
     */
    public function register(): string
    {
        $data = [
            'head_img'    => $this->request->param('head_img', null),
            'name'    => $this->request->param('name', null),
            'password'    => $this->request->param('password', null),
            'p_id'     => $this->request->param('p_id', null),
            'phone' => $this->request->param('phone', null),
            'account' => $this->request->param('account', null),
            'create_time' => date('Y-m-d H:i:s',time()),
            'update_time' => '',
            'delete_time' => '',
        ];
        $scene = "staffRegister";
        try {
            validate(UserValidate::class)
                ->scene($scene)
                ->check($data);
        } catch (ValidateException $e) {
            return error($e->getError());
        }
        //        开启事物
        (new Db)->startTrans();
        try {
            $res = (new UserStaff())->add($data);
            if ($res){
                (new Db)->commit();
                return success(lang::Get('registerSuccess'));
            }
        } catch (\Exception $e) {
            (new Db)->rollback();
            return error($e->getMessage(), 201, 200, $e->getTrace());
        }
    }

    //员工删除
    public function delete($id)
    {
        $Data = UserStaff::info(['id'=>$id]);
        if(!$Data){
            return json([
                'code'=>4004,
                'msg'=> '没有这一条数据'
            ]);
        }
        return (new UserStaff)->del(['id'=>$id]);
    }
}
