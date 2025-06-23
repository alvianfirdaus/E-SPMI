<?php

namespace App\Filament\Widgets;

use App\Models\Jadwal;
use App\Models\Periode;
use Filament\Tables;
use Filament\Tables\Table;
use Illuminate\Support\Facades\Auth;
use Filament\Widgets\TableWidget as BaseWidget;
use Illuminate\Database\Eloquent\Builder;

class JadwalTableWidget extends BaseWidget
{
    protected static ?string $heading = 'Jadwal List';
    protected int | string | array $columnSpan = 'full';
        protected static bool $isDiscovered = false;

    public ?int $periodeId = null;
    public ?string $viewType = 'all';
    public ?int $selectedUnit = null;

    protected $listeners = [
        'updateCalendarFilters' => 'handleFilterUpdate',
        'refresh-assign-table' => 'handlePeriodeChange'
    ];

    public function mount(): void
    {
        // Initialize with session values
        $this->periodeId = session('selected_periode_id') ?? 
            Periode::where('status_periode', 'active')->where('status', 'validated')->first()?->id;
        $this->viewType = $this->viewType ?? 'all';
        
        // Force initial update to get current page state
        $this->dispatch('requestCurrentFilters');
    }

    public function handleFilterUpdate($data): void
    {
        $this->periodeId = $data['periodeId'];
        $this->viewType = $data['viewType'];
        $this->selectedUnit = $data['selectedUnit'];
        
        // Update the heading to reflect current filters
        $this->updateHeading();
    }

    public function handlePeriodeChange(): void
    {
        $newPeriodeId = session('selected_periode_id');
        
        if ($this->periodeId !== $newPeriodeId) {
            $this->periodeId = $newPeriodeId;
            $this->updateHeading();
        }
    }

    protected function updateHeading(): void
    {
        $periode = $this->periodeId ? Periode::find($this->periodeId) : null;
        $periodeName = $periode?->periode_name ?? 'All Periods';
        
        $viewLabel = match($this->viewType) {
            'my_schedule' => 'My Schedule',
            'specific_unit' => 'Unit Schedule',
            'all' => 'All Schedules',
            default => 'Schedules'
        };
        
        static::$heading = "Jadwal List - {$periodeName} ({$viewLabel})";
    }

    public function table(Table $table): Table
    {
        return $table
            ->query($this->getTableQuery())
            ->columns([
                Tables\Columns\TextColumn::make('index')
                    ->label('No.')
                    ->rowIndex(),
                    
                Tables\Columns\TextColumn::make('judul')
                    ->label('Title')
                    ->searchable()
                    ->sortable()
                    ->weight('medium')
                    ->wrap()
                    ->limit(50),

                Tables\Columns\TextColumn::make('start_date')
                    ->label('Start Date')
                    ->date('d M Y')
                    ->sortable(),

                Tables\Columns\TextColumn::make('start_time')
                    ->label('Start Time')
                    ->time('H:i')
                    ->placeholder('All day'),

                Tables\Columns\TextColumn::make('end_date')
                    ->label('End Date')
                    ->date('d M Y')
                    ->sortable(),

                Tables\Columns\TextColumn::make('end_time')
                    ->label('End Time')
                    ->time('H:i')
                    ->placeholder('All day'),

                Tables\Columns\TextColumn::make('jadwalAssignments.user.name')
                    ->label('Participants')
                    ->listWithLineBreaks()
                    ->limit(2)
                    ->tooltip(function ($record) {
                        return $record->jadwalAssignments
                            ->map(fn($assignment) => $assignment->user->name . ' (' . $assignment->role_user . ')')
                            ->join(', ');
                    }),

                Tables\Columns\TextColumn::make('units.nama_unit')
                    ->label('Units')
                    ->listWithLineBreaks()
                    ->limit(2)
                    ->badge()
                    ->color('secondary'),

                Tables\Columns\TextColumn::make('type')
                    ->label('Type')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'rapat' => 'info',
                        'audit' => 'warning',
                        'pelatihan' => 'success',
                        'lainnya' => 'gray',
                    })
                    ->formatStateUsing(fn(string $state): string => match ($state) {
                        'rapat' => 'Meeting',
                        'audit' => 'Audit',
                        'pelatihan' => 'Training',
                        'lainnya' => 'Other',
                    }),

                Tables\Columns\TextColumn::make('priority')
                    ->label('Priority')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'rendah' => 'gray',
                        'sedang' => 'info',
                        'tinggi' => 'warning',
                        'mendesak' => 'danger',
                    })
                    ->formatStateUsing(fn(string $state): string => match ($state) {
                        'rendah' => 'Low',
                        'sedang' => 'Medium',
                        'tinggi' => 'High',
                        'mendesak' => 'Urgent',
                    }),

                Tables\Columns\TextColumn::make('location')
                    ->label('Location')
                    ->placeholder('-')
                    ->limit(30),

                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'validated' => 'success',
                        'pending' => 'warning',
                        'rejected' => 'danger',
                        default => 'gray',
                    })
                    ->formatStateUsing(fn(string $state): string => match ($state) {
                        'validated' => 'Validated',
                        'pending' => 'Pending',
                        'rejected' => 'Rejected',
                        default => $state,
                    }),
            ])
            ->actions([
                Tables\Actions\ViewAction::make()
                    ->label('View Details')
                    ->icon('heroicon-o-eye')
                    ->modalHeading(fn($record) => 'Schedule: ' . $record->judul)
                    ->modalWidth('5xl')
                    ->infolist([
                        \Filament\Infolists\Components\Section::make('Jadwal Information')
                            ->schema([
                                \Filament\Infolists\Components\Grid::make(2)
                                    ->schema([
                                        \Filament\Infolists\Components\TextEntry::make('judul')
                                            ->label('Title')
                                            ->weight('bold')
                                            ->size('lg')
                                            ->columnSpanFull(),

                                        \Filament\Infolists\Components\TextEntry::make('deskripsi')
                                            ->label('Description')
                                            ->columnSpanFull()
                                            ->placeholder('No description provided'),
                                    ]),
                            ]),

                        \Filament\Infolists\Components\Section::make('Schedule Details')
                            ->schema([
                                \Filament\Infolists\Components\Grid::make(2)
                                    ->schema([
                                        \Filament\Infolists\Components\TextEntry::make('start_date')
                                            ->label('Start Date')
                                            ->date('d M Y'),

                                        \Filament\Infolists\Components\TextEntry::make('end_date')
                                            ->label('End Date')
                                            ->date('d M Y'),

                                        \Filament\Infolists\Components\TextEntry::make('start_time')
                                            ->label('Start Time')
                                            ->time('H:i')
                                            ->placeholder('All day'),

                                        \Filament\Infolists\Components\TextEntry::make('end_time')
                                            ->label('End Time')
                                            ->time('H:i')
                                            ->placeholder('All day'),

                                        \Filament\Infolists\Components\TextEntry::make('location')
                                            ->label('Location')
                                            ->placeholder('No location specified'),

                                        \Filament\Infolists\Components\TextEntry::make('meeting_link')
                                            ->label('Meeting Link')
                                            ->placeholder('No meeting link')
                                            ->url(fn($state) => $state)
                                            ->openUrlInNewTab(),
                                    ]),
                            ]),

                        \Filament\Infolists\Components\Section::make('Additional Information')
                            ->schema([
                                \Filament\Infolists\Components\Grid::make(2)
                                    ->schema([
                                        \Filament\Infolists\Components\TextEntry::make('periode.periode_name')
                                            ->label('Periode')
                                            ->badge()
                                            ->color('primary'),

                                        \Filament\Infolists\Components\TextEntry::make('priority')
                                            ->label('Priority')
                                            ->badge()
                                            ->color(fn(string $state): string => match ($state) {
                                                'mendesak' => 'danger',
                                                'tinggi' => 'warning',
                                                'sedang' => 'info',
                                                'rendah' => 'gray',
                                                default => 'gray',
                                            })
                                            ->formatStateUsing(fn(string $state): string => match ($state) {
                                                'mendesak' => 'Mendesak',
                                                'tinggi' => 'Tinggi',
                                                'sedang' => 'Sedang',
                                                'rendah' => 'Rendah',
                                                default => $state,
                                            }),

                                        \Filament\Infolists\Components\TextEntry::make('status')
                                            ->label('Status')
                                            ->badge()
                                            ->color(fn(string $state): string => match ($state) {
                                                'validated' => 'success',
                                                'pending' => 'warning',
                                                'rejected' => 'danger',
                                                default => 'gray',
                                            })
                                            ->formatStateUsing(fn(string $state): string => match ($state) {
                                                'validated' => 'Validated',
                                                'pending' => 'Pending',
                                                'rejected' => 'Rejected',
                                                default => $state,
                                            }),

                                        \Filament\Infolists\Components\TextEntry::make('type')
                                            ->label('Type')
                                            ->badge()
                                            ->color(fn(string $state): string => match ($state) {
                                                'rapat' => 'info',
                                                'audit' => 'warning',
                                                'pelatihan' => 'success',
                                                'lainnya' => 'gray',
                                                default => 'gray',
                                            })
                                            ->formatStateUsing(fn(string $state): string => match ($state) {
                                                'rapat' => 'Rapat',
                                                'audit' => 'Audit',
                                                'pelatihan' => 'Pelatihan',
                                                'lainnya' => 'Lainnya',
                                                default => $state,
                                            }),
                                    ]),
                            ]),

                        \Filament\Infolists\Components\Section::make('Assignments & Units')
                            ->schema([
                                \Filament\Infolists\Components\RepeatableEntry::make('jadwalAssignments')
                                    ->label('Assigned Users')
                                    ->schema([
                                        \Filament\Infolists\Components\Grid::make(3)
                                            ->schema([
                                                \Filament\Infolists\Components\TextEntry::make('user.nip')
                                                    ->label('NIP'),

                                                \Filament\Infolists\Components\TextEntry::make('user.name')
                                                    ->label('Name')
                                                    ->weight('bold'),

                                                \Filament\Infolists\Components\TextEntry::make('role_user')
                                                    ->label('Role')
                                                    ->badge()
                                                    ->color('primary'),
                                            ])
                                    ])
                                    ->placeholder('No users assigned'),

                                \Filament\Infolists\Components\TextEntry::make('units.nama_unit')
                                    ->label('Related Units')
                                    ->listWithLineBreaks()
                                    ->badge()
                                    ->color('secondary')
                                    ->placeholder('No units assigned'),
                            ])
                            ->columns(1),

                        \Filament\Infolists\Components\Section::make('Validation Info')
                            ->schema([
                                \Filament\Infolists\Components\Grid::make(2)
                                    ->schema([
                                        \Filament\Infolists\Components\TextEntry::make('validator.name')
                                            ->label('Validated By')
                                            ->badge()
                                            ->color('info')
                                            ->placeholder('No validator'),

                                        \Filament\Infolists\Components\TextEntry::make('validated_time')
                                            ->label('Validated At')
                                            ->dateTime('d M Y H:i')
                                            ->placeholder('Not validated yet'),
                                    ]),
                            ])
                            ->visible(fn($record) => $record->status === 'validated'),
                    ]),
            ])
            ->defaultSort('start_date', 'asc')
            ->striped()
            ->paginated([10, 25, 50])
            ->poll('30s');
    }

    protected function getTableQuery(): Builder
    {
        $query = Jadwal::query()
            ->with(['units', 'periode', 'jadwalAssignments.user'])
            ->where('is_active', true)
            ->where('status', 'validated');

        // Apply periode filter
        if ($this->periodeId) {
            $query->where('periode_id', $this->periodeId);
        }

        // Apply view type filter
        switch ($this->viewType) {
            case 'my_schedule':
                $query->whereHas('jadwalAssignments', fn ($q) => $q->where('user_id', Auth::id()));
                break;

            case 'specific_unit':
                if ($this->selectedUnit) {
                    $query->whereHas('units', fn ($q) => $q->where('unit_id', $this->selectedUnit));
                }
                break;

            case 'all':
            default:
                // Show all jadwal from the selected periode (no additional filter)
                break;
        }

        return $query;
    }
}