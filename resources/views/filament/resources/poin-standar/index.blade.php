<x-filament::page>
    <div class="space-y-6">
        {{-- Tabel Semua Poin Standar --}}
        <x-filament::section>
            <h2 class="text-xl font-semibold">Semua Poin Standar</h2>
            {{ $allRecords }}
        </x-filament::section>

        {{-- Tabel Validasi Saya --}}
        <x-filament::section>
            <h2 class="text-xl font-semibold">Validasi Saya</h2>
            {{ $myValidationRecords }}
        </x-filament::section>
    </div>
</x-filament::page>