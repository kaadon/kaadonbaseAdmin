<?php

namespace app\common\model\block;

use KaadonAdmin\baseCurd\Traits\Model\ModelCurd;
use app\common\model\TimeModel;

class BlockContract extends TimeModel
{
    use ModelCurd;

    public static $ModelConfig = [
        'modelCache'       => '',
        'modelSchema'      => 'id',
        'modelDefaultData' => [],
    ];

    public function coin()
    {
        return $this->belongsTo(BlockCoin::class, 'coin_id', 'id');
    }

    public function chain()
    {
        return $this->belongsTo(BlockChain::class, 'chain_id', 'id');
    }
}