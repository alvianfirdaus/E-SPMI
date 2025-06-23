<?php

namespace App\Filament\Resources\PengisianIndikatorResource\Pages;

use App\Filament\Resources\PengisianIndikatorResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditPengisianIndikator extends EditRecord
{
    protected static string $resource = PengisianIndikatorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }

    protected function afterSave(): void
{
    if (isset($this->data['auditor_ids'])) {
        $this->record->auditors()->sync($this->data['auditor_ids']);
    }
}
}
