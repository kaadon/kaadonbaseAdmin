<?php


namespace app\admin\controller\block;


use app\admin\traits\Curd;
use app\common\controller\AdminController;
use app\common\model\block\BlockContractmethod;
use KaadonAdmin\annotation\ControllerAnnotation;
use KaadonAdmin\annotation\NodeAnotation;
use think\App;

/**
 * Class Transaction
 * @package app\admin\controller\block
 * @ControllerAnnotation(title="区块交易记录")
 */
class Transaction extends AdminController
{

    use Curd;

//    protected $relationSearch = true;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new BlockContractmethod();
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
            list($page, $limit, $where) = $this->buildTableParames();
            $list = $this->model
                ->getList($where,$page,$limit,'',[],false,['articleCate']);
            $data = [
                'code'  => 0,
                'msg'   => '',
                'count' => $list['count'],
                'data'  => $list['list'],
            ];
            return json($data);
        }
        return $this->fetch();
    }


}