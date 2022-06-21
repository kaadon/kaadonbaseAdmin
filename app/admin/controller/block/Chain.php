<?php


namespace app\admin\controller\block;


use app\admin\traits\Curd;
use app\common\controller\AdminController;
use app\common\model\block\BlockChain;
use think\App;

/**
 * Class Cate
 * @package app\admin\controller\block
 * @ControllerAnnotation(title="文章管理")
 */
class Chain extends AdminController
{

    use Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new BlockChain();
    }

}