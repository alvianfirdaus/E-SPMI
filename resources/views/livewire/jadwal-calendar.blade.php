<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Filter Controls --}}
        <x-filament::section>
            <x-slot name="heading">
                <div class="flex items-center gap-2">
                    <x-heroicon-o-funnel class="w-5 h-5" />
                    Calendar Filters
                </div>
            </x-slot>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <div>
                    <x-filament-forms::field-wrapper label="Periode">
                        <x-filament::input.wrapper>
                            <x-filament::input.select wire:model.live="periodeId">
                                @foreach ($periodes as $id => $name)
                                    <option value="{{ $id }}">{{ $name }}</option>
                                @endforeach
                            </x-filament::input.select>
                        </x-filament::input.wrapper>
                    </x-filament-forms::field-wrapper>
                </div>

                <div>
                    <x-filament-forms::field-wrapper label="View Type">
                        <x-filament::input.wrapper>
                            <x-filament::input.select wire:model.live="viewType">
                                <option value="all">All Schedules</option>
                                <option value="my_schedule">My Schedule</option>
                                <option value="specific_unit">Specific Unit</option>
                            </x-filament::input.select>
                        </x-filament::input.wrapper>
                    </x-filament-forms::field-wrapper>
                </div>

                @if ($viewType === 'specific_unit')
                    <div x-data x-transition:enter="transition ease-out duration-200" 
                         x-transition:enter-start="opacity-0 transform scale-95" 
                         x-transition:enter-end="opacity-100 transform scale-100">
                        <x-filament-forms::field-wrapper label="Select Unit">
                            <x-filament::input.wrapper>
                                <x-filament::input.select wire:model.live="selectedUnit">
                                    @foreach ($units as $id => $name)
                                        <option value="{{ $id }}">{{ $name }}</option>
                                    @endforeach
                                </x-filament::input.select>
                            </x-filament::input.wrapper>
                        </x-filament-forms::field-wrapper>
                    </div>
                @endif
            </div>
        </x-filament::section>

        {{-- Calendar Section --}}
        <x-filament::section>
            <x-slot name="heading">
                <div class="flex items-center justify-between w-full">
                    <div class="flex items-center gap-2">
                        <x-heroicon-o-calendar class="w-5 h-5" />
                        Schedule Calendar
                    </div>
                    <x-filament::button 
                        wire:click="refreshCalendar" 
                        icon="heroicon-o-arrow-path"
                        color="gray"
                        size="sm"
                    >
                        Refresh
                    </x-filament::button>
                </div>
            </x-slot>

            {{-- Calendar Widget with explicit parameters --}}
            <div class="min-h-[600px]">
                @livewire(App\Filament\Widgets\JadwalCalendarWidget::class, [
                    'selectedUnit' => $selectedUnit,
                    'periodeId' => $periodeId,
                    'viewType' => $viewType,
                ], key("calendar-{$periodeId}-{$viewType}-{$selectedUnit}"))
            </div>
        </x-filament::section>

        {{-- Table Section --}}
        <x-filament::section>
            <x-slot name="heading">
                <div class="flex items-center gap-2">
                    <x-heroicon-o-table-cells class="w-5 h-5" />
                    Schedule Table
                </div>
            </x-slot>

            {{-- Table Widget with explicit parameters --}}
            @livewire(App\Filament\Widgets\JadwalTableWidget::class, [
                'periodeId' => $periodeId,
                'viewType' => $viewType,
                'selectedUnit' => $selectedUnit,
            ], key("table-{$periodeId}-{$viewType}-{$selectedUnit}"))
        </x-filament::section>
    </div>

    {{-- Auto-update widgets when filters change --}}
    <script>
        document.addEventListener('livewire:updated', function () {
            // Small delay to ensure all updates are processed
            setTimeout(() => {
                Livewire.dispatch('updateCalendarFilters', {
                    periodeId: @js($periodeId),
                    viewType: @js($viewType),
                    selectedUnit: @js($selectedUnit)
                });
            }, 100);
        });
    </script>
</x-filament-panels::page>