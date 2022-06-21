<?php

namespace app\common\model\block;

use KaadonAdmin\baseCurd\Traits\Model\ModelCurd;
use app\common\model\TimeModel;

class BlockContractmethod extends TimeModel
{
    use ModelCurd;

    public static $ModelConfig = [
        'modelCache'       => '',
        'modelSchema'      => 'id',
        'modelDefaultData' => [],
    ];
}