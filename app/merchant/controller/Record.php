<?php


namespace app\merchant\controller;

use app\common\model\GameEventBet;
use app\common\model\GameEventList;
use app\common\model\GameLotteryBet;
use app\common\model\GameSizzlerBet;
use app\common\model\MemberRecord;
use app\merchant\BaseMerchant;
use app\merchant\middleware\jwtVerification;

class Record extends BaseMerchant
{
    protected $middleware
        = [
            jwtVerification::class => [
                'except' => []
            ]
        ];
    public function getRecord()
    {

        $where = [];

        $page = $this->request->param('page/d', 1);

        $limit = $this->request->param('limit/d', 10);

        $agentLine = $this->request->merchant->id;
        if ($this->request->merchant->agentLv != "0"){
            $wheres = [['agent_line', 'like', "%|".$agentLine.'|%']];
        }else{
            $wheres = [['agent_line', '=', $this->request->merchant->agent_line.$this->request->merchant->id.'|']];
        }

        $PayOrder = MemberRecord::hasWhere('account', $wheres);

        $agent = $this->request->param('agent/d', null);
        if (!is_null($agent)) {
            $PayOrder = $PayOrder->hasWhere('account', [['agent_line', 'like', '%|' . $agent . '|%']]);
        }

        $profile = $this->request->param('profile');
        if ($profile) {
            foreach ($profile as $key => $item) {
                if (empty($item)) {
                    unset($profile[$key]);
                }
            }
            if (count($profile) > 0) {
                $PayOrder = $PayOrder->hasWhere('profile', $profile);
            }
        }

        $where  = [];
        $status = $this->request->param('status/d', null);
        if (!is_null($status)) {
            $where['status'] = $status;
        }
        $PayOrder = $PayOrder->where($where);

        $count = $PayOrder->count();

        $PayOrder = $PayOrder->page($page)
            ->limit($limit)
            ->order('id desc')
            ->select();
        $bus      = [1 => "充值", 2 => "提现", 3 => "赛事中奖", 4 => "赛事投注", 5 => "提现退回", 6 => "后台充值", 7 => "时时乐中奖", 8 => "时时乐投注",
                     9 => '系统退回',
                     10 => '彩票投注',
                     11 => '彩票退回',
                     ];
        foreach ($PayOrder as $key => $item) {
            $PayOrder[$key]->profile;
            $PayOrder[$key]->payment;
            $PayOrder[$key]->business = $bus[$item->business];
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
    public function getGameLolRecord()
    {

        $where = [];

        $page = $this->request->param('page/d', 1);

        $limit = $this->request->param('limit/d', 10);

        $agentLine = $this->request->merchant->id;
        if ($this->request->merchant->agentLv != "0"){
            $wheres = [['agent_line', 'like', "%|".$agentLine.'|%']];
        }else{
            $wheres = [['agent_line', '=', $this->request->merchant->agent_line.$this->request->merchant->id.'|']];
        }

        $PayOrder = GameEventBet::hasWhere('account', $wheres);

        $agent = $this->request->param('agent/d', null);
        if (!is_null($agent)) {
            $PayOrder = $PayOrder->hasWhere('account', [['agent_line', 'like', '%|' . $agent . '|%']]);
        }

        $profile = $this->request->param('profile');
        if ($profile) {
            foreach ($profile as $key => $item) {
                if (empty($item)) {
                    unset($profile[$key]);
                }
            }
            if (count($profile) > 0) {
                $PayOrder = $PayOrder->hasWhere('profile', $profile);
            }
        }

        $where  = [];
        $status = $this->request->param('status/d', null);
        if (!is_null($status)) {
            $where['is_ok'] = $status;
        }
        $start_time = $this->request->param('start_time/s', null);
        $end_time = $this->request->param('end_time/s', null);
        if (!is_null($start_time) && !is_null($end_time)){
            $where[] = ['GameEventBet.create_time','>',$start_time];
            $where[] = ['GameEventBet.create_time','<',$end_time];
        }
        $PayOrder = $PayOrder->where($where);

        $count = $PayOrder->count();

        $PayOrder = $PayOrder->page($page)
            ->limit($limit)
            ->order('id desc')
            ->select();
        foreach ($PayOrder as $key => $item) {
            $PayOrder[$key]->profile;
            $PayOrder[$key]->gameList;
            $PayOrder[$key]->rule;
            $PayOrder[$key]->game_List = GameEventList::where('id',$PayOrder[$key]->gameList->toArray()['list_id'])->find()->toArray();
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
    public function getSizzlerRecord()
    {

        $where = [];

        $page = $this->request->param('page/d', 1);

        $limit = $this->request->param('limit/d', 10);

        $agentLine = $this->request->merchant->id;
        if ($this->request->merchant->agentLv != "0"){
            $wheres = [['agent_line', 'like', "%|".$agentLine.'|%']];
        }else{
            $wheres = [['agent_line', '=', $this->request->merchant->agent_line.$this->request->merchant->id.'|']];
        }

        $PayOrder = GameSizzlerBet::hasWhere('account', $wheres);

        $agent = $this->request->param('agent/d', null);
        if (!is_null($agent)) {
            $PayOrder = $PayOrder->hasWhere('account', [['agent_line', 'like', '%|' . $agent . '|%']]);
        }

        $record = $this->request->param('record');
        if ($record) {
            foreach ($record as $key => $item) {
                if (empty($item)) {
                    unset($record[$key]);
                }
            }
            if (count($record) > 0) {
                $PayOrder = $PayOrder->hasWhere('record', $record);
            }
        }

        $profile = $this->request->param('profile');
        if ($profile) {
            foreach ($profile as $key => $item) {
                if (empty($item)) {
                    unset($profile[$key]);
                }
            }
            if (count($profile) > 0) {
                $PayOrder = $PayOrder->hasWhere('profile', $profile);
            }
        }


        $where  = [];
        $status = $this->request->param('status/d', null);
        if (!is_null($status)) {
            $where['is_ok'] = $status;
        }
        $start_time = $this->request->param('start_time/s', null);
        $end_time = $this->request->param('end_time/s', null);
        if (!is_null($start_time) && !is_null($end_time)){
            $where[] = ['GameSizzlerBet.create_time','>',$start_time];
            $where[] = ['GameSizzlerBet.create_time','<',$end_time];
        }
        $PayOrder = $PayOrder->where($where);

        $count = $PayOrder->count();

        $PayOrder = $PayOrder->page($page)
            ->limit($limit)->order('id desc')->select();
        foreach ($PayOrder as $key => $item) {
            $PayOrder[$key]->record;
            $PayOrder[$key]->profile;
            $PayOrder[$key]->hero;
            $PayOrder[$key]->rule;
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
    public function getLotterRecord()
    {

        $where = [];

        $page = $this->request->param('page/d', 1);

        $limit = $this->request->param('limit/d', 10);

        $agentLine = $this->request->merchant->id;
        if ($this->request->merchant->agentLv != "0"){
            $wheres = [['agent_line', 'like', "%|".$agentLine.'|%']];
        }else{
            $wheres = [['agent_line', '=', $this->request->merchant->agent_line.$this->request->merchant->id.'|']];
        }

        $PayOrder = GameLotteryBet::hasWhere('account', $wheres);

        $agent = $this->request->param('agent/d', null);
        if (!is_null($agent)) {
            $PayOrder = $PayOrder->hasWhere('account', [['agent_line', 'like', '%|' . $agent . '|%']]);
        }

        $record = $this->request->param('record');
        if ($record) {
            foreach ($record as $key => $item) {
                if (empty($item)) {
                    unset($record[$key]);
                }
            }
            if (count($record) > 0) {
                $PayOrder = $PayOrder->hasWhere('record', $record);
            }
        }

        $profile = $this->request->param('profile');
        if ($profile) {
            foreach ($profile as $key => $item) {
                if (empty($item)) {
                    unset($profile[$key]);
                }
            }
            if (count($profile) > 0) {
                $PayOrder = $PayOrder->hasWhere('profile', $profile);
            }
        }


        $where  = [];
        $status = $this->request->param('status/d', null);
        if (!is_null($status)) {
            $where['GameLotteryBet.status'] = $status;
        }
        $start_time = $this->request->param('start_time/s', null);
        $end_time = $this->request->param('end_time/s', null);
        if (!is_null($start_time) && !is_null($end_time)){
            $where[] = ['GameLotteryBet.create_time','>',$start_time];
            $where[] = ['GameLotteryBet.create_time','<',$end_time];
        }
        $PayOrder = $PayOrder->where($where);

        $count = $PayOrder->count();

        $PayOrder = $PayOrder->page($page)
            ->limit($limit)->order('id desc')->select();
        foreach ($PayOrder as $key => $item) {
            $PayOrder[$key]->record;
            $PayOrder[$key]->profile;
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

}