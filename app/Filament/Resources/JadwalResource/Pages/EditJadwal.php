<?php

namespace App\Filament\Resources\JadwalResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;
use App\Filament\Resources\JadwalResource;

class EditJadwal extends EditRecord
{
    protected static string $resource = JadwalResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make()
                ->icon('heroicon-m-eye'),
        ];
    }

    protected function mutateFormDataBeforeSave(array $data): array
    {
        // Remove the role field as it's just for filtering
        unset($data['role']);

        return $data;
    }

    public function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }

    protected function mutateFormDataBeforeFill(array $data): array
    {
        if (isset($data['validated_by']) && !empty($data['validated_by'])) {
            $validator = User::find($data['validated_by']);
            if ($validator) {
                $role = $validator->roles->first() ? $validator->roles->first()->name : null;
                $data['role'] = $role;
            }
        }

        return $data;
    }

    protected function afterSave(): void
    {
        // Always set status to pending after any update
        // This ensures any changes require re-validation
        $this->record->update([
            'status' => 'pending',
            'validated_time' => null,
        ]);
        
        // Dispatch event for other components to refresh
        $this->dispatch('refresh-assign-table');
    }
}
