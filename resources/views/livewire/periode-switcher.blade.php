<div class="flex items-center gap-3">
    <label for="periode-select" class="text-sm font-medium">
        Periode:
    </label>
    
    <x-filament::input.wrapper>
        <x-filament::input.select wire:model.live="setSelectedPeriode" id="periode-select">
            <option value="">-- Pilih Periode --</option>

            @foreach ($periodes as $periode)
                <option value="{{ $periode->id }}">
                    @if($periode->id == $activePeriodeId)
                        🟢 {{ $periode->periode_name }} (Active)
                    @else
                        📅 {{ $periode->periode_name }}
                    @endif
                </option>
            @endforeach
        </x-filament::input.select>
    </x-filament::input.wrapper>

    @if($setSelectedPeriode)
        @if($setSelectedPeriode == $activePeriodeId)
            <x-filament::badge color="success" size="sm">
                Current Active
            </x-filament::badge>
        @else
            @php
                $selectedPeriode = $periodes->firstWhere('id', $setSelectedPeriode);
                $startDate = $selectedPeriode?->start_date;
                $isHistorical = $startDate && \Carbon\Carbon::parse($startDate)->isPast();
                $isFuture = $startDate && \Carbon\Carbon::parse($startDate)->isFuture();
            @endphp
            
            @if($isHistorical)
                <x-filament::badge color="gray" size="sm">
                    Historical
                </x-filament::badge>
            @elseif($isFuture)
                <x-filament::badge color="info" size="sm">
                    Future
                </x-filament::badge>
            @else
                <x-filament::badge color="warning" size="sm">
                    Other Periode
                </x-filament::badge>
            @endif
        @endif
    @endif
</div>
