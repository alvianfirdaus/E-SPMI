<?php

namespace App\Filament\Resources\UnitIndikatorResource\Pages;

use Filament\Actions;
use App\Models\Indikator;
use Illuminate\Support\Facades\Auth;
use App\Models\UnitIndikatorIndikator;
use App\Models\UnitIndikatorIsiIndikator;
use Filament\Resources\Pages\CreateRecord;
use App\Filament\Resources\UnitIndikatorResource;

class CreateUnitIndikator extends CreateRecord
{
    protected static string $resource = UnitIndikatorResource::class;

    protected array $indikatorSet = [];
    protected array $formData = [];

    protected function mutateFormDataBeforeCreate(array $data): array
    {
        $this->formData = $data;
        $this->indikatorSet = $data['indikator_set'] ?? [];

        // Rename auditee_ field to auditee to match database schema
        if (isset($data['auditee_'])) {
            $data['auditee'] = $data['auditee_'];
            unset($data['auditee_']);
        }

        // Process each standar in the indikator_set
        foreach ($this->indikatorSet as $i => $standarItem) {
            // Process each indikator within the standar
            foreach ($standarItem['indikator'] ?? [] as $j => $indikatorItem) {
                $indikatorId = $indikatorItem['indikator_id'] ?? null;
                if (!$indikatorId) continue;

                // Initialize the isi_indikator array
                $this->indikatorSet[$i]['indikator'][$j]['isi_indikator'] = [];

                // Get all IsiIndikator records for this indikator
                $isiIndikators = \App\Models\IsiIndikator::where('indikator_id', $indikatorId)->get();

                // Process each IsiIndikator
                foreach ($isiIndikators as $isi) {
                    $isiId = $isi->id;
                    
                    // The flat fields are INSIDE the indikator item, not at the top level
                    $pertanyaanKey = "pertanyaan_{$isiId}";
                    $targetKey = "target_{$isiId}";
                    $buktiKey = "bukti_{$isiId}";
                    
                    $pertanyaanValue = $indikatorItem[$pertanyaanKey] ?? null;
                    $targetValue = $indikatorItem[$targetKey] ?? null;
                    $buktiValue = $indikatorItem[$buktiKey] ?? null;

                    // Create the isi indikator data structure
                    $isiIndikatorData = [
                        'id' => $isiId,
                        'pertanyaan' => $pertanyaanValue ?? '',
                        'target' => $targetValue ?? '',
                        'bukti' => $buktiValue ?? '',
                    ];

                    // Add to the array
                    $this->indikatorSet[$i]['indikator'][$j]['isi_indikator'][] = $isiIndikatorData;
                }

                // Clean up the flat fields from the indikator item
                foreach (array_keys($indikatorItem) as $key) {
                    if (str_starts_with($key, 'pertanyaan_') || 
                        str_starts_with($key, 'target_') || 
                        str_starts_with($key, 'bukti_')) {
                        unset($this->indikatorSet[$i]['indikator'][$j][$key]);
                    }
                }
                
                // Also clean up isi_indikator_inputs since we don't need it
                unset($this->indikatorSet[$i]['indikator'][$j]['isi_indikator_inputs']);
            }
        }

        // Remove the indikator_set and isi_indikator_inputs from main data
        unset($data['indikator_set']);
        unset($data['isi_indikator_inputs']);

        // Add created_by if your model requires it
        $data['created_by'] = Auth::id();

        return $data;
    }

    protected function afterCreate(): void
    {
        // Check if we have the data we need
        if (empty($this->indikatorSet)) {
            return;
        }

        foreach ($this->indikatorSet as $standarIndex => $standarItem) {
            $standarId = $standarItem['standar_id'] ?? null;
            if (!$standarId) continue;

            $unitIndikatorStandar = $this->record->unitIndikatorStandars()->create([
                'standar_id' => $standarId,
            ]);

            foreach ($standarItem['indikator'] ?? [] as $indikatorIndex => $indikatorItem) {
                $indikatorId = $indikatorItem['indikator_id'] ?? null;
                if (!$indikatorId) continue;

                $unitIndikatorIndikator = UnitIndikatorIndikator::create([
                    'indikator_id' => $indikatorId,
                    'unit_indikator_standar_id' => $unitIndikatorStandar->id,
                ]);

                foreach ($indikatorItem['isi_indikator'] ?? [] as $isiIndex => $isiItem) {
                    $isiIndikatorId = $isiItem['id'] ?? null;
                    if (!$isiIndikatorId) continue;

                    UnitIndikatorIsiIndikator::create([
                        'unit_indikator_indikator_id' => $unitIndikatorIndikator->id,
                        'isi_indikator_id' => $isiIndikatorId,
                        'pertanyaan' => $isiItem['pertanyaan'] ?? '',
                        'target' => $isiItem['target'] ?? '',
                        'bukti' => $isiItem['bukti'] ?? '',
                    ]);
                }
            }
        }
    }
}