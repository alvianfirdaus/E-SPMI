<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JadwalUnit extends Model
{
    protected $fillable = [
        'jadwal_id', 'unit_id'
    ];

    public function jadwal()
    {
        return $this->belongsTo(Jadwal::class);
    }

    public function unit()
    {
        return $this->belongsTo(Unit::class);
    }
}