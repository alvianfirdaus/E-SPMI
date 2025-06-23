<?php

namespace App\Filament\Resources\UnitResource\Pages;

use App\Models\User;
use Filament\Actions;
use App\Filament\Resources\UnitResource;
use Filament\Resources\Pages\CreateRecord;

class CreateUnit extends CreateRecord
{
    protected static string $resource = UnitResource::class;
    protected static bool $canCreateAnother = false;
    public function getRedirectUrl(): string
    {
        $userIds = $this->form->getState()['user_ids'] ?? [];

        // Assign selected users to the new unit
        if (!empty($userIds)) {
            User::whereIn('id', $userIds)->update([
                'unit_id' => $this->record->id,
            ]);
        }
        return $this->getResource()::getUrl('index');
    }
    protected function afterSave(): void {}
}
