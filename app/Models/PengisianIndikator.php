<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasOne;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class PengisianIndikator extends Model
{
    use HasFactory;

    protected $fillable = [
        'assign_pengisian_id',
        'ui_isi_indikator_id',
        'isi',
        'bukti',
        'faktor_penghambat',
        'answered_at',
        'status',
    ];

    protected $casts = [
        'answered_at' => 'datetime',
    ];

    public function assignPengisian(): BelongsTo
    {
        return $this->belongsTo(AssignPengisian::class);
    }

    public function unitIndikatorIsiIndikator(): BelongsTo
    {
        return $this->belongsTo(UnitIndikatorIsiIndikator::class, 'ui_isi_indikator_id');
    }

    public function reviewAuditor1(): HasOne
    {
        return $this->hasOne(ReviewAuditor1::class, 'pengisian_indikators_id');
    }

    public function reviewAuditor2(): HasOne
    {
        return $this->hasOne(ReviewAuditor2::class, 'pengisian_indikators_id');
    }

    /**
     * Get or create ReviewAuditor1 record
     */
    public function getOrCreateReviewAuditor1(): ReviewAuditor1
    {
        return $this->reviewAuditor1()->firstOrCreate(
            ['pengisian_indikators_id' => $this->id],
            [
                'status_temuan' => null,
                'hasil_pengamatan' => null,
                'status' => 'pending',
                'reviewed_at' => null,
            ]
        );
    }

    /**
     * Get or create ReviewAuditor2 record
     */
    public function getOrCreateReviewAuditor2(): ReviewAuditor2
    {
        return $this->reviewAuditor2()->firstOrCreate(
            ['pengisian_indikators_id' => $this->id],
            [
                'status_temuan' => null,
                'hasil_pengamatan' => null,
                'status' => 'pending',
                'reviewed_at' => null,
            ]
        );
    }

    /**
     * Check if there's a conflict between auditor reviews
     */
    public function hasConflict(): bool
    {
        $review1 = $this->reviewAuditor1;
        $review2 = $this->reviewAuditor2;

        // Only check for conflict if both auditors have completed their review
        if (!$review1 || !$review2 || 
            $review1->status !== 'reviewed' || 
            $review2->status !== 'reviewed') {
            return false;
        }

        // Conflict exists if the findings are different
        return $review1->status_temuan !== $review2->status_temuan;
    }

    /**
     * Get conflict details
     */
    public function getConflictDetails(): ?array
    {
        if (!$this->hasConflict()) {
            return null;
        }

        $review1 = $this->reviewAuditor1;
        $review2 = $this->reviewAuditor2;

        return [
            'item' => $this->unitIndikatorIsiIndikator->isiIndikator->isi_indikator ?? 'Unknown Item',
            'auditor1_finding' => $review1->status_temuan,
            'auditor2_finding' => $review2->status_temuan,
            'auditor1_note' => $review1->hasil_pengamatan,
            'auditor2_note' => $review2->hasil_pengamatan,
            'auditor1_reviewed_at' => $review1->reviewed_at,
            'auditor2_reviewed_at' => $review2->reviewed_at,
        ];
    }

    /**
     * Get consensus status if both auditors agree
     */
    public function getConsensusStatus(): ?string
    {
        $review1 = $this->reviewAuditor1;
        $review2 = $this->reviewAuditor2;

        if (!$review1 || !$review2 || 
            $review1->status !== 'reviewed' || 
            $review2->status !== 'reviewed') {
            return null;
        }

        if ($review1->status_temuan === $review2->status_temuan) {
            return $review1->status_temuan;
        }

        return 'conflict';
    }

    /**
     * Get review completion percentage for this item
     */
    public function getReviewCompletionPercentage(): float
    {
        $review1 = $this->reviewAuditor1;
        $review2 = $this->reviewAuditor2;

        $completed = 0;
        
        if ($review1 && $review1->status === 'reviewed') {
            $completed++;
        }
        
        if ($review2 && $review2->status === 'reviewed') {
            $completed++;
        }

        return ($completed / 2) * 100;
    }

    /**
     * Check if item is fully reviewed by both auditors
     */
    public function isFullyReviewed(): bool
    {
        return $this->getReviewCompletionPercentage() === 100.0;
    }

    /**
     * Get combined review summary
     */
    public function getReviewSummary(): array
    {
        $review1 = $this->reviewAuditor1;
        $review2 = $this->reviewAuditor2;

        return [
            'pengisian_status' => $this->isi,
            'completion_percentage' => $this->getReviewCompletionPercentage(),
            'has_conflict' => $this->hasConflict(),
            'consensus_status' => $this->getConsensusStatus(),
            'auditor1' => [
                'status' => $review1?->status ?? 'pending',
                'finding' => $review1?->status_temuan,
                'note' => $review1?->hasil_pengamatan,
                'reviewed_at' => $review1?->reviewed_at,
            ],
            'auditor2' => [
                'status' => $review2?->status ?? 'pending',
                'finding' => $review2?->status_temuan,
                'note' => $review2?->hasil_pengamatan,
                'reviewed_at' => $review2?->reviewed_at,
            ],
        ];
    }
}