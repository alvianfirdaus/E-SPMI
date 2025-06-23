<?php

namespace App\Filament\Resources;

use App\Models\User;
use Filament\Tables;
use App\Models\Standar;
use Filament\Forms\Form;
use App\Models\Indikator;
use App\Models\SubStandar;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use Spatie\Permission\Models\Role;
use Filament\Forms\Components\Grid;
use Filament\Tables\Actions\Action;
use Illuminate\Support\Facades\Auth;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\Textarea;
use Filament\Tables\Columns\TextColumn;
use App\Models\AssignPengisian;
use Filament\Forms\Components\TextInput;
use Filament\Tables\Enums\FiltersLayout;
use Filament\Forms\Components\RichEditor;
use Filament\Tables\Filters\SelectFilter;
use Filament\Forms\Components\DateTimePicker;
use AmidEsfahani\FilamentTinyEditor\TinyEditor;
use App\Filament\Resources\IndikatorResource\Pages;
use Malzariey\FilamentDaterangepickerFilter\Filters\DateRangeFilter;

class IndikatorResource extends Resource
{
    protected static ?string $model = Indikator::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Manajemen Indikator';
    protected static ?string $navigationLabel = 'Indikator';
    protected static ?int $navigationSort = 1;
    public static function form(Form $form): Form
    {
        return $form->schema([
            Section::make('Standar')
                ->schema([
                    Select::make('tahun')
                        ->label('Pilih Tahun')
                        ->options(
                            Standar::where('status', 'validated')
                                ->whereNotNull('tahun')
                                ->select('tahun')
                                ->orderBy('tahun', 'desc')
                                ->pluck('tahun', 'tahun')
                                ->unique()
                                ->toArray()
                        )
                        ->searchable()
                        ->preload()
                        ->required()
                        ->reactive()
                        ->afterStateUpdated(function ($state, callable $set) {
                            $set('standar_id', null);
                            $set('sub_standar_id', null);
                        }),

                    // Standar filtered by tahun
                    Select::make('standar_id')
                        ->label('Pilih Standar')
                        ->options(function (callable $get) {
                            $tahun = $get('tahun');
                            if (!$tahun) return [];

                            return Standar::where('status', 'validated')
                                ->where('tahun', $tahun)
                                ->pluck('nama_standar', 'id');
                        })
                        ->searchable()
                        ->preload()
                        ->required()
                        ->reactive()
                        ->afterStateUpdated(fn($state, callable $set) => $set('sub_standar_id', null))
                        ->afterStateHydrated(function (callable $set, $state, $record) {
                            if ($record && $record->sub_standar_id) {
                                $subStandar = SubStandar::find($record->sub_standar_id);
                                if ($subStandar && $subStandar->standar) {
                                    $set('standar_id', $subStandar->standar_id);
                                    $set('tahun', $subStandar->standar->tahun);
                                }
                            }
                        }),


                    Select::make('sub_standar_id')
                        ->label('Pilih Sub Standar')
                        ->options(
                            fn($get) =>
                            SubStandar::where('standar_id', $get('standar_id'))
                                ->where('status', 'validated')
                                ->pluck('nama_sub_standar', 'id')
                        )
                        ->searchable()
                        ->preload()
                        ->required()
                        ->reactive(),
                    Repeater::make('isi_indikators')
                        ->label('Isi Indikator')
                        ->schema([
                            RichEditor::make('isi_indikator')
                                ->label('Isi Indikator')
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
                            TextInput::make('target'),
                        ])
                        ->minItems(1)
                        ->addable()
                        ->reorderable()
                        ->collapsible()
                        ->required(),
                ]),

            Section::make('Validator')
                ->description('Pilih role validator lalu user yang akan melakukan validasi.')
                ->schema([
                    Select::make('role')
                        ->label('Role Validator')
                        ->options(\Spatie\Permission\Models\Role::pluck('name', 'name'))
                        ->reactive()
                        ->required(),

                    Select::make('validated_by')
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
                'subStandar.standar.tahun',
                'subStandar.standar.nama_standar',
                'status',
            ])
            ->groupingSettingsInDropdownOnDesktop()
            ->deferLoading()
            ->columns([
                TextColumn::make('subStandar.standar.nama_standar')
                    ->label('Standar')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('subStandar.nama_sub_standar')
                    ->label('Sub Standar')
                    ->sortable()
                    ->searchable(),
                Tables\Columns\TextColumn::make('subStandar.standar.tahun')
                    ->label('Tahun')
                    ->searchable(isIndividual: true)
                    ->sortable(),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->sortable()
                    ->colors([
                        'success' => 'validated',
                        'warning' => 'pending',
                    ]),

                Tables\Columns\TextColumn::make('creator.name')
                    ->label('Creator')
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
                    ->label('Created Date'),
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
                    ->label('Validated Date'),
            ], layout: FiltersLayout::AboveContentCollapsible)
            ->actions([
                Tables\Actions\Action::make('toggleValidation')
                    ->visible(function (Indikator $record): bool {
                        return in_array($record->status, ['pending', 'validated']) &&
                            (
                                $record->validated_by === Auth::id() ||
                                Auth::user()?->hasRole('super_admin')
                            );
                    })
                    ->icon(
                        fn(Indikator $record) => $record->status === 'pending'
                            ? 'heroicon-m-check-circle'
                            : 'heroicon-m-arrow-uturn-left'
                    )
                    ->label(function (Indikator $record) {
                        return $record->status === 'pending' ? 'Validate?' : 'Mark as Pending?';
                    })
                    ->form([
                        DateTimePicker::make('validated_time')
                            ->default(now())
                            ->required()
                            ->visible(fn(Indikator $record) => $record->status === 'pending'),
                    ])
                    ->color(fn(Indikator $record) => $record->status === 'pending' ? 'success' : 'warning')
                    ->requiresConfirmation()
                    ->modalHeading(
                        fn(Indikator $record) =>
                        $record->status === 'pending' ? 'Are you sure you want to validate this?' : 'Are you sure you want to mark it back as Pending?'
                    )
                    ->modalDescription(
                        fn(Indikator $record) =>
                        $record->status === 'pending'
                            ? 'Once validated, this point will be marked as verified.'
                            : 'The validated point will be returned to Pending status.'
                    )
                    ->action(function (Indikator $record, array $data) {
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
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
        //;
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
            'index'  => Pages\ListIndikators::route('/'),
            'create' => Pages\CreateIndikator::route('/create'),
            'view'   => Pages\ViewIndikator::route('/{record}'),
            'edit'   => Pages\EditIndikator::route('/{record}/edit'),
        ];
    }
}
