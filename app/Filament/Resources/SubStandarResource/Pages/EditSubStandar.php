<?php

namespace App\Filament\Resources\SubStandarResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;
use App\Filament\Resources\SubStandarResource;

class EditSubStandar extends EditRecord
{
    protected static string $resource = SubStandarResource::class;
    protected static bool $canCreateAnother = false;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
        ];
    }

    public function getRedirectUrl(): string{
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
        
        if (isset($data['standar_id']) && !empty($data['standar_id'])) {
            $standar = \App\Models\Standar::find($data['standar_id']);
            if ($standar) {
                $data['tahun'] = $standar->tahun;
            }
        }
        
        return $data;
    }
}
