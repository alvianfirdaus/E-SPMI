<x-filament::grid
    default
    sm="2"
    md="3"
    class="p-4 text-sm text-gray-700 dark:text-gray-300"
>
    <div>
        <strong>Pengguna:</strong>
        {{ $record->users->pluck('name')->implode(', ') ?: '-' }}
    </div>

    <div>
        <strong>Dibuat pada:</strong>
        {{ $record->created_at?->translatedFormat('d F Y H:i') ?? '-' }}
    </div>
</x-filament::grid>
