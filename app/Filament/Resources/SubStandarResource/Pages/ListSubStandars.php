<?php

namespace App\Filament\Resources\SubStandarResource\Pages;

use Filament\Actions;
use App\Models\SubStandar;
use Illuminate\Support\Facades\Auth;
use Filament\Resources\Components\Tab;
use Filament\Resources\Pages\ListRecords;
use App\Filament\Resources\SubStandarResource;

class ListSubStandars extends ListRecords
{
    protected static string $resource = SubStandarResource::class;

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
$isAssigned = SubStandar::where('validated_by', $userId)->exists();
if (! $isSuperAdmin && ! $isAssigned) {
    return [];
}
        return [
            'Semua' => Tab::make()
                ->badge(fn() => SubStandar::count())
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->orderByDesc('created_at')
                ),

            'Need Validation' => Tab::make()
                ->badge(
                    fn() =>
                    Auth::user()?->hasRole('super_admin')
                        ? SubStandar::where('status', 'pending')->count()
                        : SubStandar::where('status', 'pending')
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
                    SubStandar::where('validated_by', Auth::id())->count()
                )
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->where('validated_by', Auth::id())->orderByDesc('created_at')
                ),
        ];
    }
}
