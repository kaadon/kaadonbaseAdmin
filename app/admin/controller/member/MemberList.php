<?php

namespace app\admin\controller\management\member;

use app\admin\traits\Curd;
use app\common\controller\AdminController;
use app\common\model\MemberAccount;
use app\common\model\MerchantAccount;
use app\common\model\MerchantProfile;
use KaadonAdmin\annotation\ControllerAnnotation;
use KaadonAdmin\annotation\NodeAnotation;
use think\App;

/**
 * Class MemberList
 * @package app\admin\controller\management\member
 * @ControllerAnnotation(title="会员列表")
 */
class MemberList extends AdminController
{
    use Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new MemberAccount();
    }
    /**
     * @NodeAnotation(title="列表")
     */
    public function index()
    {

        if ($this->request->isAjax()) {
            if (input('selectFields')) {
                return $this->selectList();
            }
            $query = $this->model;
            list($page, $limit, $where) = $this->buildTableParames();
            if (array_key_exists('agent_line',$where)) {
                $agent = '%|' . $where['agent_line'] .'|%';
            }

            $swhere = [];

            if (count($where) > 0){
                foreach ($where as $key => $item) {
                    $a =  explode('.',$item[0]);
                    if(count($a) > 1){
                        if (!array_key_exists($a[0],$swhere)){
                            $swhere[$a[0]] = [];
                        }
                        $item[0] = $a[1];
                        array_push($swhere[$a[0]],$item);
                        unset($where[$key]);
                    }
                }
            }
            $where = array_values($where);

            foreach ($swhere as $key => $item) {
                $query =   $query->hasWhere($key, $item);
            }
            if (isset($agent)){
                $query  = $query->where(['agent_line','like',$agent]);
            }

            $count = $query
                ->where($where)
                ->count();
            $list  = $query
                ->where($where)
                ->page($page, $limit)
                ->order($this->sort)
                ->select();
            foreach ($list as $key => $item) {
                $list[$key]->profile;
                $list[$key]->wallet;
                $agent_line = explode('|',$item->agent_line);
                $MerchantProfile_profile = MerchantProfile::whereIn('uid',$agent_line)->select();
                foreach ($MerchantProfile_profile as $skey => $item) {
                    $MerchantProfile_profile[$skey]->account;
                }
                $list[$key]->agent_profile = $MerchantProfile_profile->toArray();
            }
            $data  = [
                'code'  => 0,
                'msg'   => '',
                'count' => $count,
                'data'  => $list,
            ];
            return json($data);
        }
        return $this->fetch();
    }

}