<?php
declare (strict_types = 1);

namespace app\api\middleware;

use app\common\exception\JwtAnomaly;
use think\Exception;
use think\facade\Config;
use think\Response;
use function app;
use function error;
use function jwt_verify;

class JwtVerifyMiddleware
{
    /**
     * 处理请求
     *
     * @param \think\Request $request
     * @param \Closure $next
     * @return Response
     * @throws \think\Exception
     */

    public function handle(\think\Request $request, \Closure $next)
    {
        $Currentoute = strtolower($request->pathinfo());
        $api_white_list = Config::get('jwt.api.white');

        if (!in_array($Currentoute, $api_white_list)) {
            $tokenBearer = app('request')->header('Authorization');
            if (!$tokenBearer) {
                throw new JwtAnomaly('token is must.');
            }
            $token = substr($tokenBearer, 7);
//            $token = $tokenBearer;
            if (!$token) {
                throw new JwtAnomaly('token is required.');
            }
            try {
                /*执行主体*/
//                $JwtData = jwt_verify($token);
//                $data = $JwtData->data;
//                if (\think\facade\Request::ip() != $data->ip) {
//                    throw new Exception('网络环境更换,请重新登录!');
//                }
//                if (!property_exists($data, 'type') || $data->type !== "merchant") {
//                    throw new Exception('你无权限查看!');
//                }
//                $request->username = $data->id;
                $request->username = 21;
        } catch (\Exception $e) {
                return error($e->getMessage());
            }
        }
        return $next($request);
    }
}
