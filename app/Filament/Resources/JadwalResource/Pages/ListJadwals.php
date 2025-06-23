<?php

namespace App\Filament\Resources\JadwalResource\Pages;

use Filament\Actions;
use App\Models\Jadwal;
use App\Models\Periode;
use Illuminate\Support\Facades\Auth;
use Filament\Resources\Components\Tab;
use Filament\Resources\Pages\ListRecords;
use App\Filament\Resources\JadwalResource;
use Illuminate\Database\Eloquent\Builder;

class ListJadwals extends ListRecords
{
    protected static string $resource = JadwalResource::class;

    // Add listener for PeriodeSwitcher changes
    protected $listeners = [
        'refresh-assign-table' => 'handlePeriodeSwitcherChange'
    ];

    public function handlePeriodeSwitcherChange(): void
    {
        // Clear the user override flag when PeriodeSwitcher is used
        session()->forget('user_overrode_periode_filter');
        
        // Force update the periode filter to match PeriodeSwitcher
        $newPeriodeId = session('selected_periode_id');
        
        if ($newPeriodeId) {
            // Update the table filter programmatically
            $this->tableFilters['periode_id']['value'] = $newPeriodeId;
            
            // Reset table to apply new filter
            $this->resetTable();
        }
    }

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }

    protected function getTableQuery(): Builder
    {
        $query = parent::getTableQuery();
        
        // Check if user has manually overridden the filter
        $userOverrode = session('user_overrode_periode_filter', false);
        
        if (!$userOverrode) {
            // If no user override, follow the PeriodeSwitcher
            $selectedPeriodeId = session('selected_periode_id');
            
            if ($selectedPeriodeId) {
                $query->where('periode_id', $selectedPeriodeId);
            } else {
                // Default to active periode only if no session value
                $activePeriodeId = Periode::where('status_periode', 'active')
                    ->where('status', 'validated')
                    ->first()?->id;
                
                if ($activePeriodeId) {
                    $query->where('periode_id', $activePeriodeId);
                }
            }
        }
        // If user overrode, let the normal filter behavior handle it
        
        return $query;
    }

    public function getTabs(): array
    {
        $user = Auth::user();
        $userId = $user?->id;
        
        $isSuperAdmin = $user->hasRole('super_admin');
        $isAssigned = Jadwal::where('validated_by', $userId)->exists();
        
        if (! $isSuperAdmin && ! $isAssigned) {
            return [];
        }

        // Get current effective periode for tab counts
        $effectivePeriodeId = $this->getEffectivePeriodeId();

        return [
            'Semua' => Tab::make()
                ->badge(fn() => $this->getTabCount($effectivePeriodeId))
                ->modifyQueryUsing(fn($query) => $query->orderByDesc('created_at')),

            'Perlu Validasi' => Tab::make()
                ->badge(fn() => $this->getValidationTabCount($effectivePeriodeId))
                ->modifyQueryUsing(function ($query) {
                    $user = Auth::user();
                    return $user?->hasRole('super_admin')
                        ? $query->where('status', 'pending')->orderByDesc('created_at')
                        : $query->where('status', 'pending')
                        ->where('validated_by', $user->id)
                        ->orderByDesc('created_at');
                }),

            'Validasi Saya' => Tab::make()
                ->badge(fn() => $this->getMyValidationTabCount($effectivePeriodeId))
                ->modifyQueryUsing(
                    fn($query) => $query->where('validated_by', Auth::id())->orderByDesc('created_at')
                ),
        ];
    }

    protected function getEffectivePeriodeId(): ?int
    {
        // Check if user manually changed the filter
        $userOverrode = session('user_overrode_periode_filter', false);
        
        if ($userOverrode) {
            // Use the current filter value if user overrode
            return $this->tableFilters['periode_id']['value'] ?? null;
        }
        
        // Otherwise use PeriodeSwitcher value
        return session('selected_periode_id') ?? 
            Periode::where('status_periode', 'active')->where('status', 'validated')->first()?->id;
    }

    protected function getTabCount(?int $periodeId): int
    {
        $query = Jadwal::query();
        if ($periodeId) {
            $query->where('periode_id', $periodeId);
        }
        return $query->count();
    }

    protected function getValidationTabCount(?int $periodeId): int
    {
        $user = Auth::user();
        $query = Jadwal::query();
        
        if ($periodeId) {
            $query->where('periode_id', $periodeId);
        }
        
        return $user?->hasRole('super_admin')
            ? $query->where('status', 'pending')->count()
            : $query->where('status', 'pending')->where('validated_by', $user->id)->count();
    }

    protected function getMyValidationTabCount(?int $periodeId): int
    {
        $query = Jadwal::query();
        if ($periodeId) {
            $query->where('periode_id', $periodeId);
        }
        return $query->where('validated_by', Auth::id())->count();
    }
}