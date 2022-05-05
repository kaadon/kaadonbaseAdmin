<?php

namespace app\api\controller;


use app\BaseController;
use think\App;

class Common extends BaseController
{
    protected $config = [];

    public function __construct(App $app)
    {
        parent::__construct($app);
    }
    /**
     *
     * @param  $latitude    纬度
     * @param  $longitude    经度
     * @param  $raidus        半径范围(单位：米)
     * @return array
     */
    function getAround($latitude,$longitude,$raidus)
    {
        $PI = 3.14159265;
        $degree = (24901*1609)/360.0;
        $dpmLat = 1/$degree;
        $radiusLat = $dpmLat*$raidus;
        $minLat = $latitude - $radiusLat;
        $maxLat = $latitude + $radiusLat;
        $mpdLng = $degree*cos($latitude * ($PI/180));
        $dpmLng = 1 / $mpdLng;
        $radiusLng = $dpmLng*$raidus;
        $minLng = $longitude - $radiusLng;
        $maxLng = $longitude + $radiusLng;
        return array ('minLat'=>$minLat, 'maxLat'=>$maxLat, 'minLng'=>$minLng, 'maxLng'=>$maxLng);
    }
}
