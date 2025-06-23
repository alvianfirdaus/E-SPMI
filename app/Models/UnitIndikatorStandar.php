<?php

namespace App\Models;

use App\Models\Standar;
use App\Models\UnitIndikator;
use Illuminate\Database\Eloquent\Model;

class UnitIndikatorStandar extends Model
{
    protected $fillable = [
        'unit_indikator_id',
        'standar_id',
        'is_rejected',
        'komentar'
    ];

    public function unitIndikator()
    {
        return $this->belongsTo(UnitIndikator::class);
    }

    public function standar()
    {
        return $this->belongsTo(Standar::class);
    }

    public function unitIndikatorIndikators()
{
    return $this->hasMany(UnitIndikatorIndikator::class);
}

}
