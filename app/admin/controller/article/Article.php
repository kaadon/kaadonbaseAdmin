<?php


namespace app\admin\controller\article;


use app\admin\traits\Curd;
use app\common\controller\AdminController;
use app\common\model\ArticleCate;
use app\common\model\ArticleList;
use KaadonAdmin\annotation\ControllerAnnotation;
use KaadonAdmin\annotation\NodeAnotation;
use think\App;

/**
 * Class Article
 * @package app\admin\controller\article
 * @ControllerAnnotation(title="文章管理")
 */
class Article extends AdminController
{

    use Curd;

//    protected $relationSearch = true;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new ArticleList();
        $this->assign('ArticleType',ArticleCate::where(1)->select());
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