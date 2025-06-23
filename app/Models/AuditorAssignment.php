<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AuditorAssignment extends Model
{
    protected $table = 'auditor_assignments';

    protected $fillable = [
        'assign_pengisian_id',
        'auditor1',
        'auditor2'
    ];

    public function pengisianIndikators()
    {
        return $this->hasMany(PengisianIndikator::class);
    }

public function assignPengisianIndikator()
{
    return $this->belongsTo(AssignPengisian::class, 'assign_pengisian_id');
}
    
    public function auditor1Relation()
{
    return $this->belongsTo(User::class, 'auditor1');
}

public function auditor2Relation()
{
    return $this->belongsTo(User::class, 'auditor2');
}

    public function reviewIndikators()
    {
        return $this->hasMany(ReviewIndikator::class);
    }
}
