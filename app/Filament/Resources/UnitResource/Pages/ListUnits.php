<?php

namespace App\Filament\Resources\UnitResource\Pages;

use App\Models\Unit;
use Filament\Actions;
use Filament\Actions\ImportAction;
use Illuminate\Support\Facades\Auth;
use App\Filament\Imports\UnitImporter;
use Filament\Resources\Components\Tab;
use App\Filament\Resources\UnitResource;
use Filament\Resources\Pages\ListRecords;

class ListUnits extends ListRecords
{
    protected static string $resource = UnitResource::class;

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
        
        $isSuperAdmin = $user->hasRole('super_admin');
        $isAssigned = Unit::where('validated_by', $userId)->exists();
        if (! $isSuperAdmin && ! $isAssigned) {
            return [];
        }
        return [
            'Semua' => Tab::make()
                ->badge(fn() => Unit::count())
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->orderByDesc('created_at')
                ),

            'Need Validation' => Tab::make()
                ->badge(
                    fn() =>
                    Auth::user()?->hasRole('super_admin')
                        ? Unit::where('status', 'pending')->count()
                        : Unit::where('status', 'pending')
                        ->where('validated_by', Auth::id())
                        ->count()
                )
                ->modifyQueryUsing(function ($query) {
                    $user = Auth::user();
                    return $user?->hasRole('super_admin')
                        ? $query->where('status', 'pending')->orderByDesc('created_at')
                        : $query->where('status', 'pending')
                        ->where('validated_by', $user->id)
                        ->orderByDesc('created_at');
                }),

            'My Validation' => Tab::make()
                ->badge(
                    fn() =>
                    Unit::where('validated_by', Auth::id())->count()
                )
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->where('validated_by', Auth::id())->orderByDesc('created_at')
                ),
        ];
    }
}
