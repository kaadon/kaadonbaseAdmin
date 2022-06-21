<?php


namespace app\common\service;


use app\common\controller\WalletController;
use app\common\model\UserAddress;
use app\common\model\UserPayorder;
use app\common\model\UserWallet;
use think\Exception;
use think\facade\Db;
use Usdtcloud\TronService\Address;
use Usdtcloud\TronService\TronApi;

class TransactionBlock
{
    public    $ChargeAddress;
    protected $withdraw;
    protected $mainNet;
    protected $Blocks;
    protected $Transaction;

    public function __construct()
    {
        $ChargeAddress  = Db::name('cmf_user_address')
            ->column('uid,cid,old', 'trc_address');
        $Charge_Address = [];
        if (!empty($ChargeAddress)) {
            foreach ($ChargeAddress as $key => $vo) {
                $Charge_Address[strtolower($key)] = $vo;
            }
        }
        $this->ChargeAddress = $Charge_Address;
        $this->mainNet = TronApi::mainNet();
    }

    public function setBlocks()
    {
        $startBlock = (int)Db::name('cmf_option')
            ->where('option_name', 'tron_block')
            ->value('option_value') ?: 39122454;
        $NowBlock   = TronApi::mainNet()->getNowBlock()->block_header->raw_data->number;
        if ($NowBlock) {
            if ($NowBlock - $startBlock > 20) {
                $EndBlock = $startBlock + 20;
            } else if ($NowBlock - $startBlock <= 1) {
                $EndBlock = 0;
            } else {
                $EndBlock = $NowBlock - 1;
            }
        } else {
            $EndBlock = 0;
        }

        $this->Blocks = [
            'start' => $startBlock,
            'end'   => $EndBlock,
            'now'   => $NowBlock,
        ];

        return $this;
    }

    public function checkBlock()
    {
        $Blocks = $this->Blocks;
        if (empty($Blocks) || $Blocks['start'] == 0 || $Blocks['end'] == 0) {
            throw new Exception('无可扫描的区块!');
        }
        var_dump('扫描区块开始!' . $Blocks['start'] . '-' . $Blocks['end']);
        $rpcBlock = TronApi::mainNet()->getBlockByLimitNext($Blocks['start'], $Blocks['end']);
        $rpcBlock = object_array($rpcBlock);
        $rows     = [];
        var_dump('数据循环开始!' . count($rpcBlock['block']) . '个块数据!');
        if (isset($rpcBlock['block']) && $rpcBlock['block']) {
            foreach ($rpcBlock['block'] as $key => $value) {
                $seek_num     = $value['block_header']['raw_data']['number'];
                $transactions = isset($value['transactions']) ? $value['transactions'] : '';
                if (!empty($transactions)) {
                    foreach ($transactions as $key => $value) {
                        $type = isset($value['raw_data']['contract'][0]['type']) ? $value['raw_data']['contract'][0]['type'] : '';
//                        if ($type == 'TriggerSmartContract') {
//                            $resDta = $this->TriggerSmartContract($value);
//                            if (!empty($resDta)) {
//                                if (empty($rows)) {
//                                    $rows = [$resDta];
//                                } else {
//                                    array_push($rows, $resDta);
//                                }
//                            }
//                        }
                        if ($type == 'TransferContract') {
                            $resDta = $this->TransferContract($value);
                            if (!empty($resDta)) {
                                if (empty($rows)) {
                                    $rows = [$resDta];
                                } else {
                                    array_push($rows, $resDta);
                                }
                            }
                        }
                    }
                }
            }
        }
        if (!empty($rows)) {
            $this->TransactionSave($rows);
        }

        Db::name('cmf_option')
            ->where('option_name', 'tron_block')
            ->update(['option_value' => (int)$this->Blocks['end']]);

        var_dump(date('Y-m-d h:i:s') . '已扫描到-' . $this->Blocks['end'] . '区块!最新区块' . $this->Blocks['now']);
    }

    public function TriggerSmartContract($value)
    {
        //
        $resData          = [];
        $contract_address = $value['raw_data']['contract'][0]['parameter']['value']['contract_address'];
        $txid             = $value['txID'];
        $data             = '';
        if (isset($value['raw_data']['contract'][0]['parameter']['value']['data'])) {
            $data = $value['raw_data']['contract'][0]['parameter']['value']['data'];
        }
        //判断是否是USDT,判断是否调用智能合约transfer函数
        if ($contract_address == '41a614f803b6fd780986a42c78ec9c7f77e6ded13c' && substr($data, 0, 8) == 'a9059cbb') {
            $hextoadd   = substr($data, 32, 40);
            $to_address = Address::encode('41' . $hextoadd);
            //判断转入地址是否用户地址
            if (isset($this->ChargeAddress[strtolower($to_address)])) {
                //转出地址
                $from_address = Address::encode($value['raw_data']['contract'][0]['parameter']['value']['owner_address']);
                //转入金额
                $amount = hexdec(preg_replace('/^0*/', '', substr($data, 72, 64))) / 1000000;
                if (isset($value['raw_data']['timestamp'])) $time = intval($value['raw_data']['timestamp'] / 1000);
                $resData['rid']             = $txid;
                $resData['hash_id']         = '';
                $resData['uid']             = $this->ChargeAddress[strtolower($to_address)]['uid'];
                $resData['cid']             = $this->ChargeAddress[strtolower($to_address)]['cid'];
                $resData['currency']        = 0;
                $resData['transfer_status'] = 0;
                $resData['status']          = $value['ret'][0]['contractRet'] == "SUCCESS" ? 1 : 0;
                $resData['number']          = $amount;
                $resData['time']            = '';
                $resData['reason']          = '';
                $resData['treaty']          = 'TRC20';
                $resData['is_read']         = 0;
                $resData['address']         = $from_address;
                $resData['to_address']              = $to_address;
                $resData['create_at']       = time();
                $resData['update_at']       = time();
            }
        }
        return $resData;
    }

    public function TransferAssetContract($value)
    {
        $resData = [];

        $amount       = number_format($value['raw_data']['contract'][0]['parameter']['value']['amount'] / 1000000, 6, '.', '');
        $txid         = $value['txID'];
        $from_address = Address::encode($value['raw_data']['contract'][0]['parameter']['value']['owner_address']);

        $to_address = Address::encode($value['raw_data']['contract'][0]['parameter']['value']['to_address']);

        if (isset($this->ChargeAddress[strtolower($to_address)])) {

            $tokenId = $value['raw_data']['contract'][0]['parameter']['value']['asset_name'];

            $token = TronApi::mainNet()->getAssetIssueById(Address::hexToStr($tokenId));

            $tokenname = Address::hexToStr($token->abbr);

            if (isset($value['raw_data']['timestamp'])) $time = intval($value['raw_data']['timestamp'] / 1000);
            $resData['rid']             = $txid;
            $resData['hash_id']         = $txid;
            $resData['uid']             = $this->ChargeAddress[$to_address];
            $resData['type']            = $tokenname;
            $resData['transfer_status'] = 0;
            $resData['treaty']          = 'TRC20';
            $resData['status']          = $value['ret'][0]['contractRet'] == "SUCCESS" ? 1 : 0;
            $resData['number']          = $amount;
            $resData['time']            = $time;
            $resData['reason']          = '';
            $resData['treaty']          = 'TRC_10';
            $resData['address']         = $from_address;
        }
        return $resData;
    }

    public function TransferContract($value)
    {

        $resData = [];

        $amount = number_format($value['raw_data']['contract'][0]['parameter']['value']['amount'] / 1000000, 6, '.', '');
        $txid   = $value['txID'];

        $from_address = Address::encode($value['raw_data']['contract'][0]['parameter']['value']['owner_address']);

        $to_address = Address::encode($value['raw_data']['contract'][0]['parameter']['value']['to_address']);

        if (isset($this->ChargeAddress[strtolower($to_address)])) {

            if (isset($value['raw_data']['timestamp'])) $time = intval($value['raw_data']['timestamp'] / 1000);
            $resData['rid']             = $txid;
            $resData['hash_id']         = '';
            $resData['uid']             = $this->ChargeAddress[strtolower($to_address)]['uid'];
            $resData['cid']             = $this->ChargeAddress[strtolower($to_address)]['cid'];
            $resData['currency']        = 1;
            $resData['transfer_status'] = 0;
            $resData['status']          = $value['ret'][0]['contractRet'] == "SUCCESS" ? 1 : 0;
            $resData['number']          = $amount;
            $resData['time']            = '';
            $resData['reason']          = '';
            $resData['treaty']          = 'TRX';
            $resData['is_read']         = 0;
            $resData['address']         = $from_address;
            $resData['to_address']              = $to_address;
            $resData['system_at']       = $time;
            $resData['create_at']       = time();
            $resData['update_at']       = time();
        }
        return $resData;
    }

    public function TransactionSave($rows)
    {
        foreach ($rows as $key => $row) {
            $is_have = Db::name('cmf_user_pay_order')
                ->where('rid', $row['rid'])
                ->find();
            if (!empty($is_have) || $row['number'] < 0.1) {
                unset($rows[$key]);
            }
        }

        if (count($rows) > 0) {
            Db::name('cmf_user_pay_order')
                ->insertAll($rows);
            //加分
            $this->addUserMoney($rows);
        }
    }

    public function addUserMoney($rows)
    {
        if (!empty($rows)) {
            foreach ($rows as $row) {
                    $this->jifenchange($row['uid'], array(
                        "msgid" => 800,
                        "bfb" => 0,
                        "obuserid" => $row['uid'],
                        "jifen" => $row['number'],
                        "jifentype" =>  'xjjifen',
                        "note" =>  $row['reason'],
                    ));
            }
        }
    }
    function jifenchange($id,$data)
    {

        if($data['jifen']==0)
        {
            return false;
        }

        $balance = Db::name('cmf_user_property')->field("cftjifen,xjjifen,jtjifen,dtjifen,cftajifen")->where('user_id',$id)->find();
        $balance[$data['jifentype']] = $balance[$data['jifentype']] + $data['jifen'];
        $balancejson    =   json_encode($balance);

        $rt = Db::name('cmf_jiangli')    ->insert(array(
                "userid"=>$id,
                "obuserid"=>$data['obuserid'],
                "msgid"=>$data['msgid'],
                "bfb"=>$data['bfb'],
                "value"=>$data['jifen'],
                "balance"=>$balancejson,
                "note"=>$data['note'],
                "buyid"=>isset($data['buyid'])?$data['buyid']:0,
                "time"=>time(),
                "jifentype"=>$data['jifentype'],
            )
        );
        var_dump($rt);
        if($rt)
        {
            Db::name('cmf_user_property')
                ->where('user_id',$id)
                ->inc($data['jifentype'],$data['jifen'])
                ->update();;

            return true;
        }
        return false;
    }
}

