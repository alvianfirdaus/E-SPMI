<?php

namespace App\Livewire;

use Livewire\Component;
use App\Models\Periode;
use Illuminate\Support\Facades\Session;
use Filament\Notifications\Notification;

class PeriodeSwitcher extends Component
{
    public $setSelectedPeriode;
    public $activePeriodeId; // Store the active periode ID

    public function mount()
    {
        // Get the active periode (for highlighting purposes only)
        $this->activePeriodeId = \App\Models\Periode::where('status_periode', 'active')
            ->where('status', 'validated')
            ->value('id');

        if (!session()->has('selected_periode_id')) {
            // Default to active periode, but user can select any validated periode
            session(['selected_periode_id' => $this->activePeriodeId]);
        }

        $this->setSelectedPeriode = session('selected_periode_id');
    }

    public function updated($property)
{
    if ($property === 'setSelectedPeriode') {
        session(['selected_periode_id' => $this->setSelectedPeriode]);
        session()->forget('user_overrode_periode_filter');

        $this->dispatch('refresh-assign-table');

        $selectedPeriode = Periode::find($this->setSelectedPeriode);
        $periodeName = $selectedPeriode ? $selectedPeriode->periode_name : 'Unknown';
    }
}


    public function render()
    {
        return view('livewire.periode-switcher', [
            'periodes' => Periode::where('status', 'validated')
                ->orderBy('created_at', 'desc') // Most recent first
                ->get(),
            'activePeriodeId' => $this->activePeriodeId, // For highlighting active periode
        ]);
    }
}