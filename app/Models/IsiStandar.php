<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;

//class PoinStandar extends Model
class IsiStandar extends Model

{
    protected $fillable = [
        'nama_isi',
        'keterangan',
        'deskripsi',
        'validated_by',
        'created_by',
        'status',
        'validated_time'
    ];
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
