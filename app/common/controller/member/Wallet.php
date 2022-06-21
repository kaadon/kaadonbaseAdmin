<?php

namespace app\common\controller\member;

use app\common\controller\MemberController;
use app\common\model\MemberAccount;
use app\common\model\MemberDashboard;
use app\common\model\MemberProfile;
use app\common\model\MemberRecord;
use app\common\model\MemberWallet;
use app\common\model\MerchantAccount;
use app\common\model\MerchantDashboard;
use app\common\service\Uuids;
use think\Exception;
use think\facade\Db;

class Wallet extends MemberController
{
    public function __construct()
    {

    }

    /**
     * @param $username
     * @param $business
     * @param $data
     * @param null $x_uid
     * @param null $type
     * 调整余额并增加流水记录
     * @throws \think\Exception
     */
    public function change($username, $business, $data, $x_uid = null, $type = null)//$type团队级别
    {
        // 货币配置
        // 循环数据
        foreach ($data as $key => $item) {
            // 数据不对
            if (count($item) != 3) {
                throw new Exception("数据格式错误");
            }
            // 保存数据
            $row = [
                'mid' => $username,
                'currency' => $key,
                'business' => $business,
                'before'   => $item[0],
                'now'      => $item[1],
                'after'    => $item[2],
            ];
            if (!empty($type)){
                $row['team'] = $type;
            }
            if (!empty($x_uid)){
                $row['x_uid'] = $x_uid;
            }
            $analog = MemberAccount::where([['id','=',$username]])->value('analog');
            if ($analog == "0"){
                // 添加流水
                MemberRecord::setAdd($row);
//            var_dump($currencys);var_dump($key);
                switch ($business){
                    case 1:
                        MemberDashboard::where(['mid' => $username])
                            ->inc('user_profit',abs($item[1]))
                            ->inc('day_recharge',abs($item[1]))
                            ->inc('user_recharge',abs($item[1]))
                            ->update();
                        break;
                    case 2:
                        MemberDashboard::where(['mid' => $username])
                            ->dec('user_profit',abs($item[1]))
                            ->inc('day_withdraw',abs($item[1]))
                            ->inc('user_withdraw',abs($item[1]))
                            ->inc('user_withdraw_examine',abs($item[1]))
                            ->update();
                        break;
                    case 3:
                        MemberDashboard::where(['mid' => $username])
                            ->inc('day_event_profit',abs($item[1]))
                            ->dec('day_event',abs($item[1]))
                            ->update();
                        break;
                    case 4:
                        MemberDashboard::where(['mid' => $username])
                            ->inc('day_event_number',1)
                            ->inc('day_event_money',abs($item[1]))
                            ->inc('day_event',abs($item[1]))
                            ->update();
                        break;
                    case 5:
                        MemberDashboard::where(['mid' => $username])
                            ->inc('user_profit',abs($item[1]))
                            ->dec('user_withdraw',abs($item[1]))
                            ->dec('user_withdraw_examine',abs($item[1]))
                            ->update();
                        break;
                    case 7:
                        MemberDashboard::where(['mid' => $username])
                            ->inc('day_sizzler_profit',abs($item[1]))
                            ->dec('day_sizzler',abs($item[1]))
                            ->update();
                        break;
                    case 8:
                        MemberDashboard::where(['mid' => $username])
                            ->inc('day_sizzler_number',1)
                            ->inc('day_sizzler_money',abs($item[1]))
                            ->inc('day_sizzler',abs($item[1]))
                            ->update();
                        break;
                    case 10:
                        MemberDashboard::where(['mid' => $username])
                            ->inc('user_lotter',abs($item[1]))
                            ->update();
                        break;
                }
                MerchantDashboard::dashboard($username,$business,$item[1]);
                // 货币不存在
//            if (!array_key_exists($key, $currencys)) {
//                throw new HttpAnomaly(lang::Get('noCurrency'));
//            }
                // 得到字段
                // 保存金额
            }
            $bool = MemberWallet::where(['mid' => $username])->save(['cny'=>$item[2]]);
        }
        // 更新钱包
        // if (empty($bool)) {
        //     throw new \think\Exception(lang::Get('noWallet'));
        // }
    }

}