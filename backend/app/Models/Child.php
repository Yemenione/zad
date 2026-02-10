<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Child extends Model
{
    protected $guarded = [];

    public function parent()
    {
        return $this->belongsTo(User::class, 'parent_id');
    }

    public function healthInfo()
    {
        return $this->hasOne(HealthInfo::class);
    }

    public function orders()
    {
        return $this->hasMany(Order::class);
    }
}
