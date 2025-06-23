<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\UnitIndikator;
use Filament\Resources\Resource;
use Illuminate\Support\Facades\Auth;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Toggle;
use App\Models\AssignPengisian;
use Illuminate\Database\Eloquent\Builder;
use Filament\Forms\Components\DateTimePicker;
use App\Filament\Resources\AssignPengisianResource\Pages;

class AssignPengisianResource extends Resource
{
    protected static ?string $model = AssignPengisian::class;
    protected static ?string $title = 'Create New User';
    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Audit';
    protected static ?string $navigationLabel = 'Pendaftaran Audit';
    public static ?string $label = 'Pendaftaran Audit';
    public static ?string $pluralLabel = 'Pendaftaran Audit';
    protected static ?string $slug = 'pendaftaran-audit';
    protected static ?string $breadcrumb = 'Pendaftaran Audit';

    protected static ?int $navigationSort = 1;
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Umum')
                    ->schema([
                        Select::make('unit_indikator_id')
                            ->label('Unit Indikator')
                            ->options(function () {
                                return UnitIndikator::with(['unit', 'unitIndikatorStandars.standar'])
                                    ->where('status', 'validated')
                                    ->get()
                                    ->mapWithKeys(function ($item) {
                                        $namaUnit = $item->unit->nama_unit ?? '-';

                                        $namaStandar = $item->unitIndikatorStandars
                                            ->map(fn($uis) => $uis->standar?->nama_standar)
                                            ->filter()
                                            ->unique()
                                            ->implode(', ');

                                        return [
                                            $item->id => "{$namaUnit} - {$namaStandar}",
                                        ];
                                    })
                                    ->toArray();
                            })
                            ->searchable()
                            ->required(),

                        Select::make('periode_id')
                            ->label('Periode')
                            ->options(\App\Models\Periode::where('status', 'validated')->pluck('periode_name', 'id'))
                            ->searchable()
                            ->reactive()
                            ->required(),

                        Toggle::make('is_active')
                            ->label('Aktif')
                            ->default(true),
                    ]),

                Forms\Components\Section::make('Pengisian Audit')
                    ->schema([
                        Forms\Components\DateTimePicker::make('start_date')
                            ->label('Tanggal Mulai')
                            ->required()
                            ->native(false),

                        Forms\Components\DateTimePicker::make('end_date')
                            ->label('Tanggal Selesai')
                            ->required()
                            ->native(false),
                    ]),

                Forms\Components\Section::make('Auditor')
                    ->schema([
                        Forms\Components\Fieldset::make('Auditor 1')
                            ->schema([
                                Forms\Components\Select::make('auditor1_role')
                                    ->label('Role Auditor 1')
                                    ->options(\Spatie\Permission\Models\Role::pluck('name', 'name'))
                                    ->reactive()
                                    ->required(),

                                Forms\Components\Select::make('auditor1_unit_id')
                                    ->label('Unit Auditor 1 (Opsional)')
                                    ->options(\App\Models\Unit::pluck('nama_unit', 'id'))
                                    ->searchable()
                                    ->reactive()
                                    ->visible(fn(callable $get) => filled($get('auditor1_role'))),

                                Forms\Components\Select::make('auditor1_id')
                                    ->label('Pilih Auditor 1')
                                    ->options(function (callable $get) {
                                        $role = $get('auditor1_role');
                                        $unitId = $get('auditor1_unit_id');
                                        $periodeId = $get('periode_id');

                                        if (!$role) return [];

                                        $query = \App\Models\User::role($role);
                                        if ($unitId) {
                                            $query->where('unit_id', $unitId);
                                        }

                                        $users = $query->get();
                                        $groupedOptions = [];

                                        foreach ($users as $user) {
                                            $assignmentCount = 0;
                                            if ($periodeId) {
                                                $assignments  = \App\Models\AuditorAssignment::join('assign_pengisians', 'auditor_assignments.assign_pengisian_id', '=', 'assign_pengisians.id')
                                                    ->where('assign_pengisians.periode_id', $periodeId)
                                                    ->where(function ($query) use ($user) {
                                                        $query->where('auditor_assignments.auditor1', $user->id)
                                                            ->orWhere('auditor_assignments.auditor2', $user->id);
                                                    })
                                                    ->get(['auditor_assignments.auditor1', 'auditor_assignments.auditor2']);

                                                foreach ($assignments as $assignment) {
                                                    if ($assignment->auditor1 == $user->id) {
                                                        $assignmentCount++;
                                                    }
                                                    if ($assignment->auditor2 == $user->id) {
                                                        $assignmentCount++;
                                                    }
                                                }
                                            }

                                            if ($assignmentCount == 0) {
                                                $group = 'Belum Pernah (0x)';
                                            } elseif ($assignmentCount == 1) {
                                                $group = 'Sudah 1 Kali';
                                            } elseif ($assignmentCount == 2) {
                                                $group = 'Sudah 2 Kali';
                                            } elseif ($assignmentCount == 3) {
                                                $group = 'Sudah 3 Kali';
                                            } elseif ($assignmentCount <= 5) {
                                                $group = 'Sudah 4-5 kali';
                                            } else {
                                                $group = 'Lebih dari 5 kali';
                                            }

                                            $label = "{$user->nip} - {$user->name}";
                                            if ($assignmentCount > 0) {
                                                $label .= " ({$assignmentCount}x)";
                                            }

                                            if (!isset($groupedOptions[$group])) {
                                                $groupedOptions[$group] = [];
                                            }
                                            $groupedOptions[$group][$user->id] = $label;
                                        }

                                        $orderedGroups = [];
                                        $groupOrder = [
                                            'Belum Pernah (0x)',
                                            'Sudah 1 Kali',
                                            'Sudah 2 Kali',
                                            'Sudah 3 Kali',
                                            'Sudah 4-5 kali',
                                            'Lebih dari 6 kali'
                                        ];

                                        foreach ($groupOrder as $groupName) {
                                            if (isset($groupedOptions[$groupName])) {
                                                $orderedGroups[$groupName] = $groupedOptions[$groupName];
                                            }
                                        }

                                        return $orderedGroups;
                                    })
                                    ->searchable()
                                    ->required()
                                    ->visible(fn(callable $get) => filled($get('auditor1_role'))),
                            ]),
                        Forms\Components\Fieldset::make('Auditor 2')
                            ->schema([
                                Forms\Components\Select::make('auditor2_role')
                                    ->label('Role Auditor 2')
                                    ->options(\Spatie\Permission\Models\Role::pluck('name', 'name'))
                                    ->reactive()
                                    ->required(),

                                Forms\Components\Select::make('auditor2_unit_id')
                                    ->label('Unit Auditor 2 (Opsional)')
                                    ->options(\App\Models\Unit::pluck('nama_unit', 'id'))
                                    ->searchable()
                                    ->reactive()
                                    ->visible(fn(callable $get) => filled($get('auditor2_role'))),

                                Forms\Components\Select::make('auditor2_id')
                                    ->label('Pilih Auditor 2')
                                    ->options(function (callable $get) {
                                        $role = $get('auditor2_role');
                                        $unitId = $get('auditor2_unit_id');
                                        $periodeId = $get('periode_id');

                                        if (!$role) return [];

                                        $query = \App\Models\User::role($role);
                                        if ($unitId) {
                                            $query->where('unit_id', $unitId);
                                        }

                                        $users = $query->get();
                                        $groupedOptions = [];

                                        foreach ($users as $user) {
                                            $assignmentCount = 0;
                                            if ($periodeId) {
                                                $assignments = \App\Models\AuditorAssignment::join('assign_pengisians', 'auditor_assignments.assign_pengisian_id', '=', 'assign_pengisians.id')
                                                    ->where('assign_pengisians.periode_id', $periodeId)
                                                    ->where(function ($query) use ($user) {
                                                        $query->where('auditor_assignments.auditor1', $user->id)
                                                            ->orWhere('auditor_assignments.auditor2', $user->id);
                                                    })
                                                    ->get(['auditor_assignments.auditor1', 'auditor_assignments.auditor2']);

                                                foreach ($assignments as $assignment) {
                                                    if ($assignment->auditor1 == $user->id) {
                                                        $assignmentCount++;
                                                    }
                                                    if ($assignment->auditor2 == $user->id) {
                                                        $assignmentCount++;
                                                    }
                                                }
                                            }

                                            if ($assignmentCount == 0) {
                                                $group = 'Belum Pernah (0x)';
                                            } elseif ($assignmentCount == 1) {
                                                $group = 'Sudah 1 Kali';
                                            } elseif ($assignmentCount == 2) {
                                                $group = 'Sudah 2 Kali';
                                            } elseif ($assignmentCount == 3) {
                                                $group = 'Sudah 3 Kali';
                                            } elseif ($assignmentCount <= 5) {
                                                $group = 'Sudah 4-5 kali';
                                            } else {
                                                $group = 'Lebih dari 5 kali';
                                            }

                                            $label = "{$user->nip} - {$user->name}";
                                            if ($assignmentCount > 0) {
                                                $label .= " ({$assignmentCount}x)";
                                            }

                                            if (!isset($groupedOptions[$group])) {
                                                $groupedOptions[$group] = [];
                                            }
                                            $groupedOptions[$group][$user->id] = $label;
                                        }

                                        $orderedGroups = [];
                                        $groupOrder = [
                                            'Belum Pernah (0x)',
                                            'Sudah 1 Kali',
                                            'Sudah 2 Kali',
                                            'Sudah 3 Kali',
                                            'Sudah 4-5 kali',
                                            'Lebih dari 6 kali'
                                        ];

                                        foreach ($groupOrder as $groupName) {
                                            if (isset($groupedOptions[$groupName])) {
                                                $orderedGroups[$groupName] = $groupedOptions[$groupName];
                                            }
                                        }

                                        return $orderedGroups;
                                    })
                                    ->searchable()
                                    ->required()
                                    ->visible(fn(callable $get) => filled($get('auditor2_role'))),
                            ]),
                    ]),

                Forms\Components\Section::make('Validator')
                    ->description('Pilih role validator lalu user yang akan melakukan validasi.')
                    ->schema([
                        Forms\Components\Select::make('role')
                            ->label('Role Validator')
                            ->options(\Spatie\Permission\Models\Role::pluck('name', 'name'))
                            ->dehydrated()
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
            ->modifyQueryUsing(function (Builder $query) {
                if (request()->missing('tableFilters') || empty(request()->input('tableFilters.periode_id'))) {
                    if ($periode = session('selected_periode_id')) {
                        $query->where('periode_id', $periode);
                    }
                }
                return $query;
            })
            ->columns([
                Tables\Columns\TextColumn::make('unitIndikator.unit.nama_unit')->label('Unit Indikator'),
                Tables\Columns\TextColumn::make('periode.periode_name')->label('Periode'),
                Tables\Columns\TextColumn::make('unitIndikator.auditeeUser.name')->label('Auditee'),

                Tables\Columns\TextColumn::make('assignAuditors.auditor1Relation.name')->label('Auditor 1'),
                Tables\Columns\TextColumn::make('assignAuditors.auditor2Relation.name')->label('Auditor 2'),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'in_progress' => 'gray',
                        'done' => 'green',
                        default => 'secondary',
                    }),
                Tables\Columns\IconColumn::make('is_active')->boolean()->label('Aktif'),
                Tables\Columns\TextColumn::make('created_at')->dateTime('d M Y H:i'),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('periode_id')
                    ->label('Periode')
                    ->options(
                        \App\Models\Periode::orderBy('created_at', 'desc')
                            ->pluck('periode_name', 'id')
                    ),
            ])
            ->actions([
                Tables\Actions\Action::make('toggleValidation')
                    ->visible(function (AssignPengisian $record): bool {
                        return in_array($record->status, ['pending', 'validated']) &&
                            (
                                $record->validated_by === Auth::id() ||
                                Auth::user()?->hasRole('super_admin')
                            );
                    })
                    ->icon(
                        fn(AssignPengisian $record) => $record->status === 'pending'
                            ? 'heroicon-m-check-circle'
                            : 'heroicon-m-arrow-uturn-left'
                    )
                    ->label(function (AssignPengisian $record) {
                        return $record->status === 'pending' ? 'Validate?' : 'Mark as Pending?';
                    })
                    ->form([
                        DateTimePicker::make('validated_time')
                            ->default(now())
                            ->required()
                            ->visible(fn(AssignPengisian $record) => $record->status === 'pending'),
                    ])
                    ->color(fn(AssignPengisian $record) => $record->status === 'pending' ? 'success' : 'warning')
                    ->requiresConfirmation()
                    ->modalHeading(
                        fn(AssignPengisian $record) =>
                        $record->status === 'pending' ? 'Are you sure you want to validate this?' : 'Are you sure you want to mark it back as Pending?'
                    )
                    ->modalDescription(
                        fn(AssignPengisian $record) =>
                        $record->status === 'pending'
                            ? 'Once validated, this point will be marked as verified.'
                            : 'The validated point will be returned to Pending status.'
                    )
                    ->action(function (AssignPengisian $record, array $data) {
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
            'index' => Pages\ListAssignPengisians::route('/'),
            'create' => Pages\CreateAssignPengisian::route('/create'),
            'view'   => Pages\ViewAssignPengisian::route('/{record}'),
            'edit' => Pages\EditAssignPengisian::route('/{record}/edit'),
        ];
    }
}
