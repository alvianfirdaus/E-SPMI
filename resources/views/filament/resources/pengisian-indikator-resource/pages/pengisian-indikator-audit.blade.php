{{-- resources/views/filament/resources/pengisian-indikator-resource/pages/pengisian-indikator-audit.blade.php --}}
<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Page Header --}}
        <div
            class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-6">
            <div class="flex items-center justify-between">
                <div>
                    <h1
                        class="fi-section-header-heading text-base font-semibold leading-6 text-gray-950 dark:text-white">
                        {{ $this->getTitle() }}
                    </h1>
                    <p class="fi-section-header-description text-sm text-gray-500 dark:text-gray-400">
                        Isi audit untuk periode {{ $assignment->periode->periode_name ?? '-' }}
                    </p>
                </div>
                <div class="text-right">
                    <div class="text-sm text-gray-500 dark:text-gray-400">
                        Status:
                        <span
                            class="fi-badge inline-flex items-center justify-center gap-x-1 rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset
                            @if ($assignment->status_pengisian === 'pending') fi-color-warning bg-warning-50 text-warning-600 ring-warning-600/10 dark:bg-warning-400/10 dark:text-warning-400 dark:ring-warning-400/30
                            @elseif($assignment->status_pengisian === 'selesai') fi-color-success bg-success-50 text-success-600 ring-success-600/10 dark:bg-success-400/10 dark:text-success-400 dark:ring-success-400/30
                            @else fi-color-gray bg-gray-50 text-gray-600 ring-gray-600/10 dark:bg-gray-400/10 dark:text-gray-400 dark:ring-gray-400/30 @endif">
                            {{ ucfirst(str_replace('_', ' ', $assignment->status_pengisian)) }}
                        </span>
                    </div>

                </div>
            </div>
        </div>

        {{-- Progress Bar --}}
        @php
            $totalItems = 0;
            $filledItems = 0;

            foreach ($assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
                foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                    $totalItems += $unitIndikator->unitIndikatorIsiIndikators->count();
                }
            }

            $filledItems = $assignment->pengisianIndikators->count();
            $progressPercentage = $totalItems > 0 ? round(($filledItems / $totalItems) * 100, 1) : 0;
        @endphp

        <div
            class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-4">
            <div class="flex items-center justify-between mb-2">
                <span class="text-sm font-medium text-gray-950 dark:text-white">Progress Pengisian</span>
                <span class="text-sm text-gray-500 dark:text-gray-400">{{ $filledItems }}/{{ $totalItems }}
                    item</span>
            </div>
            <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2.5">
                <div class="fi-color-primary bg-primary-600 h-2.5 rounded-full transition-all duration-300"
                    style="width: {{ $progressPercentage }}%"></div>
            </div>
            <div class="text-right mt-1">
                <span class="text-xs text-gray-500 dark:text-gray-400">{{ $progressPercentage }}% selesai</span>
            </div>
        </div>

        {{-- Auditor Information --}}
        @if ($assignment->assignAuditors)
            <div
                class="fi-section-content-ctn bg-info-50 dark:bg-info-950 border border-info-200 dark:border-info-800 rounded-xl p-4">
                <h3 class="text-sm font-medium text-info-800 dark:text-info-200 mb-2">Tim Auditor</h3>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    @if ($assignment->unitIndikator->auditeeUser)
                        <div class="flex items-center space-x-2">
                            <div
                                class="w-8 h-8 bg-info-100 dark:bg-info-800 rounded-full flex items-center justify-center">
                                <span class="text-xs font-medium text-info-600 dark:text-info-300">A</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-info-900 dark:text-info-100">
                                    {{ $assignment->unitIndikator->auditeeUser->name }}
                                </p>
                                <p class="text-xs text-info-600 dark:text-info-400">Auditee</p>
                            </div>
                        </div>
                    @endif
                    @if ($assignment->assignAuditors->auditor1Relation)
                        <div class="flex items-center space-x-2">
                            <div
                                class="w-8 h-8 bg-info-100 dark:bg-info-800 rounded-full flex items-center justify-center">
                                <span class="text-xs font-medium text-info-600 dark:text-info-300">A1</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-info-900 dark:text-info-100">
                                    {{ $assignment->assignAuditors->auditor1Relation->name }}
                                </p>
                                <p class="text-xs text-info-600 dark:text-info-400">Auditor 1</p>
                            </div>
                        </div>
                    @endif

                    @if ($assignment->assignAuditors->auditor2Relation)
                        <div class="flex items-center space-x-2">
                            <div
                                class="w-8 h-8 bg-info-100 dark:bg-info-800 rounded-full flex items-center justify-center">
                                <span class="text-xs font-medium text-info-600 dark:text-info-300">A2</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-info-900 dark:text-info-100">
                                    {{ $assignment->assignAuditors->auditor2Relation->name }}
                                </p>
                                <p class="text-xs text-info-600 dark:text-info-400">Auditor 2</p>
                            </div>
                        </div>
                    @endif
                </div>

            </div>
        @endif

        {{-- Main Form --}}
        <div
            class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl">
            <form wire:submit="save" class="space-y-6">
                {{ $this->form }}

                {{-- Form Actions --}}
                <div
                    class="flex items-center justify-between p-6 bg-gray-50 dark:bg-white/5 rounded-b-xl border-t border-gray-200 dark:border-white/10">
                    <div class="flex space-x-4">
                        <x-filament::button tag="a" :href="App\Filament\Resources\PengisianIndikatorResource::getUrl('index')" color="gray" outlined>
                            Batal
                        </x-filament::button>
                    </div>
                    <div>

                                                <x-filament::button type="submit" wire:click="save" color="primary">
                            Simpan Audit
                        </x-filament::button>
                    </div>
                </div>
            </form>
        </div>

        {{-- Help Section --}}
        <div class="fi-section-content-ctn bg-gray-50 dark:bg-white/5 rounded-xl p-6">
            <h3 class="text-base font-semibold leading-6 text-gray-950 dark:text-white mb-4">Panduan Pengisian</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Skor</h4>
                    <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                        <li>• Masukkan skor 0-100%</li>
                        <li>• Skor di bawah 60% memerlukan komentar wajib</li>
                        <li>• Skor mencerminkan tingkat pencapaian target</li>
                    </ul>
                </div>
                <div>
                    <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Bukti</h4>
                    <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                        <li>• Lampirkan link dokumentasi pendukung</li>
                        <li>• Pastikan link dapat diakses oleh auditor</li>
                        <li>• Gunakan format URL yang valid</li>
                    </ul>
                </div>
                <div>
                    <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Komentar</h4>
                    <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                        <li>• Berikan penjelasan untuk skor rendah</li>
                        <li>• Tambahkan catatan penting jika ada</li>
                        <li>• Jelaskan faktor penghambat yang ditemui</li>
                    </ul>
                </div>
                <div>
                    <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Draft vs Submit</h4>
                    <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                        <li>• Draft: Dapat diedit kembali</li>
                        <li>• Submit: Mengirim untuk review</li>
                        <li>• Data tersimpan otomatis saat mengisi</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    {{-- Custom Styles --}}
    <style>
        /* Repeater item styling using Filament classes */
        .fi-fo-repeater-item {
            @apply ring-1 ring-gray-950/5 dark:ring-white/10 rounded-xl mb-4;
        }

        .fi-fo-repeater-item-header {
            @apply bg-gray-50 dark:bg-white/5 px-4 py-3 rounded-t-xl border-b border-gray-200 dark:border-white/10;
        }

        .fi-fo-repeater-item-content {
            @apply p-4;
        }

        /* Display info styling */
        .audit-info-section {
            @apply bg-gray-50 dark:bg-white/5 p-4 rounded-lg mb-4 ring-1 ring-gray-950/5 dark:ring-white/10;
        }

        .audit-info-section .fi-fo-placeholder {
            @apply mb-2;
        }

        .audit-info-section .fi-fo-placeholder-content {
            @apply text-sm text-gray-500 dark:text-gray-400;
        }

        /* Input validation styles using Filament classes */
        .fi-input-wrp input:invalid,
        .fi-textarea-wrp textarea:invalid {
            @apply ring-danger-600 dark:ring-danger-500 border-danger-600 dark:border-danger-500;
        }

        /* Skor input specific styling */
        input[name*="skor"] {
            @apply font-medium;
        }

        input[name*="skor"]:focus {
            @apply ring-primary-600 dark:ring-primary-500;
        }

        /* Link input styling */
        input[name*="link"] {
            @apply text-primary-600 dark:text-primary-400;
        }

        /* Komentar textarea styling */
        textarea[name*="komentar"] {
            @apply resize-vertical;
        }

        /* Required field indicator */
        .fi-fo-field-wrp-required .fi-fo-field-wrp-label::after {
            content: ' *';
            @apply text-danger-500 dark:text-danger-400;
        }

        /* Progress bar custom styling */
        .progress-bar {
            transition: width 0.3s ease-in-out;
        }

        /* Enhanced focus states */
        .fi-input:focus-within {
            @apply ring-2 ring-primary-600 dark:ring-primary-500;
        }

        /* Custom badge styling for consistency */
        .fi-badge {
            @apply inline-flex items-center justify-center gap-x-1 rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset;
        }
    </style>

    {{-- JavaScript for enhanced UX --}}
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Progress tracking

            // Listen for input changes
            document.addEventListener('input', function(e) {
                // Update progress when skor is filled
                if (e.target.name && e.target.name.includes('skor')) {
                    updateProgress();

                    // Skor validation
                    const value = parseInt(e.target.value);
                    if (value < 60) {
                        // Find corresponding komentar field in the same repeater item
                        const repeaterItem = e.target.closest('.fi-fo-repeater-item');
                        const komentarField = repeaterItem?.querySelector('textarea[name*="komentar"]');

                        if (komentarField) {
                            komentarField.required = true;
                            komentarField.classList.add('ring-danger-600', 'dark:ring-danger-500',
                                'border-danger-600', 'dark:border-danger-500');
                            komentarField.placeholder = 'Komentar wajib untuk skor < 60%';

                            // Add visual indicator
                            const fieldWrapper = komentarField.closest('.fi-fo-field-wrp');
                            fieldWrapper?.classList.add('fi-fo-field-wrp-required');
                        }
                    } else {
                        // Remove validation styling if score >= 60
                        const repeaterItem = e.target.closest('.fi-fo-repeater-item');
                        const komentarField = repeaterItem?.querySelector('textarea[name*="komentar"]');

                        if (komentarField) {
                            komentarField.required = false;
                            komentarField.classList.remove('ring-danger-600', 'dark:ring-danger-500',
                                'border-danger-600', 'dark:border-danger-500');
                            komentarField.placeholder = 'Komentar atau catatan...';

                            const fieldWrapper = komentarField.closest('.fi-fo-field-wrp');
                            fieldWrapper?.classList.remove('fi-fo-field-wrp-required');
                        }
                    }
                }
            });

            // Auto-resize textareas
            document.addEventListener('input', function(e) {
                if (e.target.tagName === 'TEXTAREA') {
                    e.target.style.height = 'auto';
                    e.target.style.height = (e.target.scrollHeight) + 'px';
                }
            });

            // Auto-save functionality (optional)
            let saveTimeout;
            document.addEventListener('input', function(e) {
                if (e.target.name && (e.target.name.includes('skor') || e.target.name.includes('link') || e
                        .target.name.includes('komentar'))) {
                    clearTimeout(saveTimeout);
                    saveTimeout = setTimeout(() => {
                        console.log('Auto-saving...');
                    }, 3000);
                }
            });
        });
        // Expand all repeater items function (optional)
        function expandAllItems() {
            document.querySelectorAll('.fi-fo-repeater-item-header button').forEach(button => {
                if (button.getAttribute('aria-expanded') === 'false') {
                    button.click();
                }
            });
        }

        // Collapse all repeater items function (optional)
        function collapseAllItems() {
            document.querySelectorAll('.fi-fo-repeater-item-header button').forEach(button => {
                if (button.getAttribute('aria-expanded') === 'true') {
                    button.click();
                }
            });
        }
    </script>
</x-filament-panels::page>
