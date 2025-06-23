<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;

class Indikator extends Model
{
    protected $fillable = [
        'sub_standar_id',
        'status',
        'validated_by',
        'validated_time',
        'created_by'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function subStandar()
    {
        return $this->belongsTo(SubStandar::class);
    }

    public function scopeValidated($query)
    {
        return $query->where('status', 'validated');
    }

    public function scopePending($query)
    {
        return $query->where('status', 'pending');
    }

    public function isiIndikators()
    {
        return $this->hasMany(IsiIndikator::class);
    }

    protected static function booted(): void
    {
        static::creating(function ($isi) {
            $isi->created_by = Auth::id();
        });
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
