<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Page Header --}}
        <div class="bg-white dark:bg-gray-800 rounded-lg border p-4">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-lg font-medium text-gray-900 dark:text-white">
                        Kalender Jadwal Kegiatan
                    </h2>
                    <p class="text-sm text-gray-600 dark:text-gray-400">
                        Filter akan mempengaruhi tampilan kalender dan tabel secara bersamaan
                    </p>
                </div>
<x-filament::input.wrapper>
    {{-- Periode Select --}}
    <x-filament::input.select wire:model="periodeId">
        @foreach ($periodes as $id => $name)
            <option value="{{ $id }}">{{ $name }}</option>
        @endforeach
    </x-filament::input.select>

    {{-- View Type --}}
    <x-filament::input.select wire:model="viewType">
        <option value="all">All Schedules</option>
        <option value="my_schedule">My Schedule</option>
        <option value="specific_unit">Specific Unit</option>
    </x-filament::input.select>

    {{-- Unit Select (shown only if viewType is 'specific_unit') --}}
    @if ($viewType === 'specific_unit')
        <x-filament::input.select wire:model="selectedUnit">
            @foreach ($units as $id => $name)
                <option value="{{ $id }}">{{ $name }}</option>
            @endforeach
        </x-filament::input.select>
    @endif
</x-filament::input.wrapper>

{{-- Debugging output --}}
<div>
    Current Filters:<br>
    PeriodeId: {{ $periodeId }}<br>
    ViewType: {{ $viewType }}<br>
    SelectedUnit: {{ $selectedUnit }}<br>
</div>


@livewire(\App\Filament\Widgets\JadwalCalendarWidget::class, 
['selectedUnit' => $selectedUnit],
key(str()->random()))
                {{-- Filter Status --}}
                {{-- <div class="text-right">
                    <p class="text-xs text-gray-500 mb-1">Filter Aktif:</p>
                    <div class="flex flex-wrap gap-1 justify-end">
                        @if($this->view_type !== 'semua')
                            <span class="px-2 py-1 rounded-full text-xs font-medium bg-blue-100 text-blue-800">
                                {{ match($this->view_type) {
                                    'jadwal_saya' => '👤 Jadwal Saya',
                                    'jadwal_unit' => '🏢 Unit Saya',
                                    'unit_tertentu' => '🎯 Unit Tertentu',
                                    default => 'Semua'
                                } }}
                            </span>
                        @endif
                        
                        @if($this->priority)
                            <span class="px-2 py-1 rounded-full text-xs font-medium bg-yellow-100 text-yellow-800">
                                🔥 {{ ucfirst($this->priority) }}
                            </span>
                        @endif
                        
                        @if($this->type)
                            <span class="px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                                📋 {{ ucfirst($this->type) }}
                            </span>
                        @endif
                        
                        @if($this->view_type === 'semua' && !$this->priority && !$this->type)
                            <span class="px-2 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-800">
                                📋 Semua Data
                            </span>
                        @endif
                    </div>
                </div> --}}

            </div>
            {{-- <div class="mt-4">
{{ $this->form }}
</div> --}}
<div class="mt-4">
</div>
{{-- <x-filament::button wire:click="applyFilters" icon="heroicon-o-user">
    Terapkan Filter
</x-filament::button> --}}
        </div>
        {{-- <div>
            @livewire(\App\Filament\Widgets\JadwalCalendarWidget::class, [
        'periode_id' => $this->periode_id,
        'view_type' => $this->view_type,
        'unit_id' => $this->unit_id,
        'start_date' => $this->start_date,
        'end_date' => $this->end_date,
        'priority' => $this->priority,
        'type' => $this->type,
    ])
        </div> --}}

        {{-- Color Legend --}}
        <div class="bg-gradient-to-r from-blue-50 to-indigo-50 dark:from-blue-900/20 dark:to-indigo-900/20 rounded-lg border border-blue-200 dark:border-blue-800 p-4">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                {{-- Priority Colors --}}
                <div>
                    <h4 class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                        🔥 Prioritas (Background)
                    </h4>
                    <div class="flex flex-wrap gap-2">
                        <div class="flex items-center space-x-2">
                            <div class="w-4 h-4 bg-red-600 rounded"></div>
                            <span class="text-xs text-gray-600">Mendesak</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-4 h-4 bg-orange-500 rounded"></div>
                            <span class="text-xs text-gray-600">Tinggi</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-4 h-4 bg-blue-600 rounded"></div>
                            <span class="text-xs text-gray-600">Sedang</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-4 h-4 bg-gray-500 rounded"></div>
                            <span class="text-xs text-gray-600">Rendah</span>
                        </div>
                    </div>
                </div>

                {{-- Type Colors --}}
                <div>
                    <h4 class="text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">
                        📋 Tipe (Border)
                    </h4>
                    <div class="flex flex-wrap gap-2">
                        <div class="flex items-center space-x-2">
                            <div class="w-4 h-4 border-2 border-blue-500 bg-white rounded"></div>
                            <span class="text-xs text-gray-600">Meeting</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-4 h-4 border-2 border-amber-500 bg-white rounded"></div>
                            <span class="text-xs text-gray-600">Deadline</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-4 h-4 border-2 border-red-500 bg-white rounded"></div>
                            <span class="text-xs text-gray-600">Audit</span>
                        </div>
                        <div class="flex items-center space-x-2">
                            <div class="w-4 h-4 border-2 border-green-500 bg-white rounded"></div>
                            <span class="text-xs text-gray-600">Training</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        {{-- Quick Stats --}}
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div class="bg-blue-50 dark:bg-blue-900/20 rounded-lg p-4 border border-blue-200">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-blue-600">Total Jadwal</p>
                        <p class="text-2xl font-bold text-blue-900 dark:text-blue-100">
                            {{ \App\Models\Jadwal::visible()->count() }}
                        </p>
                        <p class="text-xs text-blue-600">Semua periode aktif</p>
                    </div>
                    <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                    </svg>
                </div>
            </div>

            <div class="bg-yellow-50 dark:bg-yellow-900/20 rounded-lg p-4 border border-yellow-200">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-yellow-600">Hari Ini</p>
                        <p class="text-2xl font-bold text-yellow-900 dark:text-yellow-100">
                            {{ \App\Models\Jadwal::visible()->today()->count() }}
                        </p>
                        <p class="text-xs text-yellow-600">{{ now()->format('d M Y') }}</p>
                    </div>
                    <svg class="w-8 h-8 text-yellow-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>
            </div>

            <div class="bg-green-50 dark:bg-green-900/20 rounded-lg p-4 border border-green-200">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-green-600">Minggu Ini</p>
                        <p class="text-2xl font-bold text-green-900 dark:text-green-100">
                            {{ \App\Models\Jadwal::visible()->thisWeek()->count() }}
                        </p>
                        <p class="text-xs text-green-600">{{ now()->startOfWeek()->format('d M') }} - {{ now()->endOfWeek()->format('d M') }}</p>
                    </div>
                    <svg class="w-8 h-8 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                </div>
            </div>

            <div class="bg-red-50 dark:bg-red-900/20 rounded-lg p-4 border border-red-200">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-red-600">Mendesak</p>
                        <p class="text-2xl font-bold text-red-900 dark:text-red-100">
                            {{ \App\Models\Jadwal::visible()->where('priority', 'urgent')->count() }}
                        </p>
                        <p class="text-xs text-red-600">Prioritas tinggi</p>
                    </div>
                    <svg class="w-8 h-8 text-red-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-2.5L13.732 4c-.77-.833-1.964-.833-2.732 0L3.732 16.5c-.77.833.192 2.5 1.732 2.5z"></path>
                    </svg>
                </div>
            </div>
        </div>

        {{-- Calendar and Table widgets will be rendered automatically --}}
    </div>
    <script>
        window.addEventListener('filter-changed', event => {
    const filters = event.detail;

    // Example: reload or update Guava Calendar with new filters
    guavaCalendar.reload({
        periode_id: filters.periode_id,
        view_type: filters.view_type,
        unit_id: filters.unit_id,
        start_date: filters.start_date,
        end_date: filters.end_date,
        priority: filters.priority,
        type: filters.type,
    });
});
    </script>
</x-filament-panels::page>