<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UnitIndikatorIndikator extends Model
{
    protected $table = 'unit_indikator_indikators'; // Make sure this matches your actual table name

    protected $fillable = [
        'unit_indikator_standar_id',
        'indikator_id',
        'is_rejected',
        'komentar'
    ];

    public function indikator()
    {
        return $this->belongsTo(Indikator::class);
    }

    public function unitIndikatorStandar()
{
    return $this->belongsTo(UnitIndikatorStandar::class);
}


public function unitIndikatorIsiIndikators()
{
    return $this->hasMany(UnitIndikatorIsiIndikator::class);
}

}
