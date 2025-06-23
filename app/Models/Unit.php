<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

//class Unit extends Model
class Unit extends Model
{
    protected $fillable = [
        'kode_unit',
        'nama_unit',
        'status',
        'validated_by',
        'created_by',
        'validated_time'
    ];
    protected static function booted(): void
    {
        static::creating(function ($unit) {
            $unit->created_by = Auth::id();
        });
    }
    public function users(): HasMany
    {
        return $this->hasMany(User::class);
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
