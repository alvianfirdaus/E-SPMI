<?php

namespace App\Filament\Resources\AssignPengisianResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Resources\Pages\ViewRecord;
use App\Models\AuditorAssignment;
use App\Filament\Resources\AssignPengisianResource;

class ViewAssignPengisian extends ViewRecord
{
    
    protected static string $resource = AssignPengisianResource::class;

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
    if (isset($data['id']) && !empty($data['id'])) {
        $assignAuditor = AuditorAssignment::where('assign_pengisian_id', $data['id'])->first();

        if ($assignAuditor) {
            if ($assignAuditor->auditor1) {
                $auditor1 = User::find($assignAuditor->auditor1);
                if ($auditor1) {
                    $data['auditor1_role'] = $auditor1->roles->first()?->name;
                    $data['auditor1_id'] = $auditor1->id;
                    $data['auditor1_unit_id'] = $auditor1->unit_id;
                }
            }

            if ($assignAuditor->auditor2) {
                $auditor2 = User::find($assignAuditor->auditor2);
                if ($auditor2) {
                    $data['auditor2_role'] = $auditor2->roles->first()?->name;
                    $data['auditor2_id'] = $auditor2->id;
                    $data['auditor2_unit_id'] = $auditor2->unit_id;
                }
            }
        }
    }

    if (isset($data['validated_by']) && !empty($data['validated_by'])) {
        $validator = User::find($data['validated_by']);
        if ($validator) {
            $data['role'] = $validator->roles->first()?->name;
            $data['validated_by'] = $validator->id;
        }
    }

    return $data;
}

}
