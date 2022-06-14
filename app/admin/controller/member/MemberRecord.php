<?php


namespace app\admin\controller\member;


use app\admin\traits\Curd;
use app\common\controller\AdminController;
use app\common\controller\member\Account;
use think\App;
use function input;
use function json;

/**
 * Class MemberRecord
 * @package app\admin\controller\member
 * @ControllerAnnotation(title="流水")
 */
class MemberRecord extends AdminController
{

    use Curd;

//    protected $relationSearch = true;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new \app\common\model\MemberRecord();
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
            $query = $query->where($where);

            foreach ($swhere as $key => $item) {
                $query =   $query->hasWhere($key, $item);
            }


            $count = $query
                ->count();
            $list  = $query
                ->page($page, $limit)
                ->order($this->sort)
                ->select();
            foreach ($list as $key => $item) {
                $list[$key]->profile;
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