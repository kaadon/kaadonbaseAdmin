<?php

namespace app\common\command;


use app\common\model\UserPayorder;
use app\common\service\Integration;
use Exception;
use Swoole\Event;
use think\console\Command;
use think\console\Input;
use think\console\Output;
use Swoole\Timer;
use think\facade\Db;


class IntegrationFromUser extends Command
{
    protected function configure()
    {
        $this->setName('IntegrationFromUser')->setDescription("计划任务 归集");
    }

    //调用SendMessage 这个类时,会自动运行execute方法
    protected function execute(Input $input, Output $output)
    {
        $output->writeln(date('Y-m-d h:i:s') . '任务开始!');
        /*** 这里写计划任务列表集 START ***/
        Timer::tick(10 * 1000, function () {
            try {

                /*执行主体*/
                $this->Transfer();
            } catch (Exception $e) {
                var_dump($e->getMessage());
                var_dump($e->getTrace());
            }
        });
        /*** 这里写计划任务列表集 END ***/

        $output->writeln(date('Y-m-d h:i:s') . '任务结束!');

        Event::wait();
    }

    public function Transfer()
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

        $waitingAssemblages = Db::name('cmf_user_pay_order')
            ->where('transfer_status', 0)
            ->where('status', 1)
            ->where('number', '>', 0)
            ->select();
        if (!empty($waitingAssemblages)) {
            $Integration = new Integration();

            $IntegrationAddress = $settings["gather_address"];
            if (empty($IntegrationAddress)) {
                var_dump('归集地址为空!');
                return;
            }
            foreach ($waitingAssemblages as $waitingAssemblage) {
                $useraddress = Db::name('cmf_user_address')
                    ->where([
                        'uid' => $waitingAssemblage['uid'],
                        'cid' => $waitingAssemblage['cid'],
                    ])
                    ->field('trc_address,trc20_pv,old,id')
                    ->find();
                $address     = $useraddress['trc_address'];
                $privateKey  = $useraddress['trc20_pv'];
                $TRXBalance  = $Integration->getBalance(null, $address);

                switch ($waitingAssemblage['currency']) {
                    case 0://usdt
                        $Balance = $Integration->getTrc20Balance($privateKey, $address);
                        if ($Balance >= 0) {
                            //trx 余额
                            if ($TRXBalance >= 6) {
                                $trxTransfer = $Integration->trxTransfer($privateKey, $IntegrationAddress, $Balance);
                                if ($trxTransfer['result']) {
                                    Db::name('cmf_user_pay_order')
                                        ->where('id', $waitingAssemblage['id'])
                                        ->update([
                                            'transfer_status' => 1,
                                            'time'            => time(),
                                            'hash_id'         => $trxTransfer['txid']
                                        ]);
                                    if ($useraddress['old'] == 1) {
                                        Db::name('cmf_user_address')
                                            ->where('id', $useraddress['id'])
                                            ->update([
                                                'old' => 1
                                            ]);
                                    }
                                } else {
                                    var_dump('归集时候没有足够的手续费!');
                                    return;
                                }
                            } else {
                                $withdraw_privateKey = $settings['withdraw_privateKey'];
                                if (!empty($withdraw_privateKey)) {
                                    var_dump('提现地址没有设置!');
                                    return;
                                }
                                $trx = $Integration->Transfer($withdraw_privateKey, $address, 8);
                                if (!$trx['result']) {
                                    var_dump('官方手续费账户没有足够的TRX!');
                                    return;
                                }
                            }
                        }
                        break;
                    case 1://TRX
                        if ($useraddress['old'] == 1) {

                            if ($TRXBalance  - 0.5 < 0){
                                var_dump('  账户余额不足! 新账号需预留0.5个作为手续费使用');
                                Db::name('cmf_user_pay_order')
                                    ->where('id', $waitingAssemblage['id'])
                                    ->update([
                                        'transfer_status' => 2,
                                        'time'            => time(),
                                    ]);
                                return;
                            }
                            $amount = $TRXBalance - 0.5;
                            $trxGather = $Integration->Transfer($privateKey, $IntegrationAddress, $amount);
                            if (!$trxGather['result']) {
                                var_dump('归集失败!number="' . $amount . '"');
                                var_dump($amount);
                                return;
                            }else{
                                Db::name('cmf_user_pay_order')
                                    ->where('id', $waitingAssemblage['id'])
                                    ->update([
                                        'transfer_status' => 1,
                                        'time'            => time(),
                                        'hash_id'         => $trxGather['txid']
                                    ]);
                                var_dump($waitingAssemblage['uid'] .' - ' . $waitingAssemblage['cid'] . '归集成功!');
                            }
                        } else {
                            if ($TRXBalance - 1.1 < 0){
                                var_dump('  账户余额不足! 新账号需预留1.1个作为激活账号使用');
                                Db::name('cmf_user_pay_order')
                                    ->where('id', $waitingAssemblage['id'])
                                    ->update([
                                        'transfer_status' => 2,
                                        'time'            => time(),
                                    ]);
                                return;
                            }
                            $trxGather = $Integration->Transfer($privateKey, $IntegrationAddress, (float)$TRXBalance - 1.1);
                            var_dump($trxGather);
                            if (!$trxGather['result']) {
                                var_dump('归集失败1!');
                                return;

                            } else {
                                Db::name('cmf_user_pay_order')
                                    ->where('id', $waitingAssemblage['id'])
                                    ->update([
                                        'transfer_status' => 1,
                                        'time'            => time(),
                                        'hash_id'         => $trxGather['txid']
                                    ]);
                                Db::name('cmf_user_address')
                                    ->where('id', $useraddress['id'])
                                    ->update([
                                        'old' => 1
                                    ]);
                                var_dump($waitingAssemblage['uid'] .' - ' . $waitingAssemblage['cid'] . '归集成功!');

                            }

                        }
                        break;
                    default:
                        var_dump('不正确!');
                }
            }
        }
    }


}