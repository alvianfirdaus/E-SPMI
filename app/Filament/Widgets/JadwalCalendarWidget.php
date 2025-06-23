<?php

namespace App\Filament\Widgets;

use App\Models\Jadwal;
use App\Models\Periode;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Model;
use Saade\FilamentFullCalendar\Data\EventData;
use Saade\FilamentFullCalendar\Widgets\FullCalendarWidget;
use Saade\FilamentFullCalendar\Actions;

class JadwalCalendarWidget extends FullCalendarWidget
{
    public Model | string | null $model = Jadwal::class;

    public ?string $selectedUnit = null;
    public ?string $viewType = 'my_schedule';
    public ?int $periodeId = null;

    protected $listeners = [
        'updateCalendarFilters' => 'handleFilterUpdate',
        'refresh-assign-table' => 'handlePeriodeChange'
    ];

    public function mount()
    {
        // Priority: 1) Passed parameter, 2) Session, 3) Active periode
        $this->periodeId = $this->periodeId ?? 
            session('selected_periode_id') ?? 
            Periode::where('status_periode', 'active')->where('status', 'validated')->first()?->id;
        $this->viewType = $this->viewType ?? 'my_schedule';
    }

    public function handleFilterUpdate($data)
    {
        $oldPeriodeId = $this->periodeId;
        
        $this->periodeId = $data['periodeId'];
        $this->viewType = $data['viewType'];
        $this->selectedUnit = $data['selectedUnit'];
        
        // Check if periode changed to navigate calendar
        $shouldNavigate = $oldPeriodeId !== $this->periodeId;
        
        // Get the new periode's start date for navigation
        $navigateToDate = null;
        if ($shouldNavigate && $this->periodeId) {
            $periode = Periode::find($this->periodeId);
            if ($periode && $periode->start_date) {
                // Handle datetime string, date string, or Carbon object
                if (is_string($periode->start_date)) {
                    // Extract just the date part from datetime string
                    $navigateToDate = date('Y-m-d', strtotime($periode->start_date));
                } else {
                    $navigateToDate = $periode->start_date->format('Y-m-d');
                }
            }
        }
        
        // Force calendar to refetch events and navigate if needed
        $jsCode = '
            setTimeout(() => {
                const calendarEl = document.querySelector("[wire\\\\:id=\'' . $this->getId() . '\'] .fc");
                if (calendarEl && calendarEl._calendar) {';
        
        if ($navigateToDate) {
            $jsCode .= '
                    // Navigate to the periode start date
                    calendarEl._calendar.gotoDate("' . $navigateToDate . '");';
        }
        
        $jsCode .= '
                    // Refetch events
                    calendarEl._calendar.refetchEvents();
                }
            }, 100);
        ';
        
        $this->js($jsCode);
    }

    public function handlePeriodeChange()
    {
        // Get the new periode from session
        $newPeriodeId = session('selected_periode_id');
        
        // Only update if periode actually changed
        if ($this->periodeId !== $newPeriodeId) {
            $oldPeriodeId = $this->periodeId;
            $this->periodeId = $newPeriodeId;
            
            // Get the new periode's start date for navigation
            $navigateToDate = null;
            if ($this->periodeId) {
                $periode = Periode::find($this->periodeId);
                if ($periode && $periode->start_date) {
                    // Handle datetime string, date string, or Carbon object
                    if (is_string($periode->start_date)) {
                        $navigateToDate = date('Y-m-d', strtotime($periode->start_date));
                    } else {
                        $navigateToDate = $periode->start_date->format('Y-m-d');
                    }
                }
            }
            
            // Force calendar to refetch events and navigate
            $jsCode = '
                setTimeout(() => {
                    const calendarEl = document.querySelector("[wire\\\\:id=\'' . $this->getId() . '\'] .fc");
                    if (calendarEl && calendarEl._calendar) {';
            
            if ($navigateToDate) {
                $jsCode .= '
                        // Navigate to the periode start date
                        calendarEl._calendar.gotoDate("' . $navigateToDate . '");';
            }
            
            $jsCode .= '
                        // Refetch events
                        calendarEl._calendar.refetchEvents();
                    }
                }, 100);
            ';
            
            $this->js($jsCode);
        }
    }

    public function config(): array
    {
        // Get initial date from current periode
        $initialDate = null;
        if ($this->periodeId) {
            $periode = Periode::find($this->periodeId);
            if ($periode && $periode->start_date) {
                // Handle datetime string, date string, or Carbon object
                if (is_string($periode->start_date)) {
                    // Extract just the date part from datetime string
                    $initialDate = date('Y-m-d', strtotime($periode->start_date));
                } else {
                    $initialDate = $periode->start_date->format('Y-m-d');
                }
            }
        }
        
        $config = [
            'headerToolbar' => [
                'left' => 'prev,next today',
                'center' => 'title',
                'right' => 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
            ],
            'initialView' => 'dayGridMonth',
            'height' => 'auto',
            'views' => [
                'listMonth' => [
                    'titleFormat' => ['year' => 'numeric', 'month' => 'long']
                ]
            ]
        ];
        
        // Set initial date if we have a periode
        if ($initialDate) {
            $config['initialDate'] = $initialDate;
        }
        
        return $config;
    }

    public function fetchEvents(array $info): array
    {
        $query = Jadwal::query()
            ->with(['units', 'periode', 'jadwalAssignments.user'])
            ->where('start_date', '<=', $info['end'])
            ->where('end_date', '>=', $info['start'])
            ->where('is_active', true)
            ->where('status', 'validated');

        $periodeId = $this->periodeId ?? session('selected_periode_id') ?? 
            Periode::where('status_periode', 'active')->first()?->id;
        if ($periodeId) {
            $query->where('periode_id', $periodeId);
        }

        // VIEW TYPE FILTER (additional filter on top of periode)
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

        // Rest stays the same...
        $events = $query->get()
            ->map(function (Jadwal $event) {
                $startTime = $event->start_time ?? '00:00:00';
                $endTime = $event->end_time ?? '00:00:00';

                $startDateTime = $event->start_date->format('Y-m-d') . ' ' . $startTime;
                $endDateTime = $event->end_date->format('Y-m-d') . ' ' . $endTime;

                $colors = $this->getEventColors($event);

                return EventData::make()
                    ->id($event->id)
                    ->title($event->judul)
                    ->start($startDateTime)
                    ->end($endDateTime)
                    ->backgroundColor($colors['background'])
                    ->borderColor($colors['border'])
                    ->textColor($colors['text'])
                    ->extendedProps([
                        'priority' => $event->priority,
                        'type' => $event->type,
                        'description' => $event->deskripsi,
                        'location' => $event->location,
                        'participants' => $event->jadwalAssignments->count(),
                        'units' => $event->units->pluck('nama_unit')->join(', '),
                        'priorityLabel' => $this->getPriorityLabel($event->priority),
                        'typeLabel' => $this->getTypeLabel($event->type),
                        'status' => $event->status,
                        'periode_name' => $event->periode->periode_name ?? 'No Periode',
                    ])
                    ->toArray();
            })
            ->all();
        
        return $events;
    }

    // Get event colors based on priority (background) and type (border)
    protected function getEventColors(Jadwal $jadwal): array
    {
        // Background color based on priority
        $backgroundColors = [
            'rendah' => '#6b7280',      // Gray
            'sedang' => '#3b82f6',      // Blue  
            'tinggi' => '#f59e0b',      // Orange
            'mendesak' => '#ef4444',    // Red
        ];

        // Border color based on type
        $borderColors = [
            'rapat' => '#8b5cf6',       // Purple
            'audit' => '#f97316',       // Orange
            'pelatihan' => '#10b981',   // Green
            'lainnya' => '#6b7280',     // Gray
        ];

        return [
            'background' => $backgroundColors[$jadwal->priority] ?? '#6b7280',
            'border' => $borderColors[$jadwal->type] ?? '#6b7280',
            'text' => '#ffffff'
        ];
    }

    protected function getPriorityLabel(string $priority): string
    {
        return match($priority) {
            'rendah' => 'Rendah',
            'sedang' => 'Sedang', 
            'tinggi' => 'Tinggi',
            'mendesak' => 'Mendesak',
            default => $priority
        };
    }

    protected function getTypeLabel(string $type): string
    {
        return match($type) {
            'rapat' => 'Rapat',
            'audit' => 'Audit',
            'pelatihan' => 'Pelatihan', 
            'lainnya' => 'Lainnya',
            default => $type
        };
    }

    protected function headerActions(): array
    {
        return [
            // Empty - no create button in header
        ];
    }

    // OVERRIDE: Disable modal actions
    protected function modalActions(): array
    {
        return [
            Actions\ViewAction::make()
                ->label('View Details')
                ->icon('heroicon-o-eye')
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
                                        ->url(fn ($state) => $state)
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
                                        ->color(fn (string $state): string => match ($state) {
                                            'mendesak' => 'danger',
                                            'tinggi' => 'warning',
                                            'sedang' => 'info',
                                            'rendah' => 'gray',
                                            default => 'gray',
                                        })
                                        ->formatStateUsing(fn (string $state): string => match ($state) {
                                            'mendesak' => 'Mendesak',
                                            'tinggi' => 'Tinggi',
                                            'sedang' => 'Sedang',
                                            'rendah' => 'Rendah',
                                            default => $state,
                                        }),
                                        
                                    \Filament\Infolists\Components\TextEntry::make('status')
                                        ->label('Status')
                                        ->badge()
                                        ->color(fn (string $state): string => match ($state) {
                                            'validated' => 'success',
                                            'pending' => 'warning',
                                            'rejected' => 'danger',
                                            default => 'gray',
                                        })
                                        ->formatStateUsing(fn (string $state): string => match ($state) {
                                            'validated' => 'Validated',
                                            'pending' => 'Pending',
                                            'rejected' => 'Rejected',
                                            default => $state,
                                        }),
                                        
                                    \Filament\Infolists\Components\TextEntry::make('type')
                                        ->label('Type')
                                        ->badge()
                                        ->color(fn (string $state): string => match ($state) {
                                            'rapat' => 'info',
                                            'audit' => 'warning',
                                            'pelatihan' => 'success',
                                            'lainnya' => 'gray',
                                            default => 'gray',
                                        })
                                        ->formatStateUsing(fn (string $state): string => match ($state) {
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
                        ->visible(fn ($record) => $record->status === 'validated'),
                ])
                ->modalHeading(fn ($record) => 'Schedule: ' . $record->judul)
                ->modalWidth('5xl'),
        ];
    }

    public function eventDidMount(): string
    {
        return <<<JS
            function({ event, timeText, isStart, isEnd, isMirror, isPast, isFuture, isToday, el, view }){
                // Create rich tooltip content
                const extendedProps = event.extendedProps;
                const tooltipContent = `
                    <div class="p-3 max-w-xs">
                        <div class="font-bold text-sm mb-2">\${event.title}</div>
                        <div class="space-y-1 text-xs">
                            <div><span class="font-medium">Prioritas:</span> 
                                <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium" 
                                      style="background-color: \${event.backgroundColor}20; color: \${event.backgroundColor}">
                                    \${extendedProps.priorityLabel || 'N/A'}
                                </span>
                            </div>
                            <div><span class="font-medium">Tipe:</span> 
                                <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium" 
                                      style="background-color: \${event.borderColor}20; color: \${event.borderColor}">
                                    \${extendedProps.typeLabel || 'N/A'}
                                </span>
                            </div>
                            <div><span class="font-medium">Status:</span> 
                                <span class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-green-100 text-green-800">
                                    Validated
                                </span>
                            </div>
                            \${extendedProps.location ? `<div><span class="font-medium">Lokasi:</span> \${extendedProps.location}</div>` : ''}
                            \${extendedProps.participants ? `<div><span class="font-medium">Peserta:</span> \${extendedProps.participants} orang</div>` : ''}
                            \${extendedProps.units ? `<div><span class="font-medium">Unit:</span> \${extendedProps.units}</div>` : ''}
                            \${extendedProps.description ? `<div class="mt-2 pt-2 border-gray-200"><span class="font-medium">Deskripsi:</span><div class="mt-1">\${extendedProps.description}</div></div>` : ''}
                        </div>
                    </div>
                `;

                el.setAttribute("x-tooltip", "tooltip");
                el.setAttribute("x-data", `{ tooltip: '\${tooltipContent}' }`);
                
                // Add hover effects
                el.style.cursor = 'pointer';
                el.style.transition = 'all 0.2s ease';
                
                el.addEventListener('mouseenter', function() {
                    el.style.transform = 'scale(1.02)';
                    el.style.boxShadow = '0 4px 12px rgba(0,0,0,0.15)';
                    el.style.zIndex = '10';
                });
                
                el.addEventListener('mouseleave', function() {
                    el.style.transform = 'scale(1)';
                    el.style.boxShadow = 'none';
                    el.style.zIndex = 'auto';
                });
                
                // Store calendar reference
                const calendarEl = el.closest('.fc');
                if (calendarEl && !calendarEl._calendar) {
                    calendarEl._calendar = view.calendar;
                }
            }
        JS;
    }

    // Add this method for debugging
    public function getEventsCount(): int
    {
        return Jadwal::query()
            ->where('is_active', true)
            ->where('status', 'validated')
            ->count();
    }
}