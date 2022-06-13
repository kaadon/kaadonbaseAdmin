<?php
namespace app\admin\controller\user;

use app\common\constants\AdminConstant;

use app\admin\controller\system\SystemNode;
use app\admin\service\TriggerService;
use app\common\controller\AdminController;
use think\App;
use function input;
use function json;

//职位
class Position extends AdminConstant{
    public function index(){
        return $this->fetch();
    }
}
?>