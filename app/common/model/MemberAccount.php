<?php

namespace app\common\model;

use KaadonAdmin\baseCurd\Traits\Model\ModelCurd;

class MemberAccount extends TimeModel
{
    use ModelCurd;

    public static $ModelConfig = [
        'modelCache'       => '',
        'modelSchema'      => 'id',
        'modelDefaultData' => [],
    ];

    public function profile()
    {
        return $this->belongsTo(MemberProfile::class, 'id', 'mid');
    }

    public function dashboard()
    {
        return $this->belongsTo(MemberDashboard::class, 'id', 'mid');
    }

    public function wallet()
    {
        return $this->belongsTo(MemberWallet::class, 'id', 'mid');
    }

    public function payOrder()
    {
        return $this->belongsTo(MemberPayOrder::class, 'id', 'mid');
    }

    public function withdrawOrder()
    {
        return $this->belongsTo(MemberWithdrawOrder::class, 'id', 'mid');
    }

}