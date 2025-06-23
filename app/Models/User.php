<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use Filament\Panel;
use Spatie\Image\Enums\Fit;
use Spatie\MediaLibrary\HasMedia;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Support\Facades\Storage;
use Filament\Models\Contracts\HasAvatar;
use Illuminate\Notifications\Notifiable;
use Filament\Models\Contracts\FilamentUser;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable implements FilamentUser, HasAvatar
{
    /** @use HasFactory<\Database\Factories\UserFactory> */
    use HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var list<string>
     */
    protected $fillable = [
        'nip',
        'name',
        'email',
        'unit_id',
        'password',
        'avatar_url'
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var list<string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Get the attributes that should be cast.
     *
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
        ];
    }

    public function getFilamentAvatarUrl(): ?string
    {
        return filled($this->avatar_url) && Storage::disk('profile-photos')->exists($this->avatar_url)
            ? Storage::url("profile-photos/{$this->avatar_url}")
            : "https://ui-avatars.com/api/?name=" . urlencode($this->name);
    }

    public function canAccessPanel(Panel $panel): bool
    {
        return true;
        // return str_ends_with($this->email, '@yourdomain.com') && $this->hasVerifiedEmail();
    }

    protected static function boot()
    {
        parent::boot();

        static::updating(function ($user) {
            if ($user->isDirty('avatar_url') && $user->getOriginal('avatar_url')) {
                Storage::disk('profile-photos')->delete($user->getOriginal('avatar_url'));
            }
        });
    }

    public function unit()
    {
        return $this->belongsTo(Unit::class);
    }

    public function assignedPengisianIndikators()
    {
        return $this->hasMany(AssignPengisian::class, 'auditee_id');
    }

    public function assignedIndikators()
    {
        return $this->belongsToMany(AuditorAssignment::class, 'auditor_assignments', 'auditor_id', 'assign_pengisian_id');
    }

    //Validator
    public function validatedIsiStandars()
    {
        return $this->hasMany(\App\Models\IsiStandar::class, 'validated_by');
    }

    public function validatedSubStandars()
    {
        return $this->hasMany(\App\Models\SubStandar::class, 'validated_by');
    }

    public function validatedStandars()
    {
        return $this->hasMany(\App\Models\Standar::class, 'validated_by');
    }

    public function validatedUnits()
    {
        return $this->hasMany(\App\Models\Unit::class, 'validated_by');
    }

    public function validatedIndikators()
    {
        return $this->hasMany(\App\Models\Indikator::class, 'validated_by');
    }

    public function validatedUnitIndikators()
    {
        return $this->hasMany(\App\Models\UnitIndikator::class, 'validated_by');
    }
    public function auditeeUnitIndikators()
    {
        return $this->hasMany(\App\Models\UnitIndikator::class, 'auditee');
    }
    public function validatedPeriodes()
    {
        return $this->hasMany(\App\Models\Periode::class, 'validated_by');
    }
}
