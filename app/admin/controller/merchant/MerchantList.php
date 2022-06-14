<?php


namespace app\admin\controller\merchant;


use app\admin\traits\Curd;
use app\common\controller\AdminController;
use app\common\controller\merchant\Account;
use app\common\model\MerchantAccount;
use think\App;

/**
 * Class MerchantList
 * @package app\admin\controller\merchant
 * @ControllerAnnotation(title="商家管理")
 */
class MerchantList extends AdminController
{

    use Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new MerchantAccount();
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
                ->getList($where, $page, $limit, '', [], false, 'profile');
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

    /**
     * @NodeAnotation(title="添加")
     */
    public function add()
    {
        if ($this->request->isPost()) {
            $post = $this->request->post();
            $rule = [];
            $this->validate($post, $rule);
            try {
                $save = (new Account())->create($post['mobile'], $post['password'], 0);
            } catch (\Exception $e) {
                $this->error_view('保存失败:' . $e->getMessage());
            }
            $save ? $this->success_view('保存成功') : $this->error_view('保存失败');
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
                $update = [];
                foreach ($post as $key => $item) {
                    if (strpos($key, '_') !== false) {
                        $split                        = explode('_', $key);
                        $update[$split[0]][$split[1]] = $item;
                    } else {
                        if ($key == 'password') {
                            $item = password_hash($item, PASSWORD_DEFAULT);
                        }
                        $update[$key] = $item;
                    }
                }

                foreach ($update as $key => $item) {
                    if (is_array($item)) {
                        $save = $row->$key->save($item);
                    } else {
                        $save = $row->save([$key => $item]);
                    }
                }
            } catch (\Exception $e) {
                $this->error_view($e->getTrace());
            }
            $save ? $this->success_view('保存成功') : $this->error_view('保存失败');
        }
        $this->assign('row', $row);
        return $this->fetch();
    }

}