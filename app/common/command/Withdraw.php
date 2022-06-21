<?php

namespace app\common\command;


use app\common\model\UserWithdraw;
use app\common\service\Integration;
use Exception;
use Swoole\Event;
use Swoole\Timer;
use think\console\Command;
use think\console\Input;
use think\console\Output;
use think\facade\Db;


class Withdraw extends Command
{
    protected function configure()
    {
        $this->setName('Withdraw')->setDescription("计划任务 用户提现");
    }

    //调用SendMessage 这个类时,会自动运行execute方法
    protected function execute(Input $input, Output $output)
    {
        $output->writeln(date('Y-m-d h:i:s') . '任务开始!');
        /*** 这里写计划任务列表集 START ***/
        Timer::tick(2 * 1000, function () {
            try {
                /*执行主体*/
                $this->waitingWithdraw();
            } catch (Exception $e) {
                var_dump($e->getMessage());
                var_dump($e->getTrace());
            };
        });
        /*** 这里写计划任务列表集 END ***/
        $output->writeln(date('Y-m-d h:i:s') . '任务结束!');
        Event::wait();

    }

    public function waitingWithdraw()
    {
        $settings = Db::name('cmf_option')
            ->where('option_name', 'tron_setting')
            ->value('option_value');
        if (empty($settings)){
            var_dump("配置为空! 请在后台设置配置!");
            return;
        }else{
            $settings = json_decode($settings,true);
        }

        $privateKey = $settings["withdraw_privateKey"];
        $address    = $settings["withdraw_address"];

        $waitings    = Db::name('cmf_withdraw')
            ->where('examine', 0)
            ->where('status', 1)
            ->select();
        $Integration = new Integration();
        if (!$waitings->isEmpty()) {

            foreach ($waitings as $waiting) {
                switch($waiting['jifentype']){
                    case 'USDTTRC20':   //usdt
                        $Trc20Balance = $Integration->getTrc20Balance(null, $address);
                        $Balance = $Integration->getBalance(null, $address);
                        if ($Balance < 10 || $Trc20Balance < $waiting['money']){
                            var_dump('向' . $waiting['user_id'] . '打款时候提现账户余额不足或者TRX不足!');
                            return;
                        }
                        $res = $Integration->trxTransfer($privateKey, $waiting['address'], $waiting['money']);

                        if ($res['result'] == 'true') {
                            Db::name('cmf_user_withdraw_order')
                            ->where('id', $waiting['id'])
                                ->update([
                                    'status' => 1,
                                    'time'   => time(),
                                    'rid'    => $res['txid'],
                                    'reason' => "打款成功!",
                                ]);
                            var_dump('向' . $waiting['id'] . '的地址' . $waiting['uid'] . '打款' . $waiting['money'] . '成功!');
                        } else {
                            Db::name('cmf_user_withdraw_order')
                            ->where('id', $waiting['id'])
                                ->update([
                                    'reason' => "打款失败!",
                                    'time'   => time(),
                                    'status' => 4
                                ]);
                        }
                        break;
                    case 'xjjifen':   //TRX
                        $Balance = $Integration->getBalance(null, $address);
                        if ($Balance < $waiting['num']){
                            var_dump('向' . $waiting['user_id'] . '打款时候提现账户TRX不足!');
                            return;
                        }

                        $res = $Integration->transfer($privateKey, $waiting['address'], $waiting['num']);

                        if ($res['result'] == 'true') {
                            Db::name('cmf_withdraw')
                            ->where('id', $waiting['id'])
                                ->update([
                                    'examine' => 1,
                                    'time'   => time(),
                                    'hash_id'    => $res['txid'],
                                    'note' => "打款成功!",

                                ]);
                            var_dump('向' . $waiting['user_id'] . '的地址' . $waiting['address'] . '打款' . $waiting['num'] . '成功!');
                        } else {
                            Db::name('cmf_withdraw')
                                ->where('id', $waiting['id'])
                                ->update([
                                    'note' => "打款失败!",
                                    'time'   => time(),
                                    'examine' => 2
                                ]);
                        }
                        break;
                    default:
                        var_dump('提现币种不正确!');
                }
            }
        } else {
            var_dump('没有打款项目!');
        }
    }
}