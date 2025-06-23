<?php

namespace App\Filament\Pages;

use App\Filament\Widgets\JadwalCalendarWidget;
use App\Models\Periode;
use App\Models\Unit;
use Filament\Pages\Page;

class JadwalCalendarPage extends Page
{
    protected static ?string $navigationIcon = 'heroicon-o-calendar-days';
    protected static string $view = 'livewire.jadwal-calendar';
    protected static ?string $title = 'Kalender Jadwal';
    protected static ?string $navigationLabel = 'Kalender';
    protected static ?int $navigationSort = 20;

    public array $units = [];
    public ?string $viewType = 'my_schedule';
    public ?int $periodeId = null;
    public ?int $selectedUnit = null;
    public array $periodes = [];

    // Add listeners for both PeriodeSwitcher and widget requests
    protected $listeners = [
        'refresh-assign-table' => 'syncWithPeriodeSwitcher',
        'requestCurrentFilters' => 'sendCurrentFilters'
    ];

    public function mount()
    {
        $this->viewType = 'my_schedule';
        
        // Get periode from session first (from PeriodeSwitcher), fallback to active
        $this->periodeId = session('selected_periode_id') ?? 
            \App\Models\Periode::where('status_periode', 'active')->first()?->id;
        
        // Load all validated periodes for the dropdown
        $this->periodes = \App\Models\Periode::where('status', 'validated')
            ->orderBy('periode_name')
            ->pluck('periode_name', 'id')
            ->toArray();
            
        $this->units = Unit::pluck('nama_unit', 'id')->toArray();
        $this->selectedUnit = array_key_first($this->units);
    }

    public function syncWithPeriodeSwitcher()
    {
        // Get new periode from session (set by PeriodeSwitcher)
        $newPeriodeId = session('selected_periode_id');
        
        // Only update if periode actually changed
        if ($this->periodeId !== $newPeriodeId) {
            $this->periodeId = $newPeriodeId;
            
            // Update the widgets
            $this->updateCalendarWidget();
        }
    }

    public function sendCurrentFilters()
    {
        // Send current filter state to all widgets
        $this->updateCalendarWidget();
    }

    public function updatedPeriodeId()
    {
        // When user manually changes periode select, update session
        session(['selected_periode_id' => $this->periodeId]);
        
        // Update widgets
        $this->updateCalendarWidget();
    }

    public function updatedViewType()
    {
        $this->updateCalendarWidget();
    }

    public function updatedSelectedUnit()
    {
        $this->updateCalendarWidget();
    }

    protected function updateCalendarWidget()
    {
        $this->dispatch('updateCalendarFilters', [
            'periodeId' => $this->periodeId,
            'viewType' => $this->viewType,
            'selectedUnit' => $this->selectedUnit
        ]);
    }

    protected function getWidgets(): array
    {
        return [
            JadwalCalendarWidget::class,
            \App\Filament\Widgets\JadwalTableWidget::class,
        ];
    }

    public function refreshCalendar()
    {
        $this->updateCalendarWidget();
    }

    // Make sure widgets get initial data on page load
    public function booted()
    {
        // Send initial filter state after component is fully loaded
        $this->updateCalendarWidget();
    }
}