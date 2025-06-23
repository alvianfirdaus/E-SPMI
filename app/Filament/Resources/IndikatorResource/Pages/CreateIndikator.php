<?php

namespace App\Filament\Resources\IndikatorResource\Pages;

use Filament\Actions;
use App\Models\IsiIndikator;
use Filament\Resources\Pages\CreateRecord;
use App\Filament\Resources\IndikatorResource;

class CreateIndikator extends CreateRecord
{
    protected static string $resource = IndikatorResource::class;

    protected function afterCreate(): void
    {
        $record = $this->record;
        $data = $this->data;

        foreach ($data['isi_indikators'] ?? [] as $item) {
            IsiIndikator::create([
                'indikator_id' => $record->id,
                'isi_indikator' => $item['isi_indikator'],
                'target' => $item['target'],
            ]);
        }
    }
}
