<?php

namespace App\Filament\Resources\SubStandarResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;
use App\Filament\Resources\SubStandarResource;

class ViewSubStandar extends ViewRecord
{
    protected static string $resource = SubStandarResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
        ];
    }

    protected function mutateFormDataBeforeFill(array $data): array
    {
        // Load validator role if exists
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
