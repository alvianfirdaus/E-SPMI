<?php

namespace App\Filament\Resources;

use Filament\Forms;
use App\Models\Unit;
use App\Models\User;
use Filament\Tables;
use App\Models\Standar;
use Filament\Forms\Form;
use App\Models\Indikator;
use Filament\Tables\Table;
use App\Models\IsiIndikator;
use App\Models\UnitIndikator;
use Filament\Resources\Resource;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Blade;
use Filament\Tables\Columns\TextColumn;
use App\Filament\Resources\UnitIndikatorResource\Pages;

class UnitIndikatorResource extends Resource
{
    protected static ?string $model = UnitIndikator::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Manajemen Indikator';
    protected static ?string $navigationLabel = 'Unit Indikator';
    protected static ?int $navigationSort = 2;
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Hidden::make('isi_indikator_inputs')
                    ->default([])
                    ->afterStateHydrated(function ($state, $set) {
                        // This ensures the state is properly initialized as an array
                        if ($state === null) {
                            $set('isi_indikator_inputs', []);
                        }
                    }),
                Forms\Components\Section::make('Informasi Umum')
                    ->schema([
                        Forms\Components\Select::make('unit_id')
                            ->label('Pilih Unit')
                            ->options(function (callable $get) {
                                return Unit::where('status', 'validated')
                                    ->whereNotNull('nama_unit')
                                    ->pluck('nama_unit', 'id')
                                    ->toArray();
                            })
                            ->searchable()
                            ->preload()
                            ->required(),
                        Forms\Components\Select::make('periode_id')
                            ->relationship('periode', 'periode_name')
                            ->required(),
                    ])->collapsible(),

                Forms\Components\Section::make('Standar dan Indikator')
                    ->schema(
                        [
                            Forms\Components\Repeater::make('indikator_set')
                                ->label('Pilih Standar dan Indikator')
                                ->itemLabel(function (array $state) use (&$itemCount) {
                                    static $count = 1;
                                    $standarId = $state['standar_id'] ?? null;
                                    if (!$standarId) {
                                        return 'Standar ' . $count++;
                                    }
                                    $standar = Standar::find($standarId);
                                    return 'Standar ' . $count++ . ' - ' . ($standar ? $standar->nama_standar : 'Standar Tidak Diketahui');
                                })
                                ->schema([

                                    Forms\Components\Select::make('tahun')
                                        ->label('Tahun')
                                        ->options(
                                            fn() => Standar::where('status', 'validated')
                                                ->whereNotNull('tahun')
                                                ->orderBy('tahun', 'desc')
                                                ->pluck('tahun', 'tahun')
                                                ->unique()
                                                ->toArray()
                                        )
                                        ->reactive()
                                        ->afterStateUpdated(fn($state, callable $set) => $set('standar_id', null))
                                        ->required(),

                                    Forms\Components\Select::make('standar_id')
                                        ->label('Standar')
                                        ->options(function (callable $get) {
                                            $tahun = $get('tahun');
                                            if (!$tahun) return [];

                                            return Standar::where('status', 'validated')
                                                ->where('tahun', $tahun)
                                                ->pluck('nama_standar', 'id');
                                        })
                                        ->searchable()
                                        ->reactive()
                                        ->afterStateUpdated(fn($state, callable $set) => $set('indikator', []))
                                        ->required()
                                        ->columnSpan(2)
                                        ->helperText(function (Forms\Get $get) {
                                            $standarId = $get('standar_id');
                                            return $standarId
                                                ? 'Standar terpilih. Klik tombol di bawah untuk melihat detail.'
                                                : 'Pilih standar terlebih dahulu';
                                        })
                                        ->suffixActions([
                                            Forms\Components\Actions\Action::make('lihat_detail')
                                                ->icon('heroicon-m-eye')
                                                ->label('Lihat Detail')
                                                ->modalHeading('Detail Standar')
                                                ->modalWidth('4xl')
                                                ->modalContent(function (Forms\Get $get) {
                                                    $standarId = $get('standar_id');
                                                    $standar = \App\Models\Standar::with('subStandars')->find($standarId);
                                                    return view('livewire.components.detail-standar', [
                                                        'standar' => $standar,
                                                    ]);
                                                })
                                                ->modalSubmitAction(false)
                                                ->modalCancelActionLabel('Tutup')
                                                ->visible(fn(Forms\Get $get) => filled($get('standar_id'))),
                                        ]),
                                    Forms\Components\Repeater::make('indikator')
                                        ->label('Indikator')
                                        ->itemLabel(function (array $state) use (&$itemCount) {
                                            static $count = 1;
                                            $standarId = $state['indikator_id'] ?? null;
                                            if (!$standarId) {
                                                return 'Indikator ' . $count++;
                                            }
                                            $standar = \App\Models\Indikator::with(['subStandar.standar', 'isiIndikators'])->find($standarId);
                                            return 'Indikator ' . $count++ . ' - ' .
                                                ($standar ? $standar->subStandar->nama_sub_standar : 'Standar Tidak Diketahui');
                                        })
                                        ->schema([
                                            Forms\Components\Select::make('indikator_id')
                                                ->label('Indikator')
                                                ->options(function (callable $get) {
                                                    $standarId = $get('../../standar_id');
                                                    if (!$standarId) return [];

                                                    $indikators = Indikator::whereHas('subStandar', function ($query) use ($standarId) {
                                                        $query->where('standar_id', $standarId);
                                                    })
                                                        ->where('status', 'validated')
                                                        ->with('subStandar')
                                                        ->get();

                                                    return $indikators->mapWithKeys(function ($indikator) {
                                                        return [
                                                            $indikator->id => ($indikator->subStandar->nama_sub_standar ?? 'Sub Standar Tidak Diketahui') .
                                                                ' - Indikator'
                                                        ];
                                                    });
                                                })
                                                ->required()
                                                ->columnSpan(2)
                                                ->reactive()
                                                ->afterStateUpdated(function ($state, callable $set, callable $get) {
                                                    $isiIndikators = IsiIndikator::where('indikator_id', $state)->get();
                                                    $isiInputs = [];

                                                    foreach ($isiIndikators as $isi) {
                                                        $isiInputs[] = [
                                                            'id' => $isi->id,
                                                            'pertanyaan_field' => '',
                                                            'target_field' => '',
                                                            'bukti_field' => '',
                                                        ];
                                                    }

                                                    $set('isi_indikator_inputs', $isiInputs);
                                                })->helperText(function (Forms\Get $get) {
                                                    $indikatorId = $get('indikator_id');
                                                    return $indikatorId
                                                        ? 'Indikator terpilih. Klik tombol di bawah untuk melihat detail.'
                                                        : 'Pilih indikator terlebih dahulu';
                                                })
                                                ->suffixActions([
                                                    Forms\Components\Actions\Action::make('lihat_detail')
                                                        ->icon('heroicon-m-eye')
                                                        ->label('Lihat Detail')
                                                        ->modalHeading('Detail Indikator')
                                                        ->modalWidth('4xl')
                                                        ->modalContent(function (Forms\Get $get) {
                                                            $indikatorId = $get('indikator_id');
                                                            $indikator = \App\Models\Indikator::with(['subStandar.standar', 'isiIndikators'])->find($indikatorId);
                                                            return view('livewire.components.dtail-sub-standar', [
                                                                'indikator' => $indikator,
                                                            ]);
                                                        })
                                                        ->modalSubmitAction(false)
                                                        ->modalCancelActionLabel('Tutup')
                                                        ->visible(fn(Forms\Get $get) => filled($get('indikator_id'))),
                                                ]),

                                            Forms\Components\Section::make('Detail Isi Indikator')
                                                ->schema(function (Forms\Get $get) {
                                                    $indikatorId = $get('indikator_id');
                                                    if (!$indikatorId) return [];

                                                    $isiIndikators = \App\Models\IsiIndikator::where('indikator_id', $indikatorId)->get();
                                                    return $isiIndikators->map(function ($isi, $index) {
                                                        $content = $isi->isi_indikator ?? '-';
                                                        $content = str_replace('<ul>', '<ul style="list-style-type: disc; padding-left: 1rem;">', $content);
                                                        $content = str_replace('<ol>', '<ol style="list-style-type: decimal; padding-left: 1rem;">', $content);
                                                        $content = str_replace('<li>', '<li style="margin-bottom: 4px;">', $content);

                                                        return Forms\Components\Section::make(($index + 1) . '. ' . strip_tags($isi->isi_indikator))
                                                            ->schema([
                                                                // Show isi_indikator content in placeholder
                                                                Forms\Components\Placeholder::make('isi_indikator_' . ($index + 1))
                                                                    ->content(new \Illuminate\Support\HtmlString(
                                                                        $isi->isi_indikator ?? ''
                                                                    )),

                                                                Forms\Components\Section::make()
                                                                    ->schema([
                                                                        Forms\Components\Textarea::make("pertanyaan_{$isi->id}")
                                                                            ->label('Pertanyaan')
                                                                            ->rows(3)
                                                                            ->dehydrated(),


                                                                        Forms\Components\Grid::make(2)
                                                                            ->schema([
                                                                                Forms\Components\TextInput::make("target_{$isi->id}")
                                                                                    ->label('Target')
                                                                                    ->dehydrated(),

                                                                                Forms\Components\TextInput::make("bukti_{$isi->id}")
                                                                                    ->label('Bukti')
                                                                                    ->dehydrated()
                                                                                    ->reactive()
                                                                                    ->hint(function (Forms\Get $get) use ($isi) {
                                                                                        $bukti = $get("bukti_{$isi->id}");

                                                                                        if (blank($bukti)) {
                                                                                            return null;
                                                                                        }

                                                                                        return new \Illuminate\Support\HtmlString(
                                                                                            Blade::render(
                                                                                                '<x-filament::link href="' . e($bukti) . '" target="_blank">Lihat Bukti</x-filament::link>'
                                                                                            )
                                                                                        );
                                                                                    }),

                                                                            ]),
                                                                    ])
                                                                    ->columns(1)
                                                                    ->columnSpan('full')
                                                                    ->compact(),
                                                            ])
                                                            ->collapsible()
                                                            ->collapsed(false)
                                                            ->columns(1);
                                                    })->toArray();
                                                })
                                                ->visible(fn(Forms\Get $get) => filled($get('indikator_id')))
                                                ->columnSpan('full')
                                        ])
                                        ->minItems(1)
                                        ->collapsible()
                                        ->addActionLabel('Tambah Sub Standar'),
                                ])
                                ->minItems(1)
                                ->addActionLabel('Tambah Baris Standar')
                                ->collapsible()
                                ->required(),
                        ]
                    )->collapsible(),

                Forms\Components\Section::make('Auditee')
                    ->schema([
                        Forms\Components\Select::make('auditee_role')
                            ->label('Role Auditee')
                            ->options(\Spatie\Permission\Models\Role::pluck('name', 'name'))
                            ->reactive()
                            ->required(),
                        Forms\Components\Select::make('auditee_unit_id')
                            ->label('Unit Auditee (Opsional)')
                            ->options(\App\Models\Unit::pluck('nama_unit', 'id'))
                            ->searchable()
                            ->reactive()
                            // ->default(function (callable $get) {
                            //     $unitIndikatorId = $get('unit_indikator_id');
                            //     if ($unitIndikatorId) {
                            //         $unitIndikator = \App\Models\UnitIndikator::find($unitIndikatorId);
                            //         return $unitIndikator ? $unitIndikator->unit_id : null;
                            //     }
                            //     return null;
                            // })
                            ->visible(fn(callable $get) => filled($get('auditee_role'))),

                        Forms\Components\Select::make('auditee')
                            ->label('Auditee')
                            ->options(function (callable $get) {
                                $role = $get('auditee_role');
                                $unitId = $get('auditee_unit_id');

                                if (! $role) return [];

                                $query = \App\Models\User::role($role);

                                if ($unitId) {
                                    $query->where('unit_id', $unitId);
                                }

                                return $query->get()
                                    ->mapWithKeys(fn($user) => [
                                        $user->id => "{$user->nip} - {$user->name}",
                                    ])
                                    ->toArray();
                            })
                            ->searchable()
                            ->required()
                            ->visible(fn(callable $get) => filled($get('auditee_role'))),
                    ]),

                Forms\Components\Section::make('Validator')
                    ->schema([
                        Forms\Components\Select::make('validator_1_id')
                            ->label('Validator 1')
                            ->options(User::pluck('name', 'id'))
                            ->searchable()
                            ->required(),
                    ]),
            ]);
    }


    public static function table(Table $table): Table
    {
        return $table
            ->query(UnitIndikator::with([
                'unit',
                'unitIndikatorStandars.standar',
            ]))
            ->columns([
                TextColumn::make('unit.nama_unit')
                    ->label('Unit')
                    ->sortable()
                    ->searchable(),
                TextColumn::make('unitIndikatorStandars.standar.nama_standar')
                    ->label('Standar')
                    ->sortable()
                    ->searchable(),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\Action::make('lihat_validasi')
                    ->label('Lihat Hasil Validasi')
                    ->icon('heroicon-m-eye')
                    ->url(fn($record): string => tap(UnitIndikatorResource::getUrl('lihat-validasi', ['record' => $record]), function ($url) {}))
                    ->color('info'),
                Tables\Actions\ActionGroup::make([
                    Tables\Actions\DeleteAction::make(),
                    Tables\Actions\Action::make('validasi')
                        ->label('Validasi')
                        ->icon('heroicon-m-check-badge')
                        ->url(fn($record): string => tap(UnitIndikatorResource::getUrl('validasi', ['record' => $record]), function ($url) {}))
                        ->color('success')
                        ->visible(function ($record) {
                            $user = Auth::user();
                            $isValidator1 = $user->id === $record->validator_1_id;
                            $isSuperAdmin = $user->hasRole('super_admin');
                            return $isValidator1 || $isSuperAdmin;
                        }),
                ])
                    ->label('More')
                    ->icon('heroicon-m-ellipsis-vertical')
                    ->color('gray')
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
            'index'  => Pages\ListUnitIndikators::route('/'),
            'create' => Pages\CreateUnitIndikator::route('/create'),
            'view'   => Pages\ViewUnitIndikator::route('/{record}'),
            'edit'   => Pages\EditUnitIndikator::route('/{record}/edit'),
            'validasi' => Pages\ValidasiUnitIndikator::route('/{record}/validasi'),
            'lihat-validasi' => Pages\ViewValidasiUnitIndikator::route('/{record}/lihat-validasi'),
        ];
    }
}
