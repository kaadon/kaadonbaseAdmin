<?php


namespace app\admin\controller\product;


use app\admin\traits\Curd;
use app\common\controller\AdminController;
use app\common\model\ProductProject;
use app\common\constants\AdminConstant;
use app\common\model\UserClient;
use app\Request;
use KaadonAdmin\annotation\ControllerAnnotation;
use KaadonAdmin\annotation\NodeAnotation;
use think\App;

/**
 * Class Admin
 * @package app\admin\controller\system
 * @ControllerAnnotation(title="项目管理")
 */
class Project extends AdminController
{

    use Curd;

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->model = new ProductProject();
    }

    /**
     * 列表
     */
    public function index(){
        if ($this->request->isAjax()){
            if (input('selectFields')) {
                return $this->selectList();
            }
            list($page, $limit, $where) = $this->buildTableParames();
            $count = $this->model
                ->where($where)
                ->count();
            $list  = $this->model
                ->withoutField('password')
                ->where($where)
                ->page($page, $limit)
                ->order($this->sort)
                ->select();
            foreach ($list as $v){
                $v['begin_time'] = date('Y-m-d H:i:s');
                $v['end_time'] = date('Y-m-d H:i:s');
            };
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

    /**
     * @param Request $request
     *  项目修改
     */
    public function edit(Request $request){
        $param = $request->param();
        $pid = $param['id'];
        $cid = $param['cid'];
        Db::transaction(function ($param,$pid,$cid) {
        $proData = ProductProject::info(['id'=>$pid]);
        $clientData = UserClient::info(['id'=>$cid]);
        if ($proData && $clientData){
            $res = ProductProject::where(['id'=>$pid])->update([
                'cid'  => $param['cid'],
                'title'=> $param['title'],
                'uid'=> $param['uid'],
                'Reviewer'=> $param['Reviewer'],
                'money'=> $param['money'],
                'pay'=> $param['pay'],
                'remainder'=> $param['remainder'],
                'consumption'=> $param['consumption'],
                'begin_time'=> time(),
                'end_time'=> time(),
                'update_at'=> time(),
            ]);
            $res1 = UserClient::where(['id'=>$cid])->update([
                'name' => $param['name'],
                'phone' => $param['phone'],
                'from' => $param['from'],
                'update_time' => time(),
            ]);
            if ($res && $res1){
                return json([
                    'code'=> 0,
                    'msg' => '修改成功'
                ]);
            }
        }else{
            return json([
                'code'=> 40004,
                'msg' => '没有这条数据'
            ]);
        }
        });
    }

    /**
     * 项目删除
     */
    public function delete($id)
    {
        Db::transaction(function ($id) {
            $proData = ProductProject::info(['id'=>$id]);
            if(!$proData){
                return json([
                    'code'=>4004,
                    'msg'=> '没有这一条数据'
                ]);
            }
            $res1 = UserClient::del(['id'=>$proData['cid']]);
            $res = (new ProductProject())->del(['id'=>$id]);
            if (!$res && !$res1){
                return json([
                    'code'=>0,
                    'msg'=> '删除成功'
                ]);
            }
        });
    }
}