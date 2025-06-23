<?php

namespace App\Filament\Resources\UnitIndikatorResource\Pages;

use App\Models\User;
use Filament\Actions;
use App\Models\Indikator;
use Filament\Resources\Pages\ViewRecord;
use App\Filament\Resources\UnitIndikatorResource;

class ViewUnitIndikator extends ViewRecord
{
    protected static string $resource = UnitIndikatorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
        ];
    }

    protected function mutateFormDataBeforeFill(array $data): array
    {
        // Let's see what we're working with first
        // dd($this->record->unitIndikatorStandars->load(['unitIndikatorIndikators.unitIndikatorIsiIndikators']));

        $unitIndikatorStandars = $this->record->unitIndikatorStandars;
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

                    // Add the flat fields directly to the indikator set
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
        $auditeeId = $this->record->auditee;

        if ($auditeeId && is_numeric($auditeeId)) {
            $auditeeUser = User::find($auditeeId);

            if ($auditeeUser) {
                $data['auditee_role'] = $auditeeUser->roles->pluck('name')->first() ?? null;
                $data['auditee_unit_id'] = $auditeeUser->unit_id ?? null;
                $data['auditee'] = $auditeeId;
            } else {
                $data['auditee_role'] = null;
                $data['auditee_unit_id'] = null;
                $data['auditee'] = $auditeeId;
            }
        } else {
            $data['auditee_role'] = null;
            $data['auditee_unit_id'] = null;
            $data['auditee'] = null;
        }

        // Initialize isi_indikator_inputs at the top level if needed
        $data['isi_indikator_inputs'] = [];

        // Debug the final structure
        // dd($data);

        return $data;
    }
}