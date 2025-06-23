<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UnitIndikatorIsiIndikator extends Model
{
    protected $table = 'unit_indikator_isi_indikators'; // Make sure this matches your actual table name

    protected $fillable = [
        'unit_indikator_indikator_id',
        'isi_indikator_id',
        'pertanyaan',
        'target',
        'bukti',
        'is_rejected',
        'komentar'
    ];

    public function unitIndikatorIndikator()
    {
        return $this->belongsTo(UnitIndikatorIndikator::class);
    }

    public function isiIndikator()
    {
        return $this->belongsTo(IsiIndikator::class);
    }
}
