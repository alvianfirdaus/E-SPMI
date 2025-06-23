<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ReviewIndikator extends Model
{
    protected $fillable = [
        'pengisian_indikators_id',
        'status',
        'status1',
        'status_temuan1',
        'hasil_pengamatan1',
        'reviewed_at1',
        'status2',
        'status_temuan2',
        'hasil_pengamatan2',
        'reviewed_at2',
    ];

    protected $casts = [
        'reviewed_at1' => 'datetime',
        'reviewed_at2' => 'datetime',
    ];

    public function pengisianIndikator(): BelongsTo
    {
        return $this->belongsTo(PengisianIndikator::class, 'pengisian_indikators_id');
    }

    // Get assignment through pengisian indikator
    public function assignment()
    {
        return $this->pengisianIndikator->assignPengisianIndikator ?? null;
    }

    // Helper methods for checking review status
    public function isReviewedByAuditor1(): bool
    {
        return $this->status1 === 'reviewed';
    }

    public function isReviewedByAuditor2(): bool
    {
        return $this->status2 === 'reviewed';
    }

    public function isFullyReviewed(): bool
    {
        return $this->isReviewedByAuditor1() && $this->isReviewedByAuditor2();
    }

    // Get the review data for specific auditor
    public function getAuditorReview(string $auditorRole): array
    {
        if ($auditorRole === 'auditor1') {
            return [
                'status' => $this->status1,
                'status_temuan' => $this->status_temuan1,
                'hasil_pengamatan' => $this->hasil_pengamatan1,
                'reviewed_at' => $this->reviewed_at1,
            ];
        } else {
            return [
                'status' => $this->status2,
                'status_temuan' => $this->status_temuan2,
                'hasil_pengamatan' => $this->hasil_pengamatan2,
                'reviewed_at' => $this->reviewed_at2,
            ];
        }
    }

    // Check if review has conflicts between auditors
    public function hasConflict(): bool
    {
        return $this->isFullyReviewed() && 
               !empty($this->status_temuan1) && 
               !empty($this->status_temuan2) &&
               $this->status_temuan1 !== $this->status_temuan2;
    }

    // Get overall review status
    public function getOverallStatus(): string
    {
        if ($this->isFullyReviewed()) {
            return $this->hasConflict() ? 'conflict' : 'completed';
        } elseif ($this->isReviewedByAuditor1() || $this->isReviewedByAuditor2()) {
            return 'partial';
        } else {
            return 'pending';
        }
    }

    // Get review completion percentage
    public function getCompletionPercentage(): float
    {
        $completed = 0;
        if ($this->isReviewedByAuditor1()) $completed += 50;
        if ($this->isReviewedByAuditor2()) $completed += 50;
        return $completed;
    }

    // Scope for filtering reviews by auditor
    public function scopeByAuditor($query, $userId, $role = null)
    {
        if ($role === 'auditor1') {
            return $query->whereHas('pengisianIndikator.assignPengisianIndikator.assignAuditors', function ($q) use ($userId) {
                $q->where('auditor1', $userId);
            });
        } elseif ($role === 'auditor2') {
            return $query->whereHas('pengisianIndikator.assignPengisianIndikator.assignAuditors', function ($q) use ($userId) {
                $q->where('auditor2', $userId);
            });
        } else {
            return $query->whereHas('pengisianIndikator.assignPengisianIndikator.assignAuditors', function ($q) use ($userId) {
                $q->where('auditor1', $userId)->orWhere('auditor2', $userId);
            });
        }
    }

    // Scope for conflict reviews
    public function scopeWithConflicts($query)
    {
        return $query->where('status1', 'reviewed')
                    ->where('status2', 'reviewed')
                    ->whereColumn('status_temuan1', '!=', 'status_temuan2');
    }
}
