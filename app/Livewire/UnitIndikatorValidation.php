<?php

// app/Http/Livewire/UnitIndikatorValidation.php

namespace App\Http\Livewire;

use App\Models\UnitIndikator;
use Livewire\Component;
use Illuminate\Support\Facades\Auth;

class UnitIndikatorValidation extends Component
{
    public $unitIndikator;
    public $indikators = [];

    public function mount(UnitIndikator $unitIndikator)
    {
        $this->unitIndikator = $unitIndikator;

        // Load related data (indicators, etc.)
        $this->indikators = $unitIndikator->unitIndikatorIndikators->toArray();
    }

    public function updateValidation($indikatorId, $isRejected, $komentar)
    {
        $indikator = $this->unitIndikator->unitIndikatorIndikators->find($indikatorId);

        if ($indikator) {
            $indikator->is_rejected = $isRejected;
            $indikator->komentar = $komentar;
            $indikator->save();

            session()->flash('success', 'Validasi berhasil disimpan.');
        }
    }

    public function render()
    {
        return view('livewire.unit-indikator-validation');
    }
}
