<?php

namespace App\Filament\Resources\UnitResource\Pages;

use App\Models\User;
use Filament\Actions;
use App\Filament\Resources\UnitResource;
use Filament\Resources\Pages\EditRecord;

class EditUnit extends EditRecord
{
    protected static string $resource = UnitResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
        ];
    }

    public function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }

    protected function afterSave(): void
    {
        $userIds = $this->form->getState()['user_ids'] ?? [];

    // Unassign semua user dari unit ini
    User::where('unit_id', $this->record->id)->update(['unit_id' => null]);

    // Assign user yang dipilih ke unit ini
    if (!empty($userIds)) {
        User::whereIn('id', $userIds)->update(['unit_id' => $this->record->id]);
    }
    }

    protected function mutateFormDataBeforeFill(array $data): array
    {
        $data['user_ids'] = $this->record->users()->pluck('id')->toArray();
        return $data;
    }

}
