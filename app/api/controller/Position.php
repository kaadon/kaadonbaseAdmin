<?php

namespace app\api\controller;

use app\BaseController;
use app\common\model\UserPosition;
use app\Request;
use think\facade\Db;
use function Sodium\add;

class Position extends BaseController
{

    /**
     * 职位管理
     * @return string
     * @throws \Exception
     */
    public function index()
    {
    }

    /**
     * 职位添加
     * @param Request $request
     * @return string
     * @throws \Exception
     */
    public function submit(Request $request)
    {
        $param = $request->param();
        $position = [
            'pid' => $param['pid'],
            'position_name' => $param['position_name']
        ];

        Db::startTrans();
        try {
            (new UserPosition())->add($position);
            Db::commit();
        } catch (\Exception $e) {
            Db::rollback();
            return $e->getMessage();
        }
        return success("添加成功");
    }

    //职位修改
    public function edit(Request $request)
    {
        $param = $request->param();
        $id = $param['id'];
        Db::startTrans();
        try {
            $data = [
                'pid' => $param['pid'],
                'position_name' => $param['position_name']
            ];
            (new UserPosition())->where('id',$id)->update($data);
            Db::commit();
        } catch (\Exception $exception) {
            Db::rollback();
            return $exception->getMessage();
        }
        return success('修改成功');
    }

    //职位删除
    public function delete($id)
    {
        $Data = UserPosition::info(['id' => $id]);
        if (!$Data) {
            return json_encode([
                'code' => 405,
                'msg' => '没有这一条数据'
            ]);
        }
        Db::startTrans();
        try {
            UserPosition::del(['id' => $Data['id']]);
            Db::commit();
        } catch (\Exception $exception) {
            Db::rollback();
            return $exception->getMessage();
        }
        return success('删除成功');
    }

}
