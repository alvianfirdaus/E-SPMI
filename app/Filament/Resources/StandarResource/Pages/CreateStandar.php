<?php

namespace App\Filament\Resources\StandarResource\Pages;

use App\Filament\Resources\StandarResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateStandar extends CreateRecord
{
    protected static string $resource = StandarResource::class;
    protected static bool $canCreateAnother = false;
    public function getRedirectUrl(): string{
        return $this->getResource()::getUrl('index');
    }

    protected function getCreateFormAction(): Actions\Action{
        return parent::getCreateFormAction()
        ->submit(form:null)
        ->requiresConfirmation()
        ->action(function(){
            $this->closeActionModal();
            $this->create();
        });
    }
    
}
