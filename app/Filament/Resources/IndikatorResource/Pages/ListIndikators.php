<?php

namespace App\Filament\Resources\IndikatorResource\Pages;

use App\Filament\Resources\IndikatorResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;
use Illuminate\Support\Facades\Auth;
use Filament\Resources\Components\Tab;
use App\Models\Indikator;

class ListIndikators extends ListRecords
{
    protected static string $resource = IndikatorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
    
    public function getTabs(): array
    {
        $user = Auth::user();
        $userId = $user?->id;
        
        $isAuditor = $user->hasRole('auditor');
        $isAuditee = $user->hasRole('auditee');
        $isAssigned = Indikator::where('validated_by', $userId)->exists();
        if (! $isAuditor && ! $isAssigned && ! $isAuditee) {
            return [];
        }
        return [
            'Semua' => Tab::make()
                ->badge(fn() => Indikator::count())
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->orderByDesc('created_at')
                ),

            'Need Validation' => Tab::make()
                ->badge(
                    fn() =>
                    Auth::user()?->hasRole('auditor')
                        ? Indikator::where('status', 'pending')->count()
                        : Indikator::where('status', 'pending')
                        ->where('validated_by', Auth::id())
                        ->count()
                )
                ->modifyQueryUsing(function ($query) {
                    $user = Auth::user();
                    if ($user->hasRole('auditor')) {
                        return $query->where('status', 'pending')->orderByDesc('created_at');
                    }
                    if ($user->hasRole('auditee')) {
                        return $query->where('auditee_id', $user->id)->orderByDesc('created_at');
                    }
                    // return $user?->hasRole('auditor')
                    //     ? $query->where('status', 'pending')->orderByDesc('created_at')
                        return $query->where('status', 'pending')
                        ->where('validated_by', $user->id)
                        ->orderByDesc('created_at');
                }),

            'My Validation' => Tab::make()
                ->badge(
                    fn() =>
                    Indikator::where('validated_by', Auth::id())->count()
                )
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->where('validated_by', Auth::id())->orderByDesc('created_at')
                ),
        ];
    }
}
