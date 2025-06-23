<?php

namespace App\Filament\Resources;

use Filament\Forms;
use App\Models\User;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\IsiStandar;
use Illuminate\Support\Str;
use Filament\Resources\Resource;
use App\Exports\IsiStandarExport;
use Illuminate\Support\HtmlString;
use Filament\Tables\Actions\Action;
use Illuminate\Support\Facades\Auth;
use Maatwebsite\Excel\Facades\Excel;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Enums\FiltersLayout;
use Filament\Tables\Filters\SelectFilter;
use App\Filament\Resources\IsiStandarResource\Pages;
use Malzariey\FilamentDaterangepickerFilter\Filters\DateRangeFilter;

class IsiStandarResource extends Resource
{
    protected static ?string $model = IsiStandar::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Manjemen Standar';
    protected static ?string $navigationLabel = 'Isi Standar';
    protected static ?int $navigationSort = 2;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Isi Standar')
                    ->schema([
                        Forms\Components\TextInput::make('nama_isi')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\TextInput::make('keterangan')
                            ->label('Keterangan Singkat')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\RichEditor::make('deskripsi')
                            ->required()
                            ->columnSpan('full')
                            ->toolbarButtons([
                                'bold',
                                'italic',
                                'underline',
                                'strike',
                                'bulletList',
                                'orderedList',
                            ]),
                    ])
                    ->columns(1),

                Forms\Components\Section::make('Validator')
                    ->description('Pilih role validator lalu user yang akan melakukan validasi.')
                    ->schema([
                        Forms\Components\Select::make('role')
                            ->label('Role Validator')
                            ->options(\Spatie\Permission\Models\Role::pluck('name', 'name'))
                            ->reactive()
                            ->required(),

                        Forms\Components\Select::make('validated_by')
                            ->label('User Validator')
                            ->options(function (callable $get) {
                                $role = $get('role');

                                if (! $role) return [];

                                return \App\Models\User::role($role)
                                    ->get()
                                    ->mapWithKeys(fn($user) => [
                                        $user->id => "{$user->nip} - {$user->name}",
                                    ])
                                    ->toArray();
                            })
                            ->searchable()
                            ->required()
                            ->visible(fn(callable $get) => filled($get('role'))),
                    ])
                    ->columns(2)
                    ->collapsible(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->groups([
                'status',
            ])
            ->groupingSettingsInDropdownOnDesktop()
            ->deferLoading()
            ->columns([
                Tables\Columns\TextColumn::make('nama_isi')
                    ->label('Nama Isi')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('keterangan')
                    ->wrap()
                    ->searchable()
                    ->sortable(),
                // TextColumn::make('deskripsi')
                //     ->label('Deskripsi')
                //     ->html()
                //     ->wrap()
                //     ->formatStateUsing(function ($state) {
                //         $state = str_replace('<ul>', '<ul style="list-style-type: disc; padding-left: 1rem;">', $state);
                //         $state = str_replace('<ol>', '<ol style="list-style-type: decimal; padding-left: 1rem;">', $state);
                //         $state = str_replace('<li>', '<li style="margin-bottom: 4px;">', $state);

                //         $plain = strip_tags($state);
                //         $limited = Str::limit($plain, 250);
                //         return new HtmlString(nl2br(e($limited)) . '...');
                //     }),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->sortable()
                    ->colors([
                        'success' => 'validated',
                        'warning' => 'pending',
                    ]),

                Tables\Columns\TextColumn::make('creator.name')
                    ->label('Pembuat')
                    ->icon('heroicon-m-user')
                    ->searchable(isIndividual: true)
                    ->toggleable()
                    ->toggledHiddenByDefault(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Dibuat pada')
                    ->dateTime()
                    ->toggleable()
                    ->icon('heroicon-m-calendar')
                    ->toggledHiddenByDefault(),
                Tables\Columns\TextColumn::make('validator.name')
                    ->label('Validator')
                    ->icon('heroicon-m-user')
                    ->searchable(isIndividual: true)
                    ->toggleable()
                    ->toggledHiddenByDefault(),

                Tables\Columns\TextColumn::make('validated_time')
                    ->label('Waktu Validasi')
                    ->dateTime()
                    ->icon('heroicon-m-calendar')

                    ->toggleable()
                    ->toggledHiddenByDefault(),
                Tables\Columns\TextColumn::make('updated_at')
                    ->label('Diperbarui pada')
                    ->dateTime()
                    ->toggleable()
                    ->icon('heroicon-m-calendar')
                    ->toggledHiddenByDefault(),

            ])
            ->defaultSort('created_at', 'desc')
            ->filters([
                SelectFilter::make('status')
                    ->label('Status')
                    ->options([
                        'validated' => 'Validated',
                        'pending' => 'Pending',
                    ]),
                SelectFilter::make('created_by')
                    ->label('Dibuat Oleh')
                    ->options(
                        fn() =>
                        \App\Models\User::all()->mapWithKeys(function ($user) {
                            return [$user->id => "{$user->nip} - {$user->name}"];
                        })
                    )
                    ->searchable(),
                DateRangeFilter::make('created_at')
                    ->label('Dibuat Pada'),
                SelectFilter::make('validated_by')
                    ->label('Nama Validator')
                    ->options(
                        fn() =>
                        \App\Models\User::all()->mapWithKeys(function ($user) {
                            return [$user->id => "{$user->nip} - {$user->name}"];
                        })
                    )
                    ->searchable(),
                DateRangeFilter::make('validated_time')
                    ->label('Divalidasi Pada'),
            ], layout: FiltersLayout::AboveContentCollapsible)
            ->actions([
                Tables\Actions\Action::make('toggleValidation')
                    ->visible(function (IsiStandar $record): bool {
                        return in_array($record->status, ['pending', 'validated']) &&
                            (
                                $record->validated_by === Auth::id() ||
                                Auth::user()?->hasRole('super_admin')
                            );
                    })
                    ->icon(
                        fn(IsiStandar $record) => $record->status === 'pending'
                            ? 'heroicon-m-check-circle'
                            : 'heroicon-m-arrow-uturn-left'
                    )
                    ->label(function (IsiStandar $record) {
                        return $record->status === 'pending' ? 'Validate?' : 'Mark as Pending?';
                    })
                    ->form([
                        Forms\Components\DateTimePicker::make('validated_time')
                            ->default(now())
                            ->required()
                            ->visible(fn(IsiStandar $record) => $record->status === 'pending'),
                    ])
                    ->color(fn(IsiStandar $record) => $record->status === 'pending' ? 'success' : 'warning')
                    ->requiresConfirmation()
                    ->modalHeading(
                        fn(IsiStandar $record) =>
                        $record->status === 'pending' ? 'Are you sure you want to validate this?' : 'Are you sure you want to mark it back as Pending?'
                    )
                    ->modalDescription(
                        fn(IsiStandar $record) =>
                        $record->status === 'pending'
                            ? 'Once validated, this point will be marked as verified.'
                            : 'The validated point will be returned to Pending status.'
                    )
                    ->action(function (IsiStandar $record, array $data) {
                        if ($record->status === 'pending') {
                            $record->update([
                                'validated_time' => $data['validated_time'],
                                'status' => 'validated',
                            ]);
                        } else {
                            $record->update([
                                'status' => 'pending',
                                'validated_time' => null,
                            ]);
                        }
                    }),
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
                Action::make('export')
                    ->label('Export')
                    ->icon('heroicon-o-arrow-down-tray')
                    ->action(function ($record) {
                        return Excel::download(
                            new IsiStandarExport(collect([$record])),
                            'isi-standar-' . $record->id . '.xlsx'
                        );
                    })
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ])
            ->headerActions([
                Action::make('exportAll')
                    ->label('Export All')
                    ->icon('heroicon-o-arrow-down-tray')
                    ->action(function () {
                        $records = \App\Models\IsiStandar::all();
                        return Excel::download(new \App\Exports\IsiStandarExport($records), 'isi-standar.xlsx');
                    })
                    ->color('success')
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListIsiStandars::route('/'),
            'create' => Pages\CreateIsiStandar::route('/create'),
            'view' => Pages\ViewIsiStandar::route('/{record}'),
            'edit' => Pages\EditIsiStandar::route('/{record}/edit'),
        ];
    }
}
