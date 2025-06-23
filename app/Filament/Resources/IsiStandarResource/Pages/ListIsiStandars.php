<?php

namespace App\Filament\Resources\IsiStandarResource\Pages;

use App\Models\IsiStandar;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Filament\Resources\Components\Tab;
use Filament\Resources\Pages\ListRecords;
use App\Filament\Resources\IsiStandarResource;
use Filament\Actions;

class ListIsiStandars extends ListRecords
{
    protected static string $resource = IsiStandarResource::class;

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
        $isAssigned = IsiStandar::where('validated_by', $userId)->exists();
        if (! $isSuperAdmin && ! $isAssigned) {
            return [];
        }
        return [
            'Semua' => Tab::make()
                ->badge(fn() => IsiStandar::count())
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->orderByDesc('created_at')
                ),

            'Need Validation' => Tab::make()
                ->badge(
                    fn() =>
                    Auth::user()?->hasRole('super_admin')
                        ? IsiStandar::where('status', 'pending')->count()
                        : IsiStandar::where('status', 'pending')
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
                    IsiStandar::where('validated_by', Auth::id())->count()
                )
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->where('validated_by', Auth::id())->orderByDesc('created_at')
                ),
        ];
    }
}
