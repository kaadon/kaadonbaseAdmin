<?php
declare (strict_types=1);

namespace app\merchant\controller;


use app\common\controller\merchant\Account;
use app\common\model\GameEventBet;
use app\common\model\GameLotteryBet;
use app\common\model\MemberAccount;
use app\common\model\MemberRecord;
use app\common\model\MerchantAccount;
use app\common\model\MerchantDashboard;
use app\common\model\MerchantProfile;
use app\common\validate\UserValidate;
use app\merchant\BaseMerchant;
use app\merchant\middleware\jwtVerification;
use app\merchant\validate\MerchantValidate;
use think\exception\ValidateException;

class Index extends BaseMerchant
{
    protected $middleware
        = [
            jwtVerification::class => [
                'except' => ['register', 'login', 'index']
            ]
        ];

    public function index()
    {

    }
    
    public function register()
    {
        $data         = [];
        $data['type'] = $this->request->post('type/s');
        if (empty($data['type'])) {
            return error('注册类型不能为空!');
        }
        $data['password'] = $this->request->post('password/s');
        $data['safeword'] = $this->request->post('safeword/s', '123456');
        $inviter          = $this->request->post('inviter/s', null);
        if ($inviter) {
            $data['inviter'] = $inviter;
        }
        switch ($data['type']) {
            case 'email':
                $data['email'] = $this->request->post('email/s');
                break;
            case 'mobile':
                $data['mobile'] = $this->request->post('mobile/d');
                break;
            default:
                return error('请重新提交');
        }
        try {
            /*执行主体*/
            $result = (new User())->add($data);
        } catch (\Exception $e) {
            return error($e->getMessage());
        }

        return success($result);
    }

    public function login()
    {
        $data         = [];
        $data['type'] = $this->request->post('type/s', null);
        if (empty($data['type'])) {
            return error('登录类型不能为空!');
        }
        $data['password'] = $this->request->post('password/s');

        switch ($data['type']) {
            case 'email':
                $data['email'] = $this->request->post('username/s');
                break;
            case 'mobile':
                $data['mobile'] = $this->request->post('username/s');
                break;
            default:
                return error('请重新提交');
        }
        $data['verify_img_id']   = $this->request->post('verify_img_id/s');
        $data['verify_img_code'] = $this->request->post('verify_img_code/s');
        try {
            validate(MerchantValidate::class)
                ->scene('Login')
                ->check($data);
        } catch (ValidateException $e) {
            return error($e->getMessage());
        }
        try {
            /*执行主体*/
            $profile = MerchantProfile::where($data['type'], $data[$data['type']])->find();
            $token = 'kaadon ' . jwt_create($profile->account->uuid, [
                    'type'       => 'merchant',
                    'id'         => $profile->account->id,
                    'uuid'         => $profile->account->uuid,
                    'agent_line' => $profile->account->agent_line,
                    'agentLv' => $profile->account->agent
                ]);
        } catch (\Exception $e) {
            return error($e->getMessage());
        }
        unset($profile->account->password, $profile->account->safeword);
        return success([
            "profile" => $profile,
            "token"   => $token,
            "webh5" => get_config('site','site','webh5')
        ]);
    }

    /***
     * @return \think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function getMerchant()
    {

        $where = [];

        $page = $this->request->param('page/d', 1);

        $limit = $this->request->param('limit/d', 10);

        $agentLine = $this->request->merchant->id;

        $PayOrder = MerchantAccount::where([['agent_line', 'like', '%|' . $agentLine . '|%']]);

        $agent = $this->request->param('agent/d', null);

        if (!is_null($agent)){
            $PayOrder = $PayOrder->where([['agent_line', 'like', '%|' . $agent . '|%']]);
        }else{
            $PayOrder = $PayOrder->where('agent',$this->request->merchant->agentLv + 1 );
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
            $where['status'] = $status;
        }
        $PayOrder = $PayOrder->where($where);

        $count = $PayOrder->count();

        $PayOrder = $PayOrder->page($page)
            ->limit($limit)
            ->select();
        foreach ($PayOrder as $key => $item) {
            $PayOrder[$key]->profile;
            $PayOrder[$key]->dashboard;
            $PayOrder[$key]->wallet;
        }

        $list = $PayOrder->toArray();

        $pages = ceil($count / $limit);

        $data['count'] = $count;
        $data['pages'] = $pages;
        $data['page']  = $page;
        $data['limit'] = $limit;
        $data['list']  = $list;
        $data['explain']  = [
            'day_recharge'=>'今日充值（统计0：00-23：59）',
            'team_withdraw'=>'总提现金额（只统计提现审核通过）',
            'day_register'=>'今日注册',
            'team_profit'=>'总盈亏金额（总充值-总提现-总用户余额-用户提现待审核）',
            'team_recharge'=>'总充值金额（只统计审核通过充值，不统计手动充值）',
            'team_money'=>'总用户余额（用户账户余额）',
            'day_event_profit'=>'今日比赛盈利金额',
            'now_game'=>'当前投注',
            'team_sizzler'=>'时时乐盈亏（用户投注金额-用户所获奖金） ',
            'team_event'=>'赛事盈亏（用户投注金额-用户所获奖金） ',
            'day_sizzler_profit'=>'今日时时乐盈亏金额',
            'team_lotter'=>'抽奖',
        ];


        return success($data);
    }


    public function getDashboard()
    {
        $merchant = MerchantDashboard::where('uid',$this->request->merchant->id)->withoutField('uid,update_time,delete_time,create_time')->find()->toArray();
        $mid = MemberAccount::where([['analog','=',0],['agent_line','like',"%|".$this->request->merchant->id."|%"]])->column('id');
        $merchant['now_game'] = GameEventBet::where([['mid','in',$mid],['is_ok','=',"0"],['opentime','=',"0"]])->sum('money');
        $merchant['team_lotter'] = abs(MemberRecord::where([['mid','in',$mid],['business','=',10]])->sum('now'));
        $merchant['team_lotter_open'] = abs(MemberRecord::where([['mid','in',$mid],['business','=',11]])->sum('now'));
        $merchant['sizzler'] = abs(MemberRecord::where([['mid','in',$mid],['business','=',8]])->sum('now'))-abs(MemberRecord::where([['mid','in',$mid],['business','=',7]])->sum('now'));
        $merchant['event'] = abs(MemberRecord::where([['mid','in',$mid],['business','=',4]])->sum('now'))-abs(MemberRecord::where([['mid','in',$mid],['business','=',3]])->sum('now'));
        $list = [
            'day_recharge'=>'今日充值（统计0：00-23：59）',
            'team_withdraw'=>'总提现金额（只统计提现审核通过）',
            'team_withdraw_examine'=>'待提现金额（提现审核中）',
            'day_register'=>'今日注册',
            'team_profit'=>'总盈亏金额（总充值-总提现-总用户余额-用户提现待审核）',
            'team_recharge'=>'总充值金额（只统计审核通过充值，不统计手动充值）',
            'team_money'=>'总用户余额（用户账户余额）',
            'day_event_profit'=>'今日比赛盈利金额',
//            'day_lottery'=>'今日彩票投注',
            'now_game'=>'当前投注',
            'team_sizzler'=>'时时乐盈亏（用户投注金额-用户所获奖金） ',
            'team_event'=>'赛事盈亏（用户投注金额-用户所获奖金） ',
            'day_sizzler_profit'=>'今日时时乐盈亏金额',
            'team_lotter'=>'抽奖投入金额',
            'team_lotter_open'=>'抽奖开奖金额',
        ];
        return success([$merchant,$list]);

    }

    /**
     * @return array|string|string[]|\think\response\Json
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     * 修改密码
     */
    public function savePassword(){
        $param = $this->request->param();
        $merchant = MerchantAccount::find($this->request->merchant->id);
        if (!$merchant) {
            return error('账户不存在!');
        }
        if ($merchant->save(['password'=>password_hash($param['password'],PASSWORD_DEFAULT)])) {
            return success('修改成功!');
        }else{
            return error('修改失败!');
        }
    }
    public function saveEdit()
    {
//        if (strpos((string)$this->request->merchant->id, $merchant->agent_line)) {
            return error('无权限!');
//        }
        $param = $this->request->param();
        if (!$param['id']) {
            return error('账户标识不存在!');
        }
        $merchant = MerchantAccount::find($param['id']);
        if (!$merchant) {
            return error('账户不存在!');
        }
        if (strpos((string)$this->request->merchant->id, $merchant->agent_line)) {
            return error('无权限!');
        }
        $update = [];

        foreach ($param as $key => $item) {
            if (is_array($item)) {
                foreach ($item as $key => $sitem) {
                    if (empty($sitem)){
                        unset($item[$key]);
                    }
                }
                $merchant->$key->save($item);
            } else {
                if ($item == 0 || !empty($item) ) {
                    $update[$key] = $item;
                }
            }
        }
        $merchant->save($update);

        return success('操作成功!');
    }

    public function saveDelete(){
        $param = $this->request->param();
        if (!$param['id']) {
            return error('账户标识不存在!');
        }
        $merchant = MerchantAccount::find($param['id']);
        if (!$merchant) {
            return error('账户不存在!');
        }
        if (strpos($param['id'], $merchant->agent_line)) {
            return error('无权限!');
        }

        $agent = MerchantAccount::where('agent_line','like','%|' . $param['id'] . '|%')->select();
        foreach ($agent as $item) {
            $item->profile()->delete();
            $item->wallet()->delete();
            $item->dashboard()->delete();
            $item->delete();
        }
        $merchant->profile()->delete();
        $merchant->wallet()->delete();
        $merchant->dashboard()->delete();
        $merchant->delete();


        return success('操作成功!');




    }

    public function saveAdd()
    {
        $result = (new Account())->create($this->request->param('mobile'),$this->request->param('password'),$this->request->merchant->id);
        if (!$result){
            return error('添加失败!');
        }

        return success('操作成功!');

    }
    
    public function logout()
    {
        try {
            /*执行主体*/
            jwt_delete($this->request->merchant->identification);
        } catch (\Exception $e) {
            var_dump($e->getTrace());
            return error();
        }
        return success();
    }
}
