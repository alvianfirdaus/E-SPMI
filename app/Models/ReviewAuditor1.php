<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ReviewAuditor1 extends Model
{
    use HasFactory;

    protected $fillable = [
        'pengisian_indikators_id',
        'status_temuan',
        'hasil_pengamatan',
        'status',
        'reviewed_at',
    ];

    protected $casts = [
        'reviewed_at' => 'datetime',
    ];

    public function pengisianIndikator(): BelongsTo
    {
        return $this->belongsTo(PengisianIndikator::class, 'pengisian_indikators_id');
    }
}