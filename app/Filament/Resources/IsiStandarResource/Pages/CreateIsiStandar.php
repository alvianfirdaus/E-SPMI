<?php

namespace App\Filament\Resources\IsiStandarResource\Pages;

use App\Filament\Resources\IsiStandarResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateIsiStandar extends CreateRecord
{
    protected static string $resource = IsiStandarResource::class;
    protected static bool $canCreateAnother = false;

    public function getRedirectUrl(): string{
        return $this->getResource()::getUrl('index');
    }
}
