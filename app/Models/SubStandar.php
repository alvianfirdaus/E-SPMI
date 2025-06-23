<?php

namespace App\Models;

use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;

//class SubStandar extends Model
class SubStandar extends Model
{
    protected $fillable = [
        'nama_sub_standar',
        'standar_id',
        'isi_standar_id',
        'status',
        'validated_by',
        'created_by',
        'validated_time'
    ];

    protected $casts = [
        'isi_standar_id' => 'array',

    ];

    protected static function booted(): void
    {
        static::creating(function ($subStandar) {
            $subStandar->created_by = Auth::id();
        });
    }
    public function standar()
    {
        return $this->belongsTo(Standar::class);
    }

    public function getIsiStandarsAttribute()
    {
        return IsiStandar::whereIn('id', $this->isi_standar_id ?? [])->get();
    }

    public function validator()
    {
        return $this->belongsTo(User::class, 'validated_by');
    }

    public function creator()
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function getIsiStandarListAttribute()
    {
        $ids = collect($this->isi_standar_id)->pluck('isi_id');

        return \App\Models\IsiStandar::whereIn('id', $ids)->get();
    }
}
