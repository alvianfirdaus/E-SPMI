<?php

namespace App\Filament\Resources\AssignPengisianResource\Pages;

use App\Filament\Resources\AssignPengisianResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateAssignPengisian extends CreateRecord
{
    protected static string $resource = AssignPengisianResource::class;

    protected function afterCreate(): void
    {
        if (isset($this->data['auditor1_id']) && isset($this->data['auditor2_id'])) {
            $this->record->assignAuditors()->create([
                'auditor1' => $this->data['auditor1_id'],
                'auditor2' => $this->data['auditor2_id'],
            ]);
        }
    }
}
