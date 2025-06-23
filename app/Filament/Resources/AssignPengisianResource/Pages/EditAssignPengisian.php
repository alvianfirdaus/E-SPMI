<?php

namespace App\Filament\Resources\AssignPengisianResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;
use App\Models\AuditorAssignment;
use App\Filament\Resources\AssignPengisianResource;

class EditAssignPengisian extends EditRecord
{
    protected static string $resource = AssignPengisianResource::class;

    protected function mutaPteFormDataBeforeFill(array $data): array
{
    if (!empty($data['id'])) {
        $assignAuditor = AuditorAssignment::where('assign_pengisian_id', $data['id'])->first();

        if ($assignAuditor) {
            if (!empty($assignAuditor->auditor1)) {
                $auditor1 = User::find($assignAuditor->auditor1);
                if ($auditor1) {
                    $data['auditor1_id'] = $auditor1->id;
                    $data['auditor1_role'] = $auditor1->roles->first()?->name;
                    $data['auditor1_unit_id'] = $auditor1->unit_id;
                }
            }

            if (!empty($assignAuditor->auditor2)) {
                $auditor2 = User::find($assignAuditor->auditor2);
                if ($auditor2) {
                    $data['auditor2_id'] = $auditor2->id;
                    $data['auditor2_role'] = $auditor2->roles->first()?->name;
                    $data['auditor2_unit_id'] = $auditor2->unit_id;
                }
            }
        }
    }

    // For validator
    if (!empty($data['validated_by'])) {
        $validator = User::find($data['validated_by']);
        if ($validator) {
            $data['validated_by'] = $validator->id;
            $data['role'] = $validator->roles->first()?->name;
        }
    }

    return $data;
}
protected function afterSave(): void
    {
        $data = $this->form->getState();

        // Assuming your form has 'auditor1_id' and 'auditor2_id' fields
        $auditor1Id = $data['auditor1_id'] ?? null;
        $auditor2Id = $data['auditor2_id'] ?? null;

        $assignAuditor = AuditorAssignment::updateOrCreate(
            ['assign_pengisian_id' => $this->record->id],
            [
                'auditor1' => $auditor1Id,
                'auditor2' => $auditor2Id,
            ]
        );
    }

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
