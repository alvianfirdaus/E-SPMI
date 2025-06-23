{{-- resources/views/filament/resources/unit-indikator-resource/pages/validasi-unit-indikator.blade.php --}}
<x-filament::page>
    <form wire:submit.prevent="submit">
        {{ $this->form }}

        <div class="mt-6 flex justify-end">
            <x-filament::button type="submit" class="px-6">
                Simpan
            </x-filament::button>
        </div>
    </form>
</x-filament::page>