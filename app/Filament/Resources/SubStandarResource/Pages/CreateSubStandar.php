<?php

namespace App\Filament\Resources\SubStandarResource\Pages;

use App\Filament\Resources\SubStandarResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateSubStandar extends CreateRecord
{
    protected static string $resource = SubStandarResource::class;
    protected static bool $canCreateAnother = false;
    public function getRedirectUrl(): string{
        return $this->getResource()::getUrl('index');
    }
}
