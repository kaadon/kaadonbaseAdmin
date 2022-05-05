<?php


namespace app\api\controller;

use app\api\controller\Common;
use app\common\model\UserStaff;
use think\App;
use think\facade\Lang;

class Base extends Common
{
    protected $username = '';
    protected $lang = "";

    public function __construct(App $app)
    {
        parent::__construct($app);
        $this->username = $this->request->username;
    }
}