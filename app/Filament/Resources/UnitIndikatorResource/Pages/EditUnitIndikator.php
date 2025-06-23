<?php

namespace App\Filament\Resources\UnitIndikatorResource\Pages;

use Filament\Actions;
use App\Models\Indikator;
use App\Models\UnitIndikatorIndikator;
use Filament\Resources\Pages\EditRecord;
use App\Models\UnitIndikatorIsiIndikator;
use App\Filament\Resources\UnitIndikatorResource;

class EditUnitIndikator extends EditRecord
{
    protected static string $resource = UnitIndikatorResource::class;
    
    protected array $indikatorSet = [];

    protected function mutateFormDataBeforeFill(array $data): array
    {
        // Get the unit_indikator_standars with all related data
        $unitIndikatorStandars = $this->record->unitIndikatorStandars()
            ->with(['unitIndikatorIndikators.unitIndikatorIsiIndikators'])
            ->get();
        
        // Prepare indikator_set
        $data['indikator_set'] = [];

        foreach ($unitIndikatorStandars as $unitIndikatorStandar) {
            $standarSet = [
                'standar_id' => $unitIndikatorStandar->standar_id,
                'tahun' => optional($unitIndikatorStandar->standar)->tahun,
                'indikator' => []
            ];
            
            $indikatorRecords = $unitIndikatorStandar->unitIndikatorIndikators;
            
            if ($indikatorRecords && $indikatorRecords->isNotEmpty()) {
                foreach ($indikatorRecords as $indikatorRecord) {
                    $indikatorSet = [
                        'indikator_id' => $indikatorRecord->indikator_id,
                        'isi_indikator_inputs' => [], // This might be needed for the form
                    ];
                
                    $isiIndikatorRecords = $indikatorRecord->unitIndikatorIsiIndikators;
                
                    // Add the flat fields directly to the indikator set (same as create form structure)
                    foreach ($isiIndikatorRecords as $isiRecord) {
                        $isiId = $isiRecord->isi_indikator_id;
                        
                        // Add the flat fields that the form expects
                        $indikatorSet["pertanyaan_{$isiId}"] = $isiRecord->pertanyaan;
                        $indikatorSet["target_{$isiId}"] = $isiRecord->target;
                        $indikatorSet["bukti_{$isiId}"] = $isiRecord->bukti;

                        // Also add to isi_indikator_inputs if needed
                        $indikatorSet['isi_indikator_inputs'][] = [
                            'id' => $isiId,
                            'pertanyaan_field' => $isiRecord->pertanyaan,
                            'target_field' => $isiRecord->target,
                            'bukti_field' => $isiRecord->bukti,
                        ];
                    }
                
                    $standarSet['indikator'][] = $indikatorSet;
                }
            } 
            $data['indikator_set'][] = $standarSet;
        }

        // Handle auditee data
        $auditeeUser = \App\Models\User::find($this->record->auditee);
        if ($auditeeUser) {
            $data['auditee_role'] = $auditeeUser->roles->pluck('name')->first();
            $data['auditee_unit_id'] = $auditeeUser->unit_id;
            $data['auditee'] = $this->record->auditee;
        }

        // Initialize isi_indikator_inputs at the top level if needed
        $data['isi_indikator_inputs'] = [];

        return $data;
    }

    protected function mutateFormDataBeforeSave(array $data): array
    {
        // Store the indikator_set for processing in afterSave
        $this->indikatorSet = $data['indikator_set'] ?? [];

        // Process the flat fields into nested structure (same as create)
        foreach ($this->indikatorSet as $i => $standarItem) {
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
                    
                    // The flat fields are INSIDE the indikator item
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

        // Remove from main data
        unset($data['indikator_set']);
        unset($data['isi_indikator_inputs']);

        return $data;
    }

    protected function afterSave(): void
    {
        if (empty($this->indikatorSet)) {
            return;
        }

        // Get existing standar IDs
        $existingStandarIds = $this->record->unitIndikatorStandars()->pluck('standar_id')->toArray();
        $submittedStandarIds = collect($this->indikatorSet)->pluck('standar_id')->toArray();

        // Delete removed standars and their related records
        $standarIdsToDelete = array_diff($existingStandarIds, $submittedStandarIds);
        if (!empty($standarIdsToDelete)) {
            foreach ($this->record->unitIndikatorStandars()->whereIn('standar_id', $standarIdsToDelete)->get() as $standarRecord) {
                // Delete all related records
                foreach ($standarRecord->unitIndikatorIndikators as $indikatorRecord) {
                    $indikatorRecord->unitIndikatorIsiIndikators()->delete();
                    $indikatorRecord->delete();
                }
                $standarRecord->delete();
            }
        }

        // Process submitted standars
        foreach ($this->indikatorSet as $standarItem) {
            $standarId = $standarItem['standar_id'] ?? null;
            if (!$standarId) continue;

            // Create or update standar record
            $unitIndikatorStandar = $this->record->unitIndikatorStandars()->firstOrCreate([
                'standar_id' => $standarId
            ]);

            // Get existing and submitted indikator IDs for this standar
            $existingIndikatorIds = $unitIndikatorStandar->unitIndikatorIndikators()->pluck('indikator_id')->toArray();
            $submittedIndikatorIds = collect($standarItem['indikator'] ?? [])->pluck('indikator_id')->toArray();

            // Delete removed indikators and their related records
            $indikatorIdsToDelete = array_diff($existingIndikatorIds, $submittedIndikatorIds);
            if (!empty($indikatorIdsToDelete)) {
                foreach ($unitIndikatorStandar->unitIndikatorIndikators()->whereIn('indikator_id', $indikatorIdsToDelete)->get() as $indikatorRecord) {
                    $indikatorRecord->unitIndikatorIsiIndikators()->delete();
                    $indikatorRecord->delete();
                }
            }

            // Process submitted indikators
            foreach ($standarItem['indikator'] ?? [] as $indikatorItem) {
                $indikatorId = $indikatorItem['indikator_id'] ?? null;
                if (!$indikatorId) continue;

                // Create or update indikator record
                $unitIndikatorIndikator = $unitIndikatorStandar->unitIndikatorIndikators()->firstOrCreate([
                    'indikator_id' => $indikatorId,
                ]);

                // Get existing isi_indikator IDs for this indikator
                $existingIsiIndikatorIds = $unitIndikatorIndikator->unitIndikatorIsiIndikators()->pluck('isi_indikator_id')->toArray();
                $submittedIsiIndikatorIds = collect($indikatorItem['isi_indikator'] ?? [])->pluck('id')->toArray();

                // Delete removed isi_indikators
                $isiIndikatorIdsToDelete = array_diff($existingIsiIndikatorIds, $submittedIsiIndikatorIds);
                if (!empty($isiIndikatorIdsToDelete)) {
                    $unitIndikatorIndikator->unitIndikatorIsiIndikators()
                        ->whereIn('isi_indikator_id', $isiIndikatorIdsToDelete)
                        ->delete();
                }

                // Process submitted isi_indikators
                foreach ($indikatorItem['isi_indikator'] ?? [] as $isiItem) {
                    $isiIndikatorId = $isiItem['id'] ?? null;
                    if (!$isiIndikatorId) continue;

                    // Update or create isi_indikator record
                    UnitIndikatorIsiIndikator::updateOrCreate(
                        [
                            'unit_indikator_indikator_id' => $unitIndikatorIndikator->id,
                            'isi_indikator_id' => $isiIndikatorId,
                        ],
                        [
                            'pertanyaan' => $isiItem['pertanyaan'] ?? '',
                            'target' => $isiItem['target'] ?? '',
                            'bukti' => $isiItem['bukti'] ?? '',
                        ]
                    );
                }
            }
        }

        // Update record status
        $this->record->update([
            'status' => 'pending',
            'status_validasi_1' => 'pending',
            'status_validasi_2' => 'pending',
            'validated_time_1' => null,
            'validated_time_2' => null,
        ]);
    }

    protected function getHeaderActions(): array
    {
        return [
            Actions\ViewAction::make(),
            Actions\DeleteAction::make(),
        ];
    }
}