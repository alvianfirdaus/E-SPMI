<?php

namespace App\Filament\Resources\PengisianIndikatorResource\Pages;

use Filament\Actions;
use Illuminate\Support\Facades\Auth;
use Filament\Resources\Components\Tab;
use Filament\Resources\Pages\ListRecords;
use Illuminate\Database\Eloquent\Builder;
use App\Filament\Resources\PengisianIndikatorResource;

class ListPengisianIndikators extends ListRecords
{
    protected static string $resource = PengisianIndikatorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('refresh')
                ->label('Refresh')
                ->icon('heroicon-o-arrow-path')
                ->action(fn() => $this->resetTable()),
        ];
    }

    public function getTabs(): array
    {
        $user = Auth::user();

        return [
            'all' => Tab::make('Semua Tugas')
                ->badge(function () {
                    return PengisianIndikatorResource::getEloquentQuery()->count();
                }),

            'my_tasks' => Tab::make('Tugas Saya')
                ->modifyQueryUsing(function (Builder $query) use ($user) {
                    return $query->whereHas('unitIndikator', function ($q) use ($user) {
                        $q->where('auditee', $user->id);
                    });
                })
                ->badge(function () use ($user) {
                    return PengisianIndikatorResource::getEloquentQuery()
                        ->whereHas('unitIndikator', function ($q) use ($user) {
                            $q->where('auditee', $user->id);
                        })->count();
                }),


            'unit_tasks' => Tab::make('Tugas Unit Saya')
                ->modifyQueryUsing(function (Builder $query) use ($user) {
                    return $query->whereHas('unitIndikator.unit', function ($q) use ($user) {
                        $q->where('id', $user->unit_id);
                    });
                })
                ->badge(function () use ($user) {
                    return PengisianIndikatorResource::getEloquentQuery()
                        ->whereHas('unitIndikator.unit', function ($q) use ($user) {
                            $q->where('id', $user->unit_id);
                        })->count();
                }),

            'pending' => Tab::make('Belum Selesai')
                ->modifyQueryUsing(
                    fn(Builder $query) =>
                    $query->whereIn('status_pengisian', ['pending'])
                )
                ->badge(function () {
                    return PengisianIndikatorResource::getEloquentQuery()
                        ->whereIn('status_pengisian', ['pending'])
                        ->count();
                }),

            'deadline_soon' => Tab::make('Deadline Dekat')
                ->modifyQueryUsing(
                    fn(Builder $query) =>
                    $query->where('end_date', '<=', now()->addDays(3))
                        ->where('end_date', '>=', now())
                        ->whereNotIn('status_pengisian', ['selesai'])
                )
                ->badge(function () {
                    return PengisianIndikatorResource::getEloquentQuery()
                        ->where('end_date', '<=', now()->addDays(3))
                        ->where('end_date', '>=', now())
                        ->whereNotIn('status_pengisian', ['selesai'])
                        ->count();
                })
                ->badgeColor('danger'),

            'completed' => Tab::make('Selesai')
                ->modifyQueryUsing(
                    fn(Builder $query) =>
                    $query->where('status_pengisian', 'selesai')
                )
                ->badge(function () {
                    return PengisianIndikatorResource::getEloquentQuery()
                        ->where('status_pengisian', 'selesai')
                        ->count();
                })
                ->badgeColor('success'),
        ];
    }
}
