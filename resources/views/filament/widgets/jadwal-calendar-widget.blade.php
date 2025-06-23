<x-filament::input.wrapper>
    {{-- Periode Select --}}
    <x-filament::input.select wire:model.live="periodeId" id="calendar-periode-select">
        @foreach ($periodes as $id => $name)
            <option value="{{ $id }}">{{ $name }}</option>
        @endforeach
    </x-filament::input.select>

    {{-- View Type --}}
    <x-filament::input.select wire:model.live="viewType">
        <option value="all">All Schedules</option>
        <option value="my_schedule">My Schedule</option>
        <option value="specific_unit">Specific Unit</option>
    </x-filament::input.select>

    @if ($viewType === 'specific_unit')
        <x-filament::input.select wire:model.live="selectedUnit">
            @foreach ($units as $id => $name)
                <option value="{{ $id }}">{{ $name }}</option>
            @endforeach
        </x-filament::input.select>
    @endif

    <div>
        <strong>Current Filters:</strong><br>
        PeriodeId: {{ $periodeId }}<br>
        ViewType: {{ $viewType }}<br>
        SelectedUnit: {{ $selectedUnit }}<br>
    </div>

    {{-- Livewire Calendar Widget --}}
    @livewire(App\Filament\Widgets\JadwalCalendarWidget::class, [
        'selectedUnit' => $selectedUnit,
        'periodeId' => $periodeId,
        'viewType' => $viewType,
    ], key("calendar-{$periodeId}-{$viewType}-{$selectedUnit}"))

    {{-- Script to dispatch filter updates --}}
    <script>
        document.addEventListener('livewire:updated', function () {
            // Get current values
            const periodeId = @json($periodeId);
            const viewType = @json($viewType);
            const selectedUnit = @json($selectedUnit);
            
            // Dispatch to calendar widget
            Livewire.dispatch('updateCalendarFilters', {
                periodeId: periodeId,
                viewType: viewType,
                selectedUnit: selectedUnit
            });
        });
    </script>
    <script>
        // Listen for periode switcher changes
        document.addEventListener('livewire:dispatched', function (event) {
            if (event.detail.name === 'refresh-assign-table') {
                // Get new periode from session/storage or dispatch event
                @this.syncWithPeriodeSwitcher();
            }
        });
    </script>
</x-filament::input.wrapper>