<?php

namespace App\Filament\Resources\AssignPengisianResource\Pages;

use Filament\Actions;
use Livewire\Attributes\On;
use Filament\Resources\Pages\ListRecords;
use App\Filament\Resources\AssignPengisianResource;
use Illuminate\Database\Eloquent\Builder; // <-- ✅ ADD THIS LINE

class ListAssignPengisians extends ListRecords
{
  public static function getEloquentQuery(): Builder
{
    return parent::getEloquentQuery()
        ->with([
            'unitIndikator.unit',
            'unitIndikator.auditeeUser',
            'periode',
            'assignAuditors.auditor1Relation',
            'assignAuditors.auditor2Relation',
        ]);
}
    protected static string $resource = AssignPengisianResource::class;
    #[On('refresh-assign-table')]
    public function refreshThisPage(){
        return rand(0,100);
    }
    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
