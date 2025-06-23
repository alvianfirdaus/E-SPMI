<?php

namespace App\Filament\Resources\ReviewIndikatorResource\Pages;

use App\Filament\Resources\ReviewIndikatorResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditReviewIndikator extends EditRecord
{
    protected static string $resource = ReviewIndikatorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
