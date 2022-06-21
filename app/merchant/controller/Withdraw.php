<?php
declare (strict_types=1);

namespace app\merchant\controller;


use app\common\model\MemberWithdrawOrder;
use app\merchant\BaseMerchant;
use app\merchant\middleware\jwtVerification;

class Withdraw extends BaseMerchant
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


    public function getWithdraw()
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


        $PayOrder = MemberWithdrawOrder::hasWhere('account', $wheres);

        $agent = $this->request->param('agent/d', null);
        if (!is_null($agent)){
            $PayOrder = $PayOrder->hasWhere('account', [['agent_line', 'like', '%|' . $agent . '|%']]);
        }

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

        $where = [];
        $status = $this->request->param('status/d',null);
        if (!is_null($status)){
            $where['examine'] = $status;
        }
        $PayOrder = $PayOrder->where($where);

        $count = $PayOrder->count();

        $PayOrder = $PayOrder
            ->page($page)
            ->limit($limit)
            ->order('id desc')
            ->select();
//        var_dump((new MemberWithdrawOrder())->getLastSql());
        foreach ($PayOrder as $key => $item) {
            $PayOrder[$key]->profile;
            $PayOrder[$key]->payment;
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
