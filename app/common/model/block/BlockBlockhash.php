<?php

namespace app\common\model\block;

use app\common\model\TimeModel;
use KaadonAdmin\baseCurd\Traits\Model\ModelCurd;

class BlockBlockhash extends TimeModel
{
    use ModelCurd;

    public static $ModelConfig = [
        'modelCache'       => '',
        'modelSchema'      => 'id',
        'modelDefaultData' => [],
    ];
}