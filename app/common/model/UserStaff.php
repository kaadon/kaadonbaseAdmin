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

use think\db\exception\DataNotFoundException;
use think\db\exception\DbException;
use think\db\exception\ModelNotFoundException;
use think\Model;
use function Composer\Autoload\includeFile;

class UserStaff extends TimeModel
{
    protected $table = "ea_user_staff";

    //员工添加
    public static function add($data)
    {
        $data['password'] = password_hash($data['password'],PASSWORD_DEFAULT);

        return UserStaff::create($data);
    }

    //获取全部员工数据
    public static function getStaffData(): array
    {
        $row = (new UserStaff)::select();
        return empty($row)?[]:$row->toArray();
    }

    //查数据
    public static function info($where): array
    {
        $row = (new UserStaff)->where($where)->find();
        return empty($row)?[]:$row->toArray();
    }

    //删除
    public function del(array $where)
    {
        try {
            (new UserStaff)->where($where)->delete();
        } catch (DataNotFoundException|ModelNotFoundException|DbException $e) {
            return json_encode(['code'=>203,'msg'=>'删除失败']);
        }
        return json_encode(['code'=>200,'msg'=>'删除成功']);
    }
}