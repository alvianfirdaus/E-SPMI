<?
namespace App\Http\Livewire;

use Livewire\Component;
use App\Models\Jadwal;
use App\Models\Periode;
use App\Models\Unit;
use Illuminate\Support\Facades\Auth;
use Saade\FilamentFullCalendar\Data\EventData;

class JadwalCalendar extends Component
{
    public ?string $viewType = 'all';
    public ?int $periodeId = null;
    public ?int $selectedUnit = null;

    public array $periodes = [];
    public array $units = [];

    public function mount()
    {
        $this->periodes = Periode::pluck('periode_name', 'id')->toArray();
        $this->periodeId = Periode::where('status_periode', 'active')->first()?->id;

        $this->units = Unit::pluck('nama_unit', 'id')->toArray();
        $this->selectedUnit = array_key_first($this->units);
    }

    public function render()
    {
        return view('livewire.jadwal-calendar-livewire', [
            'events' => $this->fetchEvents()
        ]);
    }

    public function fetchEvents(): array
    {
        $query = Jadwal::query()
            ->with(['units', 'periode', 'users'])
            ->where('start_date', '<=', now()->endOfMonth())
            ->where('end_date', '>=', now()->startOfMonth());

        if ($this->periodeId) {
            $query->where('periode_id', $this->periodeId);
        }

        switch ($this->viewType) {
            case 'my_schedule':
                $query->whereHas('users', fn ($q) => $q->where('user_id', Auth::id()));
                break;

            case 'specific_unit':
                if ($this->selectedUnit) {
                    $query->whereHas('units', fn ($q) => $q->where('unit_id', $this->selectedUnit));
                }
                break;

            case 'all':
            default:
                break;
        }

        return $query->get()
            ->map(function (Jadwal $event) {
                $startTime = $event->start_time ?? '00:00:00';
                $endTime = $event->end_time ?? '00:00:00';

                return EventData::make()
                    ->id($event->id)
                    ->title($event->judul)
                    ->start("{$event->start_date} {$startTime}")
                    ->end("{$event->end_date} {$endTime}")
                    ->toArray();
            })
            ->toArray();
    }
}
