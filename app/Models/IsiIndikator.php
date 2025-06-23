<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class IsiIndikator extends Model
{
    protected $table = 'isi_indikators';

    protected $fillable = [
        'indikator_id',
        'isi_indikator',
        'target'
    ];
    public function indikator()
    {
        return $this->belongsTo(Indikator::class);
    }

    public function unitIndikatorIsiIndikators()
    {
        return $this->hasMany(UnitIndikatorIsiIndikator::class);
    }
}
