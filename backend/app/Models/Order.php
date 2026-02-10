<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    protected $guarded = [];

    public function child()
    {
        return $this->belongsTo(Child::class);
    }

    public function meal()
    {
        return $this->belongsTo(Meal::class);
    }
}
