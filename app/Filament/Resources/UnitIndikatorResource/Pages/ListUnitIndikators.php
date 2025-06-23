<?php

namespace App\Filament\Resources\UnitIndikatorResource\Pages;

use Filament\Actions;
use App\Models\UnitIndikator;
use Illuminate\Support\Facades\Auth;
use Filament\Resources\Components\Tab;
use Filament\Resources\Pages\ListRecords;
use App\Filament\Resources\UnitIndikatorResource;

class ListUnitIndikators extends ListRecords
{
    protected static string $resource = UnitIndikatorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }

    // public function getTabs(): array
    // {
    //     $user = Auth::user();
    //     $userId = $user?->id;
        
    //     $isSuperAdmin = $user->hasRole('super_admin');
    //     $isAssigned = UnitIndikator::where('validated_by', $userId)->exists();
    //     if (! $isSuperAdmin && ! $isAssigned) {
    //         return [];
    //     }
    //     return [
    //         'Semua' => Tab::make()
    //             ->badge(fn() => UnitIndikator::count())
    //             ->modifyQueryUsing(
    //                 fn($query) =>
    //                 $query->orderByDesc('created_at')
    //             ),

    //         'Need Validation' => Tab::make()
    //             ->badge(
    //                 fn() =>
    //                 Auth::user()?->hasRole('super_admin')
    //                     ? UnitIndikator::where('status', 'pending')->count()
    //                     : UnitIndikator::where('status', 'pending')
    //                     ->where('validated_by', Auth::id())
    //                     ->count()
    //             )
    //             ->modifyQueryUsing(function ($query) {
    //                 $user = Auth::user();
    //                 return $user?->hasRole('super_admin')
    //                     ? $query->where('status', 'pending')->orderByDesc('created_at')
    //                     : $query->where('status', 'pending')
    //                     ->where('validated_by', $user->id)
    //                     ->orderByDesc('created_at');
    //             }),

    //         'My Validation' => Tab::make()
    //             ->badge(
    //                 fn() =>
    //                 UnitIndikator::where('validated_by', Auth::id())->count()
    //             )
    //             ->modifyQueryUsing(
    //                 fn($query) =>
    //                 $query->where('validated_by', Auth::id())->orderByDesc('created_at')
    //             ),
    //     ];
    // }
}
