<?php

namespace App\Filament\Resources\StandarResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;
use App\Filament\Resources\StandarResource;

class EditStandar extends EditRecord
{
    protected static string $resource = StandarResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make()
                ->icon('heroicon-m-eye')
,
        ];
    }

    protected function getSaveFormAction(): Actions\Action
    {
        return parent::getSaveFormAction()
            ->submit(form: null)
            ->requiresConfirmation()
            ->action(function () {
                $this->closeActionModal();
                $this->save();
            });
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
}
