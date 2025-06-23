<?php

namespace App\Filament\Resources\IndikatorResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;
use App\Filament\Resources\IndikatorResource;

class ViewIndikator extends ViewRecord
{
    protected static string $resource = IndikatorResource::class;

        /**
     * Get the completion action.
     *
     * @return Filament\Actions\Action
     * @throws Exception
     */
    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
        ];
    }

    protected function mutateFormDataBeforeFill(array $data): array
    {
        $data['isi_indikators'] = $this->record->isiIndikators?->map(fn($isi) => [
            'isi_indikator' => $isi->isi_indikator,
            'target' => $isi->target,
        ])->toArray() ?? [];
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

    

