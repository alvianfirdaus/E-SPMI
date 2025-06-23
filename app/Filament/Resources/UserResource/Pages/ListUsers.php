<?php

namespace App\Filament\Resources\UserResource\Pages;

use App\Imports\UsersImport;
use App\Filament\Resources\UserResource;
use Filament\Actions\CreateAction;
use Filament\Pages\Actions\Action;
use Filament\Resources\Pages\ListRecords;
use Filament\Forms\Components\FileUpload;
use Illuminate\Support\Facades\Storage;
use Maatwebsite\Excel\Facades\Excel;

class ListUsers extends ListRecords
{
    protected static string $resource = UserResource::class;

    protected function getHeaderActions(): array
    {
        return [
            CreateAction::make(),

            Action::make('Import Users')
                ->form([
                    FileUpload::make('file')
                        ->required()
                        ->label('Excel File')
                        ->acceptedFileTypes([
                            'text/csv', // CSV
                'text/plain', // sometimes used for CSV
                            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                            'application/vnd.ms-excel',
                        ])
                        ->directory('temp-imports'),
                ])
                ->action(function (array $data) {
                    $relativePath = $data['file']; // e.g., "temp-imports/file.xlsx"
                    $absolutePath = Storage::path($relativePath);

                    // Perform import
                    Excel::import(new UsersImport, $absolutePath);

                    // Delete the uploaded file
                    Storage::delete($relativePath);

                    $this->notify('success', 'Users imported and file deleted.');
                })
                ->modalHeading('Import Users from Excel')
                ->modalSubmitActionLabel('Import'),
        ];
    }
}
