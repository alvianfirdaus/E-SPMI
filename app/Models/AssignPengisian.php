<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AssignPengisian extends Model
{
    protected $table = 'assign_pengisians';

    protected $fillable = [
        'unit_indikator_id',
        'periode_id',
        'start_date',
        'end_date',
        'status_pengisian',
        'status',
        'is_active',
        'validated_by',
        'validated_time',
        'created_by'
    ];
   
    public function unitIndikator()
    {
        return $this->belongsTo(UnitIndikator::class);
    }

    public function periode()
    {
        return $this->belongsTo(Periode::class);
    }

    public function auditor1()
{
    return $this->assignAuditors?->auditor1Relation;
}

public function auditor2()
{
    return $this->assignAuditors?->auditor2Relation;
}

    public function assignAuditors()
{
    return $this->hasOne(AuditorAssignment::class, 'assign_pengisian_id');
}

    public function pengisianIndikators()
    {
        return $this->hasMany(PengisianIndikator::class);
    }
}
