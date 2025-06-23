<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;

class Periode extends Model
{
    //
    protected $table = 'periodes';

    protected $fillable = [
        'periode_kode',
        'periode_name',
        'start_date',
        'end_date',
        'status_periode',
        'validated_by',
        'created_by',
        'status',
        'validated_time'
    ];
    protected static function booted(): void
    {
        static::creating(function ($periode) {
            $periode->created_by = Auth::id();
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
