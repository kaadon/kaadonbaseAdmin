<?php
declare (strict_types=1);

namespace app\merchant\controller;


use app\common\model\MemberAccount;
use app\common\model\MemberWallet;
use app\common\model\MerchantProfile;
use app\common\model\MerchantRcord;
use app\common\model\MerchantReport;
use app\merchant\BaseMerchant;
use app\merchant\middleware\jwtVerification;

class Member extends BaseMerchant
{
    protected $middleware
        = [
            jwtVerification::class => [
                'except' => []
            ]
        ];

    public function index()
    {

    }


    public function getMember()
    {
        $where = [];
        $page = $this->request->param('page/d', 1);
        $limit = $this->request->param('limit/d', 10);
        $agentLine = $this->request->merchant->id;
        
        if ($this->request->merchant->agentLv != "0"){
            $where = [['agent_line', 'like', "%|".$agentLine.'|%']];
        }else{
            $where = [['agent_line', '=', $this->request->merchant->agent_line.$this->request->merchant->id.'|']];
        }
        $status = $this->request->param('status/d',null);
        $agent = $this->request->param('agent/d', null);
        $start_time = $this->request->param('start_time/s', null);
        $end_time = $this->request->param('end_time/s', null);
        if (!is_null($start_time) && !is_null($end_time)){
            $where[] = ['create_time','>',$start_time];
            $where[] = ['create_time','<',$end_time];
        }
        if (!is_null($agent)){
            $where[] = ['agent_line', 'like', '%|' . $agent . '|%'];
        }
        if (!is_null($status)){
            $where[] = ['status','=',$status];
        }
        $PayOrder = MemberWallet::hasWhere('account',$where);

        $profile = $this->request->param('profile');
        if($profile){
            foreach ($profile as $key=> $item) {
                if (empty($item)){
                    unset($profile[$key]);
                }
            }
            if (count($profile) > 0){
                $PayOrder = $PayOrder->hasWhere('profile', $profile);
            }
        }

        $count = $PayOrder->count();

        $PayOrder = $PayOrder
            ->order('cny desc')
            ->page($page)
            ->limit($limit)
            ->select();

        foreach ($PayOrder as $key => $item) {
            $PayOrder[$key]->profile;
            $PayOrder[$key]->dashboard;
            $PayOrder[$key]->account;

            $agent_line = explode('|',$item->account->agent_line);

            $MerchantProfile_profile = MerchantProfile::whereIn('uid',$agent_line)->select();
            foreach ($MerchantProfile_profile as $skey => $item) {
                $MerchantProfile_profile[$skey]->account;
            }
            $PayOrder[$key]->agent = $MerchantProfile_profile->toArray();
        }

        $list = $PayOrder->toArray();

        $pages = ceil($count / $limit);

        $data['count'] = $count;
        $data['pages'] = $pages;
        $data['page']  = $page;
        $data['limit'] = $limit;
        $data['list']  = $list;

        return success($data);
    }
    public function getReport()
    {
        $page = $this->request->param('page/d', 1);
        $limit = $this->request->param('limit/d', 10);
        $where = $this->request->param();
        unset($where['page']);
        unset($where['limit']);
        $agentLine = $this->request->merchant->id;
//        var_dump($this->request->merchant);exit();
        if ($this->request->merchant->agentLv != "0"){
            $wheres = [['agent_line', 'like', "%|".$agentLine.'|%']];
        }else{
            $wheres = [['agent_line', '=', $this->request->merchant->agent_line.$this->request->merchant->id.'|']];
        }
        $status = $this->request->param('status/d',null);
        $agent = $this->request->param('agent/d', null);
        $start_time = $this->request->param('start_time/s', null);
        $end_time = $this->request->param('end_time/s', null);
        if (!is_null($start_time) && !is_null($end_time)){
            $wheres[] = ['create_time','>',$start_time];
            $wheres[] = ['create_time','<',$end_time];
        }
        if (!is_null($agent)){
            $wheres[] = ['agent_line', 'like', '%|' . $agent . '|%'];
        }
        if (!is_null($status)){
            $wheres[] = ['status','=',$status];
        }
        $PayOrder = MerchantReport::hasWhere('account',$wheres);
        $PayOrder = $PayOrder->where($where);
        $count = $PayOrder->count();
        $PayOrder = $PayOrder
            ->order('team_profit desc')
            ->page($page)
            ->limit($limit)
            ->select();
        foreach ($PayOrder as $key => $item) {
            $PayOrder[$key]->profile;
        }
        $list = $PayOrder->toArray();

        $pages = ceil($count / $limit);

        $data['count'] = $count;
        $data['pages'] = $pages;
        $data['page']  = $page;
        $data['limit'] = $limit;
        $data['list']  = $list;
        $data['explode']  = [
            'uid'=>'??????ID',
            'date'=>'??????',
            'team_member'=>'????????????',
            'team_lotter'=>'????????????',
            'team_valid_member'=>'??????????????????????????????15??????????????????',
            'team_withdraw'=>'????????????????????????????????????????????????',
            'team_profit'=>'???????????????????????????-?????????-???????????????-????????????????????????',
            'team_recharge'=>'????????????????????????????????????????????????????????????????????????',
            'team_money'=>'???????????????????????????????????????',
            'team_sizzler'=>'????????????????????????????????????-????????????????????? ',
            'team_event'=>'?????????????????????????????????-????????????????????? ',
        ];

        return success($data);
    }

    public function saveEdit()
    {
        $param = $this->request->param();
        if (!$param['id']) {
            return error('?????????????????????!');
        }
        $member = MemberAccount::find($param['id']);
        if (!$member) {
            return error('???????????????!');
        }
        if (strpos((string)$this->request->merchant->id, $member->agent_line)) {
            return error('?????????!');
        }
        $update = [];

        foreach ($param as $key => $item) {
            if (is_array($item)) {
                $member->$key->save($item);
            } else {
                if ($item == 0 || !empty($item)) {
                    $update[$key] = $item;
                }
            }
        }
        $member->save($update);

        return success('????????????!');
    }

    public function saveDelete(){
        $param = $this->request->param();
        if (!$param['id']) {
            return error('?????????????????????!');
        }
        $merchant = MemberAccount::find($param['id']);
        if (!$merchant) {
            return error('???????????????!');
        }
        if (strpos($param['id'], $merchant->agent_line)) {
            return error('?????????!');
        }
        $merchant->profile()->delete();
        $merchant->wallet()->delete();
        $merchant->dashboard()->delete();
        $merchant->delete();

        return success('????????????!');

//        }



    }

    public function saveAdd()
    {
        $result = (new \app\common\controller\member\Account())->add($this->request->param('mobile'),$this->request->param('password'),$this->request->merchant->uuid,1);
        if (!$result){
            return error('????????????!');
        }

        return success('????????????!');

    }
}
