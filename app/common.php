<?php
// 应用公共文件

use app\common\service\AuthService;
use think\facade\Cache;


if (!function_exists('admin_alias_name')) {


    /**
     * 构建admin别名
     * @return mixed|string
     */
    function admin_alias_name()
    {
        return config('app.admin_alias_name') ?: 'admin';
    }
}


if (!function_exists('__url')) {

    /**
     * 构建URL地址
     * @param string $url
     * @param array $vars
     * @param bool $suffix
     * @param bool $domain
     * @return string
     */
    function __url(string $url = '', array $vars = [], $suffix = true, $domain = false)
    {
        return url($url, $vars, $suffix, $domain)->build();
    }
}

if (!function_exists('get_config')) {

    /**
     * 获取系统配置信息
     * @param string $group
     * @param string $name
     * @param string|null $value
     * @return array|mixed
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    function get_config(string $group, string $name, string $value = null)
    {

        $data = \app\common\model\SystemConfig::getInfo($group, $name);

        if (!is_null($value)) {
            if (is_array($data) && array_key_exists($value, $data)) {
                $data = $data[$value];
            } else {
                $data = '';
            }
        }

        return $data;
    }
}

if (!function_exists('timestamp')) {
    /**
     * 时间戳
     * @return false|string
     */
    function timestamp()
    {
        return date('Y-m-d H:i:s');
    }
}
if (!function_exists('password')) {

    /**
     * 密码加密算法
     * @param $value 需要加密的值
     * @param $type  加密类型，默认为md5 （md5, hash）
     * @return mixed
     */
    function password($value)
    {
        $value = sha1('blog_') . md5($value) . md5('_encrypt') . sha1($value);
        return sha1($value);
    }

}

if (!function_exists('xdebug')) {

    /**
     * debug调试
     * @param string|array $data 打印信息
     * @param string $type 类型
     * @param string $suffix 文件后缀名
     * @param bool $force
     * @param null $file
     * @deprecated 不建议使用，建议直接使用框架自带的log组件
     */
    function xdebug($data, $type = 'xdebug', $suffix = null, $force = false, $file = null)
    {
        !is_dir(runtime_path() . 'xdebug/') && mkdir(runtime_path() . 'xdebug/');
        if (is_null($file)) {
            $file = is_null($suffix) ? runtime_path() . 'xdebug/' . date('Ymd') . '.txt' : runtime_path() . 'xdebug/' . date('Ymd') . "_{$suffix}" . '.txt';
        }
        file_put_contents($file, "[" . date('Y-m-d H:i:s') . "] " . "========================= {$type} ===========================" . PHP_EOL, FILE_APPEND);
        $str = (is_string($data) ? $data : (is_array($data) || is_object($data)) ? print_r($data, true) : var_export($data, true)) . PHP_EOL;
        $force ? file_put_contents($file, $str) : file_put_contents($file, $str, FILE_APPEND);
    }
}



if (!function_exists('array_format_key')) {

    /**
     * 二位数组重新组合数据
     * @param $array
     * @param $key
     * @return array
     */
    function array_format_key($array, $key)
    {
        $newArray = [];
        foreach ($array as $vo) {
            $newArray[$vo[$key]] = $vo;
        }
        return $newArray;
    }

}

if (!function_exists('auth')) {

    /**
     * auth权限验证
     * @param $node
     * @return bool
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    function auth($node = null)
    {
        $authService = new AuthService(session('admin.id'));
        $check       = $authService->checkNode($node);
        return $check;
    }

}