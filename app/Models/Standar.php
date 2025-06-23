<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

//class Standar extends Model
class Standar extends Model
{
    protected $fillable = [
        'kode_standar',
        'nama_standar',
        'tahun',
        'status',
        'validated_by',
        'created_by',
        'validated_time'
    ];

    protected static function booted(): void
    {
        static::creating(function ($isi) {
            $isi->created_by = Auth::id();
        });
    }

    public function subStandars(): HasMany
    {
        return $this->hasMany(SubStandar::class);
    }

    public function validator()
    {
        return $this->belongsTo(User::class, 'validated_by');
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }
}
