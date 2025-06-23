<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use App\Models\Standar;
use Filament\Forms\Form;
use App\Models\SubStandar;
use Filament\Tables\Table;
use App\Models\IsiStandar;
use Filament\Resources\Resource;
use Illuminate\Support\Facades\Auth;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Repeater;
use Filament\Tables\Enums\FiltersLayout;
use Filament\Tables\Filters\SelectFilter;
use AmidEsfahani\FilamentTinyEditor\TinyEditor;
use App\Filament\Resources\SubStandarResource\Pages;
use Malzariey\FilamentDaterangepickerFilter\Filters\DateRangeFilter;

class SubStandarResource extends Resource
{
    protected static ?string $model = SubStandar::class;

    protected static ?string $navigationIcon  = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Manjemen Standar';
    protected static ?string $navigationLabel = 'Sub Standar';
    protected static ?int $navigationSort = 3;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Section::make('Standar')
                    ->schema([
                        Forms\Components\Select::make('tahun')
                            ->label('Tahun')
                            ->options(fn() => Standar::where('status', 'validated')
                                ->whereNotNull('tahun')
                                ->orderBy('tahun', 'desc')
                                ->pluck('tahun', 'tahun')
                                ->unique()
                                ->toArray())
                            ->default(fn($context) => $context === 'create'
                                ? Standar::where('status', 'validated')->orderByDesc('tahun')->first()?->tahun
                                : null)
                            ->reactive()
                            ->afterStateUpdated(fn(callable $set) => $set('standar_id', null))
                            ->required(),

                        Forms\Components\TextInput::make('nama_sub_standar')
                            ->required()
                            ->maxLength(255),

                        Forms\Components\Select::make('standar_id')
                            ->label('Pilih Standar')
                            ->options(function (callable $get) {
                                $tahunId = $get('tahun');

                                if (!$tahunId) return [];

                                return Standar::where('tahun', $tahunId)
                                    ->where('status', 'validated')
                                    ->whereNotNull('nama_standar')
                                    ->pluck('nama_standar', 'id')
                                    ->toArray();
                            })
                            ->searchable()
                            ->preload()
                            ->required(),
                    ])
                    ->collapsible(),

                Section::make('Isi Standar')
                    ->schema([
                        Repeater::make('isi_standar_id')
                            ->label('Daftar Isi Standar')
                            ->itemLabel(
                                fn(array $state) =>
                                optional(IsiStandar::find($state['isi_id'] ?? null))->nama_isi ?? 'Isi Standar'
                            )
                            ->schema([
                                Select::make('isi_id')
                                    ->label('Pilih Isi Standar')
                                    ->options(fn() => IsiStandar::where('status', 'validated')
                                        ->whereNotNull('nama_isi')
                                        ->get()
                                        ->mapWithKeys(function ($item) {
                                            return [
                                                $item->id => "{$item->nama_isi} (" . ($item->keterangan ?? 'Tanpa keterangan') . ")"
                                            ];
                                        })
                                        ->toArray())
                                    ->searchable()
                                    ->preload()
                                    ->required()
                                    ->reactive()
                                    ->afterStateUpdated(function ($state, callable $set) {
                                        $deskripsi = optional(IsiStandar::find($state))->deskripsi ?? 'Tidak ada deskripsi';
                                        $set('deskripsi', $deskripsi);
                                    })
                                    ->afterStateHydrated(function ($state, callable $set) {
                                        $deskripsi = optional(IsiStandar::find($state))->deskripsi ?? 'Tidak ada deskripsi';
                                        $set('deskripsi', $deskripsi);
                                    }),

                                TinyEditor::make('deskripsi')
                                    ->label('Deskripsi')
                                    ->disabled()
                                    ->columnSpanFull(),
                            ])
                            ->minItems(1)
                            ->reorderable()
                            ->collapsible()
                            ->columnSpanFull(),
                    ])
                    ->collapsible(),

                Forms\Components\Section::make('Validator')
                    ->description('Pilih role validator lalu user yang akan melakukan validasi.')
                    ->schema([
                        Forms\Components\Select::make('role')
                            ->label('Role Validator')
                            ->options(fn() => \Spatie\Permission\Models\Role::whereNotNull('name')
                                ->pluck('name', 'name')
                                ->toArray())
                            ->reactive()
                            ->required(),

                        Forms\Components\Select::make('validated_by')
                            ->label('User Validator')
                            ->options(function (callable $get) {
                                $role = $get('role');

                                if (!$role) return [];

                                return \App\Models\User::role($role)
                                    ->get()
                                    ->filter(fn($user) => $user->nip && $user->name)
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
                Tables\Grouping\Group::make('standar.tahun')
                    ->label('Tahun'),
                Tables\Grouping\Group::make('standar.nama_standar')
                    ->label('Nama Standar'),
                Tables\Grouping\Group::make('standar.kode_standar')
                    ->label('Kode Standar'),
            ])
            ->groupingSettingsInDropdownOnDesktop()
            ->deferLoading()
            ->columns([
                Tables\Columns\TextColumn::make('nama_sub_standar')
                    ->searchable(isIndividual: true)
                    ->sortable(),
                Tables\Columns\TextColumn::make('standar.nama_standar')
                    ->label('Standar')
                    ->searchable(isIndividual: true)
                    ->sortable(),
                Tables\Columns\TextColumn::make('standar.tahun')
                    ->label('Tahun')
                    ->searchable(isIndividual: true)
                    ->sortable(),
                Tables\Columns\TextColumn::make('isi_standar_id')
                    ->label('Isi Standar')
                    ->formatStateUsing(function ($state) {
                        if (empty($state)) {
                            return '-';
                        }
                        if (! str_starts_with($state, '[')) {
                            $state = '[' . $state . ']';
                        }
                        $decoded = json_decode($state, true);
                        if (json_last_error() !== JSON_ERROR_NONE || ! is_array($decoded)) {
                            return '-';
                        }
                        $isiIds = array_column($decoded, 'isi_id');
                        $namaIsiList = IsiStandar::whereIn('id', $isiIds)
                            ->where('status', 'validated')
                            ->pluck('nama_isi')
                            ->toArray();
                        return empty($namaIsiList) ? '-' : implode(', ', $namaIsiList);
                    })
                    ->wrap()
                    ->limit(200)
                    ->searchable(isIndividual: true),
                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->sortable()
                    ->color(fn(string $state): string => match ($state) {
                        'validated' => 'success',
                        'pending' => 'warning',
                        default => 'gray',
                    })
                    ->icon(fn(string $state): ?string => match ($state) {
                        'validated' => 'heroicon-m-check-circle',
                        'pending' => 'heroicon-m-clock',
                        default => null,
                    }),
                Tables\Columns\TextColumn::make('creator.name')
                    ->label('Creator')
                    ->icon('heroicon-m-user')
                    ->searchable(isIndividual: true)
                    ->formatStateUsing(fn($state) => $state ? $state : '-')
                    ->toggleable()
                    ->toggledHiddenByDefault(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Dibuat pada')
                    ->dateTime()
                    ->toggleable()
                    ->formatStateUsing(fn($state) => $state ? $state : '-')
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
                SelectFilter::make('tahun')
                    ->label('Periode')
                    ->relationship('standar', 'tahun')
                    ->searchable(),
                SelectFilter::make('standar_id')
                    ->label('Standar')
                    ->relationship('standar', 'nama_standar')
                    ->searchable(),
                SelectFilter::make('nama_sub_standar')
                    ->label('Nama Sub Standar')
                    ->options(
                        SubStandar::pluck('nama_sub_standar', 'nama_sub_standar')
                    )
                    ->searchable(),
                SelectFilter::make('isi_standar_id')
                    ->label('Isi Standar')
                    ->options(
                        \App\Models\IsiStandar::where('status', 'validated')->pluck('nama_isi', 'id')
                    )
                    ->searchable()
                    ->query(function ($query, $state) {
                        if (is_array($state) && isset($state['value'])) {
                            $query->whereRaw("JSON_CONTAINS(isi_standar_id, JSON_OBJECT('isi_id', ?))", [(string)$state['value']]);
                        } elseif (is_string($state)) {
                            $query->whereRaw("JSON_CONTAINS(isi_standar_id, JSON_OBJECT('isi_id', ?))", [(string)$state]);
                        }
                    }),
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
                    ->visible(function (SubStandar $record): bool {
                        return in_array($record->status, ['pending', 'validated']) &&
                            (
                                $record->validated_by === Auth::id() ||
                                Auth::user()?->hasRole('super_admin')
                            );
                    })
                    ->icon(
                        fn(SubStandar $record) => $record->status === 'pending'
                            ? 'heroicon-m-check-circle' // ✅ Validate
                            : 'heroicon-m-arrow-uturn-left' // 🔁 Revert to Pending
                    )->label(function (SubStandar $record) {
                        return $record->status === 'pending' ? 'Validate?' : 'Mark as Pending?';
                    })
                    ->form([
                        Forms\Components\DateTimePicker::make('validated_time')
                            ->default(now())
                            ->required()
                            ->visible(fn(SubStandar $record) => $record->status === 'pending'),
                    ])
                    ->color(fn(SubStandar $record) => $record->status === 'pending' ? 'success' : 'warning')
                    ->requiresConfirmation()
                    ->modalHeading(
                        fn(SubStandar $record) =>
                        $record->status === 'pending' ? 'Are you sure you want to validate this?' : 'Are you sure you want to mark it back as Pending?'
                    )
                    ->modalDescription(
                        fn(SubStandar $record) =>
                        $record->status === 'pending'
                            ? 'Once validated, this point will be marked as verified.'
                            : 'The validated point will be returned to Pending status.'
                    )
                    ->action(function (SubStandar $record, array $data) {
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
            'index'  => Pages\ListSubStandars::route('/'),
            'create' => Pages\CreateSubStandar::route('/create'),
            'view'   => Pages\ViewSubStandar::route('/{record}'),
            'edit'   => Pages\EditSubStandar::route('/{record}/edit'),
        ];
    }
}
