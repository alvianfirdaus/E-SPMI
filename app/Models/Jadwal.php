<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\BelongsToMany;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Jadwal extends Model
{
    use HasFactory;

    protected $table = 'jadwal';

    protected $fillable = [
        'periode_id',
        'judul',
        'deskripsi',
        'start_date',
        'start_time',
        'end_date',
        'end_time',
        'is_all_day',
        'is_active',
        'type',
        'priority',
        'location',
        'meeting_link',
        'status',
        'created_by',
        'validated_by',
        'validated_time'
    ];

    protected $casts = [
    'start_date' => 'date',
    'end_date' => 'date',
    'is_all_day' => 'boolean',
    'is_active' => 'boolean',
    'metadata' => 'array',
];

    // FIXED RELATIONSHIPS
    public function periode(): BelongsTo
    {
        return $this->belongsTo(Periode::class);
    }

    public function creator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'created_by');
    }

    public function validator(): BelongsTo
    {
        return $this->belongsTo(User::class, 'validated_by');
    }

    public function jadwalAssignments(): HasMany
    {
        return $this->hasMany(JadwalAssignment::class);
    }

    public function users(): BelongsToMany
    {
        return $this->belongsToMany(User::class, 'jadwal_assignments')
            ->withPivot('role_user') // Fixed: include pivot columns
            ->withTimestamps();
    }

    public function units(): BelongsToMany
    {
        return $this->belongsToMany(Unit::class, 'jadwal_units')
            ->withTimestamps();
    }

    // Rest of your existing methods...
    public function scopeActive($query)
    {
        return $query->where('is_active', true);
    }

    public function scopeVisible($query)
    {
        return $query->where('status', 'validated')->where('is_active', true);
    }

    public function scopeForUser($query, $userId)
    {
        return $query->whereHas('users', function ($q) use ($userId) {
            $q->where('user_id', $userId);
        });
    }

    public function scopeForUnit($query, $unitId)
    {
        return $query->whereHas('units', function ($q) use ($unitId) {
            $q->where('unit_id', $unitId);
        });
    }

    // Helper method to get user role in this schedule
    public function getUserRole($userId): ?string
    {
        $assignment = $this->jadwalAssignments()
            ->where('user_id', $userId)
            ->first();
            
        return $assignment?->role_user;
    }

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($jadwal) {
            if (Auth::check()) {
                $jadwal->created_by = Auth::id();
            }
        });
    }
}