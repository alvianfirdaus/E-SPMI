<?php

namespace App\Filament\Resources\JadwalResource\Pages;

use App\Filament\Resources\JadwalResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;

class CreateJadwal extends CreateRecord
{
    protected static string $resource = JadwalResource::class;
    
    // Handle the role field (not saved to database)
    protected function mutateFormDataBeforeCreate(array $data): array
    {
        // Remove the role field as it's just for filtering
        unset($data['role']);
        
        return $data;
    }
    
    // Handle saving related data
    protected function afterCreate(): void
    {
        $record = $this->record;
        
        // The jadwalAssignments are automatically handled by the Repeater relationship
        // The units are automatically handled by the Select relationship
        
        // You can add any additional logic here if needed
    }
}