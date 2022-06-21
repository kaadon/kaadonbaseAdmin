<?php


namespace app\admin\controller\block;


use app\admin\traits\Curd;
use app\common\controller\AdminController;
use app\common\model\block\BlockBlockhash;
use app\common\model\block\BlockContract;
use KaadonAdmin\annotation\ControllerAnnotation;
use KaadonAdmin\annotation\NodeAnotation;
use think\App;

/**
 * Class Contract
 * @package app\admin\controller\block
 * @ControllerAnnotation(title="合约地址")
 */
class Contract extends AdminController
{

    use Curd;

//    protected $relationSearch = true;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new BlockContract();
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

            foreach ($swhere as $key => $item) {
                $query =   $query->hasWhere($key, $item);
            }

            $count = $query
                ->where($where)
                ->count();
            $list  = $query
                ->where($where)
                ->page($page, $limit)
                ->order($this->sort)
                ->select();
            $data  = [
                'code'  => 0,
                'msg'   => '',
                'count' => $count,
                'data'  => $list,
            ];

            foreach ($list as $key => $item) {
                $list[$key]->coin;
                $list[$key]->chain;
            }
            return json($data);
        }
        return $this->fetch();
    }
    /**
     * @NodeAnotation(title="编辑")
     */
    public function edit($id)
    {
        $row = $this->model->find($id);
        empty($row) && $this->error_view('数据不存在');
        if ($this->request->isPost()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $json_data = [];
                foreach ($post as $key => $item) {
                    var_dump($key);
                    var_dump(strpos('.',$key));
                    if (strpos($key,'.')){
                        $skey = explode(".",$key);
                        if (isset($json_data[$skey[0]])){
                            $json_data[$skey[0]][$skey[1]] = $item;
                        }else{
                            $json_data[$skey[0]] = [];
                            $json_data[$skey[0]][$skey[1]] = $item;
                        }
                        unset($post[$key]);
                    }
                }
                foreach ($json_data as $key => $json_datum) {
                    $post[$key] = json_encode($json_datum,true);
                }
                var_dump($post);
                $save = $row->save($post);
            } catch (\Exception $e) {
                $this->error_view('保存失败');
            }
            $save ? $this->success_view('保存成功') : $this->error_view('保存失败');
        }
        $this->assign('row', $row);
        return $this->fetch();
    }

}