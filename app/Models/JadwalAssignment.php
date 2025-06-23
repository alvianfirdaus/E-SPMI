<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class JadwalAssignment extends Model
{
    protected $fillable = [
        'jadwal_id', 'user_id', 'role_user',
    ];

    public function jadwal()
    {
        return $this->belongsTo(Jadwal::class, 'jadwal_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}