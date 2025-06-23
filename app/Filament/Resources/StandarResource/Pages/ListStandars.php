<?php

namespace App\Filament\Resources\StandarResource\Pages;

use Filament\Actions;
use App\Models\Standar;
use Illuminate\Support\Facades\Auth;
use Filament\Resources\Components\Tab;
use Filament\Resources\Pages\ListRecords;
use App\Filament\Resources\StandarResource;

class ListStandars extends ListRecords
{
    protected static string $resource = StandarResource::class;
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
        $isAssigned = Standar::where('validated_by', $userId)->exists();
        if (! $isSuperAdmin && ! $isAssigned) {
            return [];
        }
        return [
            'Semua' => Tab::make()
                ->badge(fn() => Standar::count())
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->orderByDesc('created_at')
                ),

            'Perlu Validasi' => Tab::make()
                ->badge(
                    fn() =>
                    Auth::user()?->hasRole('super_admin')
                        ? Standar::where('status', 'pending')->count()
                        : Standar::where('status', 'pending')
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

            'Validasi Saya' => Tab::make()
                ->badge(
                    fn() =>
                    Standar::where('validated_by', Auth::id())->count()
                )
                ->modifyQueryUsing(
                    fn($query) =>
                    $query->where('validated_by', Auth::id())->orderByDesc('created_at')
                ),
        ];
    }
}
