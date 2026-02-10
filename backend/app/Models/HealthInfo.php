<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HealthInfo extends Model
{
    protected $table = 'health_info';
    protected $guarded = [];

    protected $casts = [
        'allergies' => 'json',
        'forbidden_ingredients' => 'json',
    ];

    public function child()
    {
        return $this->belongsTo(Child::class);
    }
}
