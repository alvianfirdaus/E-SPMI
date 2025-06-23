<?php

namespace App\Filament\Resources\StandarResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;
use App\Filament\Resources\StandarResource;

class ViewStandar extends ViewRecord
{
    protected static string $resource = StandarResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make()
                ->icon('heroicon-m-pencil-square'),
        ];
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
}
