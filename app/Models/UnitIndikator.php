<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;

//class UnitIndikator extends Model
class UnitIndikator extends Model
{
    protected $fillable = [
        'unit_id',
        'periode_id',
        'auditee',
        'validator_1_id',
        'status_validasi_1',
        'komentar_validasi_1',
        'validated_time_1',
        'created_by',
    ];

    protected static function booted(): void
    {
        static::creating(function ($unitIndikator) {
            $unitIndikator->created_by = Auth::id();
        });
    }

    public function unit()
    {
        return $this->belongsTo(Unit::class, 'unit_id');
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function periode()
    {
        return $this->belongsTo(Periode::class);
    }
    
    public function validator1()
    {
        return $this->belongsTo(User::class, 'validator_1_id');
    }
    public function unitIndikatorStandars()
    {
        return $this->hasMany(UnitIndikatorStandar::class);
    }

    public function auditeeUser()
{
    return $this->belongsTo(User::class, 'auditee');
}
}
