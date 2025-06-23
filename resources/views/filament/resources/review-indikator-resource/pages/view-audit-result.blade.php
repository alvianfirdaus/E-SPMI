<x-filament-panels::page>
    <div class="space-y-6">
        <x-filament::section>
            <x-slot name="heading">
                {{ $this->getTitle() }}
            </x-slot>
            <x-slot name="description">
                Hasil audit untuk periode {{ $assignment->periode->periode_name ?? '-' }}
            </x-slot>
            <x-slot name="headerEnd">
                <x-filament::badge :color="$auditStatus === 'close' ? 'success' : 'warning'">
                    {{ $auditStatus === 'close' ? 'Close' : 'Open' }}
                </x-filament::badge>
            </x-slot>

            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <div class="bg-white dark:bg-gray-900 rounded-lg border border-gray-200 dark:border-gray-700 p-4">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div
                                class="w-8 h-8 bg-blue-100 dark:bg-blue-900 rounded-full flex items-center justify-center">
                                <x-heroicon-s-calendar class="w-4 h-4 text-blue-600 dark:text-blue-300" />
                            </div>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-900 dark:text-white">Tanggal Mulai</p>
                            <p class="text-lg font-semibold text-blue-600 dark:text-blue-300">
                                @if ($assignment->start_date)
                                    @if (is_string($assignment->start_date))
                                        {{ \Carbon\Carbon::parse($assignment->start_date)->format('d/m/Y H:i') }}
                                    @else
                                        {{ $assignment->start_date->format('d/m/Y H:i') }}
                                    @endif
                                @else
                                    -
                                @endif
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-white dark:bg-gray-900 rounded-lg border border-gray-200 dark:border-gray-700 p-4">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div
                                class="w-8 h-8 bg-green-100 dark:bg-green-900 rounded-full flex items-center justify-center">
                                <x-heroicon-s-calendar class="w-4 h-4 text-green-600 dark:text-green-300" />
                            </div>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-900 dark:text-white">Tanggal Selesai</p>
                            <p class="text-lg font-semibold text-green-600 dark:text-green-300">
                                @if ($assignment->end_date)
                                    @if (is_string($assignment->end_date))
                                        {{ \Carbon\Carbon::parse($assignment->end_date)->format('d/m/Y H:i') }}
                                    @else
                                        {{ $assignment->end_date->format('d/m/Y H:i') }}
                                    @endif
                                @else
                                    -
                                @endif
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-white dark:bg-gray-900 rounded-lg border border-gray-200 dark:border-gray-700 p-4">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div
                                class="w-8 h-8 bg-yellow-100 dark:bg-yellow-900 rounded-full flex items-center justify-center">
                                <x-heroicon-s-exclamation-triangle
                                    class="w-4 h-4 text-yellow-600 dark:text-yellow-300" />
                            </div>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-900 dark:text-white">Total Konflik</p>
                            <p class="text-lg font-semibold text-yellow-600 dark:text-yellow-300">
                                {{ $auditor1vs2Analysis['total_conflicts'] ?? 0 }}
                            </p>
                        </div>
                    </div>
                </div>

                <div class="bg-white dark:bg-gray-900 rounded-lg border border-gray-200 dark:border-gray-700 p-4">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <div
                                class="w-8 h-8 bg-purple-100 dark:bg-purple-900 rounded-full flex items-center justify-center">
                                <x-heroicon-s-chart-bar class="w-4 h-4 text-purple-600 dark:text-purple-300" />
                            </div>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium text-gray-900 dark:text-white">Agreement Rate</p>
                            <p class="text-lg font-semibold text-purple-600 dark:text-purple-300">
                                {{ $auditor1vs2Analysis['agreement_rate'] ?? 0 }}%
                            </p>
                        </div>
                    </div>
                </div>
            </div>

        </x-filament::section>
        @if ($assignment->assignAuditors)
            <x-filament::section :collapsible="true" :collapsed="true">
                <x-slot name="heading">
                    Tim Audit
                </x-slot>

                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                    @if ($assignment->unitIndikator->auditeeUser)
                        <div class="flex items-center gap-3 p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div
                                class="w-10 h-10 bg-info-100 dark:bg-info-900 rounded-full flex items-center justify-center">
                                <span class="text-sm font-medium text-info-600 dark:text-info-300">A</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-gray-900 dark:text-white">
                                    {{ $assignment->unitIndikator->auditeeUser->name }}
                                </p>
                                <p class="text-xs text-gray-500 dark:text-gray-400">Auditee</p>
                                @if ($auditeeAnalysis['first_filled_at'])
                                    <p class="text-xs text-gray-500 dark:text-gray-400">
                                        Mulai: {{ $auditeeAnalysis['first_filled_at'] }}
                                    </p>
                                @endif
                                @if ($auditeeAnalysis['last_updated_at'])
                                    <p class="text-xs text-gray-500 dark:text-gray-400">
                                        Update: {{ $auditeeAnalysis['last_updated_at'] }}
                                    </p>
                                @endif
                            </div>
                        </div>
                    @endif

                    @if ($assignment->assignAuditors->auditor1Relation)
                        <div class="flex items-center gap-3 p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div
                                class="w-10 h-10 bg-primary-100 dark:bg-primary-900 rounded-full flex items-center justify-center">
                                <span class="text-sm font-medium text-primary-600 dark:text-primary-300">A1</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-gray-900 dark:text-white">
                                    {{ $assignment->assignAuditors->auditor1Relation->name }}
                                </p>
                                <p class="text-xs text-gray-500 dark:text-gray-400">Auditor 1</p>
                                @if ($auditor1Analysis['first_reviewed_at'])
                                    <p class="text-xs text-gray-500 dark:text-gray-400">
                                        Mulai: {{ $auditor1Analysis['first_reviewed_at'] }}
                                    </p>
                                @endif
                                @if ($auditor1Analysis['last_reviewed_at'])
                                    <p class="text-xs text-gray-500 dark:text-gray-400">
                                        Update: {{ $auditor1Analysis['last_reviewed_at'] }}
                                    </p>
                                @endif
                            </div>
                        </div>
                    @endif

                    @if ($assignment->assignAuditors->auditor2Relation)
                        <div class="flex items-center gap-3 p-3 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div
                                class="w-10 h-10 bg-success-100 dark:bg-success-900 rounded-full flex items-center justify-center">
                                <span class="text-sm font-medium text-success-600 dark:text-success-300">A2</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-gray-900 dark:text-white">
                                    {{ $assignment->assignAuditors->auditor2Relation->name }}
                                </p>
                                <p class="text-xs text-gray-500 dark:text-gray-400">Auditor 2</p>
                                @if ($auditor2Analysis['first_reviewed_at'])
                                    <p class="text-xs text-gray-500 dark:text-gray-400">
                                        Mulai: {{ $auditor2Analysis['first_reviewed_at'] }}
                                    </p>
                                @endif
                                @if ($auditor2Analysis['last_reviewed_at'])
                                    <p class="text-xs text-gray-500 dark:text-gray-400">
                                        Update: {{ $auditor2Analysis['last_reviewed_at'] }}
                                    </p>
                                @endif
                            </div>
                        </div>
                    @endif
                </div>
            </x-filament::section>
        @endif
        <x-filament::section>
            <div class="border-b border-gray-200 dark:border-gray-700">
                {{-- Desktop Navigation --}}
                <nav class="hidden lg:flex -mb-px flex-wrap space-x-8" aria-label="Tabs">
                    <button wire:click="setActiveTab('overview')"
                        class="@if ($activeTab === 'overview') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center gap-2">
                            <x-heroicon-o-document-text class="w-5 h-5" />
                            Hasil Audit
                        </div>
                    </button>
                    <button wire:click="setActiveTab('auditee')"
                        class="@if ($activeTab === 'auditee') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center gap-2">
                            <x-heroicon-o-user class="w-5 h-5" />
                            Auditee
                        </div>
                    </button>

                    <button wire:click="setActiveTab('auditor1')"
                        class="@if ($activeTab === 'auditor1') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center gap-2">
                            <x-heroicon-o-shield-check class="w-5 h-5" />
                            Auditor 1
                        </div>
                    </button>

                    <button wire:click="setActiveTab('auditor2')"
                        class="@if ($activeTab === 'auditor2') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center gap-2">
                            <x-heroicon-o-shield-check class="w-5 h-5" />
                            Auditor 2
                        </div>
                    </button>

                    <button wire:click="setActiveTab('overall')"
                        class="@if ($activeTab === 'overall') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center gap-2">
                            <x-heroicon-o-chart-pie class="w-5 h-5" />
                            Overall (Auditee vs Auditor)
                        </div>
                    </button>

                    <button wire:click="setActiveTab('achievement')"
                        class="@if ($activeTab === 'achievement') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center gap-2">
                            <x-heroicon-o-chart-pie class="w-5 h-5" />
                            Analisis Ketercapaian Standar
                        </div>
                    </button>

                    <button wire:click="setActiveTab('auditor_comparison')"
                        class="@if ($activeTab === 'auditor_comparison') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center gap-2">
                            <x-heroicon-o-chart-pie class="w-5 h-5" />
                            Overall (Auditor 1 vs Auditor 2)
                        </div>
                    </button>
                </nav>

                <div class="lg:hidden">
                    <div class="relative">
                        <button id="tab-dropdown-button"
                            class="w-full flex items-center justify-between px-4 py-2 text-sm font-medium text-gray-700 dark:text-gray-300 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm hover:bg-gray-50 dark:hover:bg-gray-700 focus:outline-none focus:ring-2 focus:ring-primary-500"
                            onclick="toggleTabDropdown()">
                            <span class="flex items-center gap-2">
                                @if ($activeTab === 'overview')
                                    <x-heroicon-o-document-text class="w-5 h-5" />
                                    Hasil Audit
                                @elseif ($activeTab === 'auditee')
                                    <x-heroicon-o-user class="w-5 h-5" />
                                    Auditee
                                @elseif ($activeTab === 'auditor1')
                                    <x-heroicon-o-shield-check class="w-5 h-5" />
                                    Auditor 1
                                @elseif ($activeTab === 'auditor2')
                                    <x-heroicon-o-shield-check class="w-5 h-5" />
                                    Auditor 2
                                @elseif ($activeTab === 'achievement')
                                    <x-heroicon-o-shield-check class="w-5 h-5" />
                                    Auditor 2
                                @elseif($activeTab === 'overall')
                                    <x-heroicon-o-chart-pie class="w-5 h-5" />
                                    Overall (Auditee vs Auditor)
                                @else
                                    <x-heroicon-o-chart-pie class="w-5 h-5" />
                                    Overall (Auditor 1 vs Auditor 2)
                                @endif
                            </span>
                            <x-heroicon-o-chevron-down class="w-5 h-5" />
                        </button>

                        <div id="tab-dropdown-menu"
                            class="hidden absolute z-10 mt-1 w-full bg-white dark:bg-gray-800 shadow-lg rounded-md border border-gray-200 dark:border-gray-700">
                            <div class="py-1">
                                <button wire:click="setActiveTab('auditee')" onclick="closeTabDropdown()"
                                    class="@if ($activeTab === 'auditee') bg-primary-50 text-primary-700 dark:bg-primary-900 dark:text-primary-300 @else text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 @endif w-full text-left px-4 py-2 text-sm flex items-center gap-2">
                                    <x-heroicon-o-user class="w-4 h-4" />
                                    Auditee
                                </button>

                                <button wire:click="setActiveTab('auditor1')" onclick="closeTabDropdown()"
                                    class="@if ($activeTab === 'auditor1') bg-primary-50 text-primary-700 dark:bg-primary-900 dark:text-primary-300 @else text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 @endif w-full text-left px-4 py-2 text-sm flex items-center gap-2">
                                    <x-heroicon-o-shield-check class="w-4 h-4" />
                                    Auditor 1
                                </button>

                                <button wire:click="setActiveTab('auditor2')" onclick="closeTabDropdown()"
                                    class="@if ($activeTab === 'auditor2') bg-primary-50 text-primary-700 dark:bg-primary-900 dark:text-primary-300 @else text-gray-700 dark:text-gray-300 hover:bg-gray-50 dark:hover:bg-gray-700 @endif w-full text-left px-4 py-2 text-sm flex items-center gap-2">
                                    <x-heroicon-o-shield-check class="w-4 h-4" />
                                    Auditor 2
                                </button>

                                <button wire:click="setActiveTab('achievement')"
                                    class="@if ($activeTab === 'achievement') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                                    <div class="flex items-center gap-2">
                                        <x-heroicon-o-chart-bar-square class="w-5 h-5" />
                                        Analisis Ketercapaian
                                    </div>
                                </button>

                                <button wire:click="setActiveTab('overall')"
                                    class="@if ($activeTab === 'overall') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                                    <div class="flex items-center gap-2">
                                        <x-heroicon-o-chart-pie class="w-5 h-5" />
                                        Auditee vs Auditor 1
                                    </div>
                                </button>

                                <button wire:click="setActiveTab('auditor_comparison')"
                                    class="@if ($activeTab === 'auditor_comparison') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-2 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                                    <div class="flex items-center gap-2">
                                        <x-heroicon-o-arrows-right-left class="w-5 h-5" />
                                        Auditor 1 vs Auditor 2
                                    </div>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </x-filament::section>

        {{-- Tab Content --}}
        @if ($activeTab === 'overview')
            {{-- Detail Hasil Tab --}}
            @foreach ($this->getViewItems() as $standarGroup)
                <x-filament::section :collapsible="true" :collapsed="false">
                    <x-slot name="heading">
                        [{{ $standarGroup['standar_code'] }}] {{ $standarGroup['standar_name'] }}
                    </x-slot>
                    <x-slot name="description">
                        {{ $standarGroup['standar_description'] }}
                    </x-slot>

                    @foreach ($standarGroup['sub_standars'] as $subStandar)
                        <x-filament::section :collapsible="true" :collapsed="true" class="mt-4">
                            <x-slot name="heading">
                                {{ $subStandar['sub_standar_name'] }}
                            </x-slot>
                            <div class="space-y-4">
                                @foreach ($subStandar['isi_indikators'] as $item)
                                    <x-filament::section :collapsible="true" :collapsed="true" :class="$item['has_conflict']
                                        ? 'border-l-4 border-l-warning-500 bg-warning-50 dark:bg-warning-900/20'
                                        : ''">
                                        
<x-slot name="heading">
    <div class="flex items-center gap-2">
        {{ $loop->iteration }}. {{ Str::limit(strip_tags($item['isi_indikator'] ?? 'Belum diisi'), 100) }}
        @if ($item['has_conflict'])
            <x-filament::badge color="warning" icon="heroicon-s-exclamation-triangle">
                Konflik
            </x-filament::badge>
        @endif
        <x-filament::badge :color="$item['pengisian_isi'] === 'tercapai' ? 'success' : ($item['pengisian_isi'] === 'tidak_tercapai' ? 'danger' : 'gray')">
            {{ ucfirst(str_replace('_', ' ', $item['pengisian_isi'] ?? 'Belum diisi')) }}
        </x-filament::badge>
    </div>
</x-slot>
                                        <div class="mb-4">
                                            <h4 class="text-sm font-medium text-gray-900 dark:text-white mb-2">Isi
                                                Indikator:</h4>
                                            <div
                                                class="p-4 bg-gray-50 dark:bg-gray-800 rounded-lg text-sm text-gray-700 dark:text-gray-300">
                                                @php
                                                    $content = $item['isi_indikator'] ?? '-';
                                                    if (strip_tags($content) !== $content) {
                                                        $content = str_replace(
                                                            '<ul>',
                                                            '<ul style="list-style-type: disc; padding-left: 1rem;">',
                                                            $content,
                                                        );
                                                        $content = str_replace(
                                                            '<ol>',
                                                            '<ol style="list-style-type: decimal; padding-left: 1rem;">',
                                                            $content,
                                                        );
                                                        $content = str_replace(
                                                            '<li>',
                                                            '<li style="margin-bottom: 4px;">',
                                                            $content,
                                                        );

                                                        echo new \Illuminate\Support\HtmlString($content);
                                                    } else {
                                                        echo new \Illuminate\Support\HtmlString(nl2br(e($content)));
                                                    }
                                                @endphp
                                            </div>
                                        </div>
                                        <x-slot name="description">
                                            Target: {{ $item['target'] ?? '-' }}
                                        </x-slot>

                                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-4">
                                            <div class="md:col-span-2">
                                                <h5 class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                    Pertanyaan
                                                </h5>
                                                <div
                                                    class="text-sm text-gray-700 dark:text-gray-300 bg-blue-50 dark:bg-blue-900/20 p-2 rounded">
                                                    {{ $item['pertanyaan'] ?: '-' }}
                                                </div>
                                            </div>

                                            <div class="md:col-span-1">
                                                <h5 class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                    Target
                                                </h5>
                                                <div
                                                    class="text-sm text-gray-700 dark:text-gray-300 bg-green-50 dark:bg-green-900/20 p-2 rounded">
                                                    {{ $item['target'] ?: '-' }}
                                                </div>
                                            </div>

                                            <div class="md:col-span-1">
                                                <h5 class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                    Bukti (Template)
                                                </h5>
                                                <div
                                                    class="text-sm text-gray-700 dark:text-gray-300 bg-purple-50 dark:bg-purple-900/20 p-2 rounded">
                                                    @if ($item['bukti'])
                                                        <a href="{{ str_starts_with($item['bukti'], 'http') ? $item['bukti'] : 'http://' . $item['bukti'] }}"
                                                            target="_blank"
                                                            class="text-purple-600 hover:text-purple-800 dark:text-purple-400 dark:hover:text-purple-300 underline">
                                                            {{ $item['bukti'] }} ↗
                                                        </a>
                                                    @else
                                                        -
                                                    @endif
                                                </div>
                                            </div>
                                        </div>

                                        <x-filament::section :collapsible="true" :collapsed="false" class="mb-4">
                                            <x-slot name="heading">
                                                Data Pengisian Auditee
                                            </x-slot>

                                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                                <div class="md:col-span-2">
                                                    <h5
                                                        class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                        Bukti Pengisian
                                                    </h5>
                                                    @if ($item['pengisian_bukti'])
                                                        <a href="{{ str_starts_with($item['pengisian_bukti'], 'http') ? $item['pengisian_bukti'] : 'http://' . $item['pengisian_bukti'] }}"
                                                            target="_blank"
                                                            class="text-primary-600 hover:text-primary-800 dark:text-primary-400 dark:hover:text-primary-300 underline text-sm break-all">
                                                            {{ $item['pengisian_bukti'] }} ↗
                                                        </a>
                                                    @else
                                                        <span class="text-sm text-gray-500 dark:text-gray-400">-</span>
                                                    @endif
                                                </div>

                                                <div>
                                                    <h5
                                                        class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-2">
                                                        Status
                                                    </h5>
                                                    <x-filament::badge :color="$item['pengisian_isi'] === 'tercapai' ? 'success' : ($item['pengisian_isi'] === 'tidak_tercapai' ? 'danger' : 'gray')">
                                                        {{ ucfirst(str_replace('_', ' ', $item['pengisian_isi'] ?? 'Belum diisi')) }}
                                                    </x-filament::badge>
                                                </div>
                                            </div>
                                            @if ($item['pengisian_faktor_penghambat'])
                                                <div class="mt-3">
                                                    <h5
                                                        class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                        Faktor Penghambat</h5>
                                                    <div
                                                        class="text-sm text-gray-700 dark:text-gray-300 bg-gray-50 dark:bg-gray-800 p-3 rounded">
                                                        {{ $item['pengisian_faktor_penghambat'] }}
                                                    </div>
                                                </div>
                                            @endif
                                        </x-filament::section>

                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <x-filament::section :collapsible="true" :collapsed="false">
                                                <x-slot name="heading">
                                                    <div class="flex items-center gap-2">
                                                        <x-heroicon-o-user class="w-4 h-4 text-primary-600" />
                                                        Review Auditor 1
                                                    </div>
                                                </x-slot>

                                                @if ($item['auditor1_status'] === 'reviewed')
                                                    <div class="space-y-3">
                                                        <div>
                                                            <h6
                                                                class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                                Temuan</h6>
                                                            <x-filament::badge :color="$item['auditor1_status_temuan'] === 'sesuai' ? 'success' : 'danger'">
                                                                {{ ucfirst(str_replace('_', ' ', $item['auditor1_status_temuan'])) }}
                                                            </x-filament::badge>
                                                        </div>
                                                        @if ($item['auditor1_hasil_pengamatan'])
                                                            <div>
                                                                <h6
                                                                    class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                                    Hasil Pengamatan</h6>
                                                                <div
                                                                    class="text-sm text-gray-700 dark:text-gray-300 bg-gray-50 dark:bg-gray-800 p-3 rounded">
                                                                    {{ $item['auditor1_hasil_pengamatan'] }}
                                                                </div>
                                                            </div>
                                                        @endif
                                                        <div class="text-xs text-gray-500 dark:text-gray-400">
                                                            Direview:
                                                            {{ $item['auditor1_reviewed_at'] ? $item['auditor1_reviewed_at']->format('d/m/Y H:i') : '-' }}
                                                        </div>
                                                    </div>
                                                @else
                                                    <div class="text-center py-4">
                                                        <x-filament::badge color="gray">
                                                            Belum direview
                                                        </x-filament::badge>
                                                    </div>
                                                @endif
                                            </x-filament::section>

                                            {{-- Auditor 2 Review --}}
                                            <x-filament::section :collapsible="true" :collapsed="false">
                                                <x-slot name="heading">
                                                    <div class="flex items-center gap-2">
                                                        <x-heroicon-o-user class="w-4 h-4 text-success-600" />
                                                        Review Auditor 2
                                                    </div>
                                                </x-slot>

                                                @if ($item['auditor2_status'] === 'reviewed')
                                                    <div class="space-y-3">
                                                        <div>
                                                            <h6
                                                                class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                                Temuan</h6>
                                                            <x-filament::badge :color="$item['auditor2_status_temuan'] === 'sesuai' ? 'success' : 'danger'">
                                                                {{ ucfirst(str_replace('_', ' ', $item['auditor2_status_temuan'])) }}
                                                            </x-filament::badge>
                                                        </div>
                                                        @if ($item['auditor2_hasil_pengamatan'])
                                                            <div>
                                                                <h6
                                                                    class="text-xs font-medium text-gray-500 dark:text-gray-400 mb-1">
                                                                    Hasil Pengamatan</h6>
                                                                <div
                                                                    class="text-sm text-gray-700 dark:text-gray-300 bg-gray-50 dark:bg-gray-800 p-3 rounded">
                                                                    {{ $item['auditor2_hasil_pengamatan'] }}
                                                                </div>
                                                            </div>
                                                        @endif
                                                        <div class="text-xs text-gray-500 dark:text-gray-400">
                                                            Direview:
                                                            {{ $item['auditor2_reviewed_at'] ? $item['auditor2_reviewed_at']->format('d/m/Y H:i') : '-' }}
                                                        </div>
                                                    </div>
                                                @else
                                                    <div class="text-center py-4">
                                                        <x-filament::badge color="gray">
                                                            Belum direview
                                                        </x-filament::badge>
                                                    </div>
                                                @endif
                                            </x-filament::section>
                                        </div>
                                    </x-filament::section>
                                @endforeach
                            </div>
                        </x-filament::section>
                    @endforeach
                </x-filament::section>
            @endforeach
        @elseif ($activeTab === 'auditee')
            {{-- Auditee Tab --}}
            <div class="space-y-6">
                {{-- Completion Status --}}
                <x-filament::section>
                    <x-slot name="heading">Status Pengisian Auditee</x-slot>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div class="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-blue-900 dark:text-blue-100">Status</h4>
                            <p class="text-lg font-semibold text-blue-700 dark:text-blue-300">
                                {{ $auditeeAnalysis['filled_items'] ?? 0 }}/{{ $auditeeAnalysis['total_items'] ?? 0 }}
                                Item Diisi
                            </p>
                        </div>
                        <div class="bg-green-50 dark:bg-green-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-green-900 dark:text-green-100">Tanggal Mulai</h4>
                            <p class="text-sm text-green-700 dark:text-green-300">
                                {{-- {{ $auditeeAnalysis['first_filled_at'] ?? '-' }} --}}
                                @if ($auditeeAnalysis['first_filled_at'])
                                    {{-- @if (is_string($auditeeAnalysis['first_filled_at']))
                                        {{ \Carbon\Carbon::parse($auditeeAnalysis['first_filled_at'])->format('d/m/Y H:i') }}
                                    @else
                                        {{ $auditeeAnalysis['first_filled_at']->format('d/m/Y H:i') }}
                                    @endif --}}
                                @else
                                    -
                                @endif

                            </p>
                        </div>
                        <div class="bg-purple-50 dark:bg-purple-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-purple-900 dark:text-purple-100">Terakhir Update</h4>
                            <p class="text-sm text-purple-700 dark:text-purple-300">
                                {{-- {{ $auditeeAnalysis['last_updated_at'] ?? '-' }} --}}
                            </p>
                        </div>
                    </div>
                </x-filament::section>

                {{-- Summary Statistics --}}
                <x-filament::section>
                    <x-slot name="heading">Ringkasan Statistik</x-slot>
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div class="text-2xl font-bold text-gray-900 dark:text-white">
                                {{ $auditeeAnalysis['total_items'] ?? 0 }}</div>
                            <div class="text-sm text-gray-600 dark:text-gray-400">Total Item</div>
                        </div>
                        <div class="text-center p-4 bg-success-50 dark:bg-success-900/20 rounded-lg">
                            <div class="text-2xl font-bold text-success-600 dark:text-success-400">
                                {{ $auditeeAnalysis['tercapai'] ?? 0 }}</div>
                            <div class="text-sm text-success-600 dark:text-success-400">Tercapai
                                ({{ $auditeeAnalysis['percentage_tercapai'] ?? 0 }}%)</div>
                        </div>
                        <div class="text-center p-4 bg-danger-50 dark:bg-danger-900/20 rounded-lg">
                            <div class="text-2xl font-bold text-danger-600 dark:text-danger-400">
                                {{ $auditeeAnalysis['tidak_tercapai'] ?? 0 }}</div>
                            <div class="text-sm text-danger-600 dark:text-danger-400">Tidak Tercapai
                                ({{ $auditeeAnalysis['percentage_tidak_tercapai'] ?? 0 }}%)</div>
                        </div>
                        <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div class="text-2xl font-bold text-gray-600 dark:text-gray-400">
                                {{ $auditeeAnalysis['belum_diisi'] ?? 0 }}</div>
                            <div class="text-sm text-gray-600 dark:text-gray-400">Belum Diisi
                                ({{ $auditeeAnalysis['percentage_belum_diisi'] ?? 0 }}%)</div>
                        </div>
                    </div>
                </x-filament::section>

                {{-- Chart Section --}}
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <x-filament::section>
                        <x-slot name="heading">Distribusi Status</x-slot>
                        <div class="h-64 chart-container" data-chart="true">
                            <canvas id="auditeeOverviewChart" role="img" aria-label="Auditee Status Distribution"
                                data-chart-type="auditee-overview"></canvas>
                        </div>
                    </x-filament::section>

                    <x-filament::section>
                        <x-slot name="heading">Progress Pengisian</x-slot>
                        <div class="space-y-4">
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span
                                        class="text-sm font-medium text-gray-700 dark:text-gray-300">Kelengkapan</span>
                                    <span
                                        class="text-sm text-gray-500 dark:text-gray-400">{{ $auditeeAnalysis['percentage_completion'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3">
                                    <div class="bg-primary-600 h-3 rounded-full transition-all duration-300"
                                        style="width: {{ $auditeeAnalysis['percentage_completion'] ?? 0 }}%"></div>
                                </div>
                            </div>
                        </div>
                    </x-filament::section>
                </div>

                {{-- Standards Analysis --}}
                <x-filament::section>
                    <x-slot name="heading">Ketercapaian Berdasarkan Standar</x-slot>
                    <div class="mb-6">
                        <div class="h-96 chart-container" data-chart="true">
                            <canvas id="auditeeStandardChart" role="img" aria-label="Auditee Standards Chart"
                                data-chart-type="auditee-standard"></canvas>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kode</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tercapai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Tercapai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tidak Tercapai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Tidak Tercapai</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($auditeeAnalysis['standar_analysis'] ?? [] as $index => $standar)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">
                                            {{ $standar['standar_code'] }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $standar['standar_name'] }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $standar['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $standar['tercapai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $standar['percentage_tercapai'] }}%</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $standar['tidak_tercapai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $standar['percentage_tidak_tercapai'] }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>

                {{-- Sub Standards Analysis --}}
                <x-filament::section>
                    <x-slot name="heading">Ketercapaian Berdasarkan Sub Standar</x-slot>
                    <div class="mb-6">
                        <div class="h-96 chart-container" data-chart="true">
                            <canvas id="auditeeSubStandardChart" role="img"
                                aria-label="Auditee Sub Standards Chart"
                                data-chart-type="auditee-substandard"></canvas>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sub Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tercapai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Tercapai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tidak Tercapai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Tidak Tercapai</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($auditeeAnalysis['sub_standar_analysis'] ?? [] as $index => $subStandar)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['standar_code'] }} - {{ $subStandar['standar_name'] }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['sub_standar_name'] }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $subStandar['tercapai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $subStandar['percentage_tercapai'] }}%</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $subStandar['tidak_tercapai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $subStandar['percentage_tidak_tercapai'] }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>
            </div>
        @elseif($activeTab === 'auditor1')
            {{-- Auditor 1 Tab --}}
            <div class="space-y-6">
                {{-- Completion Status --}}
                <x-filament::section>
                    <x-slot name="heading">Status Review Auditor 1</x-slot>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div class="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-blue-900 dark:text-blue-100">Status</h4>
                            <p class="text-lg font-semibold text-blue-700 dark:text-blue-300">
                                {{ $auditor1Analysis['total_reviewed'] ?? 0 }}/{{ $auditor1Analysis['total_items'] ?? 0 }}
                                Item Direview
                            </p>
                        </div>
                        <div class="bg-green-50 dark:bg-green-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-green-900 dark:text-green-100">Tanggal Mulai</h4>
                            <p class="text-sm text-green-700 dark:text-green-300">
                                {{-- {{ $auditor1Analysis['first_reviewed_at'] ?? '-' }} --}}
                            </p>
                        </div>
                        <div class="bg-purple-50 dark:bg-purple-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-purple-900 dark:text-purple-100">Terakhir Update</h4>
                            <p class="text-sm text-purple-700 dark:text-purple-300">
                                {{-- {{ $auditor1Analysis['last_reviewed_at'] ?? '-' }} --}}
                            </p>
                        </div>
                    </div>
                </x-filament::section>

                {{-- Summary Statistics --}}
                <x-filament::section>
                    <x-slot name="heading">Ringkasan Statistik</x-slot>
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div class="text-2xl font-bold text-gray-900 dark:text-white">
                                {{ $auditor1Analysis['total_items'] ?? 0 }}</div>
                            <div class="text-sm text-gray-600 dark:text-gray-400">Total Item</div>
                        </div>
                        <div class="text-center p-4 bg-success-50 dark:bg-success-900/20 rounded-lg">
                            <div class="text-2xl font-bold text-success-600 dark:text-success-400">
                                {{ $auditor1Analysis['sesuai'] ?? 0 }}</div>
                            <div class="text-sm text-success-600 dark:text-success-400">Sesuai
                                ({{ $auditor1Analysis['percentage_sesuai'] ?? 0 }}%)</div>
                        </div>
                        <div class="text-center p-4 bg-danger-50 dark:bg-danger-900/20 rounded-lg">
                            <div class="text-2xl font-bold text-danger-600 dark:text-danger-400">
                                {{ $auditor1Analysis['tidak_sesuai'] ?? 0 }}</div>
                            <div class="text-sm text-danger-600 dark:text-danger-400">Tidak Sesuai
                                ({{ $auditor1Analysis['percentage_tidak_sesuai'] ?? 0 }}%)</div>
                        </div>
                        <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div class="text-2xl font-bold text-gray-600 dark:text-gray-400">
                                {{ $auditor1Analysis['belum_review'] ?? 0 }}</div>
                            <div class="text-sm text-gray-600 dark:text-gray-400">Belum Review
                                ({{ $auditor1Analysis['percentage_belum_review'] ?? 0 }}%)</div>
                        </div>
                    </div>
                </x-filament::section>

                {{-- Chart Section --}}
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <x-filament::section>
                        <x-slot name="heading">Distribusi Temuan</x-slot>
                        <div class="h-64 chart-container" data-chart="true">
                            <canvas id="auditor1OverviewChart" role="img"
                                aria-label="Auditor 1 Findings Distribution"
                                data-chart-type="auditor1-overview"></canvas>
                        </div>
                    </x-filament::section>

                    <x-filament::section>
                        <x-slot name="heading">Progress Review</x-slot>
                        <div class="space-y-4">
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span
                                        class="text-sm font-medium text-gray-700 dark:text-gray-300">Kelengkapan</span>
                                    <span
                                        class="text-sm text-gray-500 dark:text-gray-400">{{ $auditor1Analysis['percentage_complete'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3">
                                    <div class="bg-primary-600 h-3 rounded-full transition-all duration-300"
                                        style="width: {{ $auditor1Analysis['percentage_complete'] ?? 0 }}%"></div>
                                </div>
                            </div>
                        </div>
                    </x-filament::section>
                </div>

                {{-- Standards Analysis --}}
                <x-filament::section>
                    <x-slot name="heading">Review Berdasarkan Standar</x-slot>
                    <div class="mb-6">
                        <div class="h-96 chart-container" data-chart="true">
                            <canvas id="auditor1StandardChart" role="img" aria-label="Auditor 1 Standards Chart"
                                data-chart-type="auditor1-standard"></canvas>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kode</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tidak Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Tidak Sesuai</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($auditor1Analysis['standar_analysis'] ?? [] as $index => $standar)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">
                                            {{ $standar['standar_code'] }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $standar['standar_name'] }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $standar['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $standar['sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $standar['percentage_sesuai'] }}%</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $standar['tidak_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $standar['percentage_tidak_sesuai'] }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>

                {{-- Sub Standards Analysis --}}
                <x-filament::section>
                    <x-slot name="heading">Review Berdasarkan Sub Standar</x-slot>
                    <div class="mb-6">
                        <div class="h-96 chart-container" data-chart="true">
                            <canvas id="auditor1SubStandardChart" role="img"
                                aria-label="Auditor 1 Sub Standards Chart"
                                data-chart-type="auditor1-substandard"></canvas>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sub Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tidak Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Tidak Sesuai</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($auditor1Analysis['sub_standar_analysis'] ?? [] as $index => $subStandar)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['standar_code'] }} - {{ $subStandar['standar_name'] }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['sub_standar_name'] }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $subStandar['sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $subStandar['percentage_sesuai'] }}%</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $subStandar['tidak_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $subStandar['percentage_tidak_sesuai'] }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>
            </div>
        @elseif($activeTab === 'auditor2')
            {{-- Auditor 1 Tab --}}
            <div class="space-y-6">
                {{-- Completion Status --}}
                <x-filament::section>
                    <x-slot name="heading">Status Review Auditor 1</x-slot>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div class="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-blue-900 dark:text-blue-100">Status</h4>
                            <p class="text-lg font-semibold text-blue-700 dark:text-blue-300">
                                {{ $auditor2Analysis['total_reviewed'] ?? 0 }}/{{ $auditor2Analysis['total_items'] ?? 0 }}
                                Item Direview
                            </p>
                        </div>
                        <div class="bg-green-50 dark:bg-green-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-green-900 dark:text-green-100">Tanggal Mulai</h4>
                            <p class="text-sm text-green-700 dark:text-green-300">
                                {{-- {{ $auditor2Analysis['first_reviewed_at'] ?? '-' }} --}}
                            </p>
                        </div>
                        <div class="bg-purple-50 dark:bg-purple-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-purple-900 dark:text-purple-100">Terakhir Update</h4>
                            <p class="text-sm text-purple-700 dark:text-purple-300">
                                {{-- {{ $auditor2Analysis['last_reviewed_at'] ?? '-' }} --}}
                            </p>
                        </div>
                    </div>
                </x-filament::section>

                {{-- Summary Statistics --}}
                <x-filament::section>
                    <x-slot name="heading">Ringkasan Statistik</x-slot>
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div class="text-2xl font-bold text-gray-900 dark:text-white">
                                {{ $auditor2Analysis['total_items'] ?? 0 }}</div>
                            <div class="text-sm text-gray-600 dark:text-gray-400">Total Item</div>
                        </div>
                        <div class="text-center p-4 bg-success-50 dark:bg-success-900/20 rounded-lg">
                            <div class="text-2xl font-bold text-success-600 dark:text-success-400">
                                {{ $auditor2Analysis['sesuai'] ?? 0 }}</div>
                            <div class="text-sm text-success-600 dark:text-success-400">Sesuai
                                ({{ $auditor2Analysis['percentage_sesuai'] ?? 0 }}%)</div>
                        </div>
                        <div class="text-center p-4 bg-danger-50 dark:bg-danger-900/20 rounded-lg">
                            <div class="text-2xl font-bold text-danger-600 dark:text-danger-400">
                                {{ $auditor2Analysis['tidak_sesuai'] ?? 0 }}</div>
                            <div class="text-sm text-danger-600 dark:text-danger-400">Tidak Sesuai
                                ({{ $auditor2Analysis['percentage_tidak_sesuai'] ?? 0 }}%)</div>
                        </div>
                        <div class="text-center p-4 bg-gray-50 dark:bg-gray-800 rounded-lg">
                            <div class="text-2xl font-bold text-gray-600 dark:text-gray-400">
                                {{ $auditor2Analysis['belum_review'] ?? 0 }}</div>
                            <div class="text-sm text-gray-600 dark:text-gray-400">Belum Review
                                ({{ $auditor2Analysis['percentage_belum_review'] ?? 0 }}%)</div>
                        </div>
                    </div>
                </x-filament::section>

                {{-- Chart Section --}}
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <x-filament::section>
                        <x-slot name="heading">Distribusi Temuan</x-slot>
                        <div class="h-64 chart-container" data-chart="true">
                            <canvas id="auditor2OverviewChart" role="img"
                                aria-label="Auditor 1 Findings Distribution"
                                data-chart-type="auditor2-overview"></canvas>
                        </div>
                    </x-filament::section>

                    <x-filament::section>
                        <x-slot name="heading">Progress Review</x-slot>
                        <div class="space-y-4">
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span
                                        class="text-sm font-medium text-gray-700 dark:text-gray-300">Kelengkapan</span>
                                    <span
                                        class="text-sm text-gray-500 dark:text-gray-400">{{ $auditor2Analysis['percentage_complete'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3">
                                    <div class="bg-primary-600 h-3 rounded-full transition-all duration-300"
                                        style="width: {{ $auditor2Analysis['percentage_complete'] ?? 0 }}%"></div>
                                </div>
                            </div>
                        </div>
                    </x-filament::section>
                </div>

                {{-- Standards Analysis --}}
                <x-filament::section>
                    <x-slot name="heading">Review Berdasarkan Standar</x-slot>
                    <div class="mb-6">
                        <div class="h-96 chart-container" data-chart="true">
                            <canvas id="auditor2StandardChart" role="img" aria-label="Auditor 1 Standards Chart"
                                data-chart-type="auditor2-standard"></canvas>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kode</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tidak Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Tidak Sesuai</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($auditor2Analysis['standar_analysis'] ?? [] as $index => $standar)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">
                                            {{ $standar['standar_code'] }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $standar['standar_name'] }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $standar['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $standar['sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $standar['percentage_sesuai'] }}%</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $standar['tidak_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $standar['percentage_tidak_sesuai'] }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>

                {{-- Sub Standards Analysis --}}
                <x-filament::section>
                    <x-slot name="heading">Review Berdasarkan Sub Standar</x-slot>
                    <div class="mb-6">
                        <div class="h-96 chart-container" data-chart="true">
                            <canvas id="auditor2SubStandardChart" role="img"
                                aria-label="Auditor 1 Sub Standards Chart"
                                data-chart-type="auditor2-substandard"></canvas>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sub Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tidak Sesuai</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        % Tidak Sesuai</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($auditor2Analysis['sub_standar_analysis'] ?? [] as $index => $subStandar)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['standar_code'] }} - {{ $subStandar['standar_name'] }}
                                        </td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['sub_standar_name'] }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $subStandar['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $subStandar['sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $subStandar['percentage_sesuai'] }}%</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $subStandar['tidak_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $subStandar['percentage_tidak_sesuai'] }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>
            </div>
        @elseif($activeTab === 'overall')
            {{-- Overall Tab --}}
            <div class="space-y-6">
                {{-- Completion Status --}}
                <x-filament::section>
                    <x-slot name="heading">Status Keseluruhan - Auditee dan Auditor 1</x-slot>
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div class="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-blue-900 dark:text-blue-100">Tingkat Kesepakatan</h4>
                            <p class="text-lg font-semibold text-blue-700 dark:text-blue-300">
                                {{ $overallAnalysis['agreement_rate'] ?? 0 }}%
                            </p>
                        </div>
                        <div class="bg-green-50 dark:bg-green-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-green-900 dark:text-green-100">Item Sepakat</h4>
                            <p class="text-lg font-semibold text-green-700 dark:text-green-300">
                                {{ $overallAnalysis['consensus_items'] ?? 0 }}
                            </p>
                        </div>
                        <div class="bg-yellow-50 dark:bg-yellow-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-yellow-900 dark:text-yellow-100">Total Konflik</h4>
                            <p class="text-lg font-semibold text-yellow-700 dark:text-yellow-300">
                                {{ $overallAnalysis['total_conflicts'] ?? 0 }}
                            </p>
                        </div>
                        <div class="bg-purple-50 dark:bg-purple-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-purple-900 dark:text-purple-100">Skor Kualitas Audit
                            </h4>
                            <p class="text-lg font-semibold text-purple-700 dark:text-purple-300">
                                {{ $overallAnalysis['audit_quality_score'] ?? 0 }}%
                            </p>
                        </div>
                    </div>
                </x-filament::section>

                {{-- Summary Comparison Table --}}
                <x-filament::section>
                    <x-slot name="heading">Perbandingan Ringkasan - Auditee vs Auditor 1</x-slot>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kategori</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider"
                                        colspan="3">Auditee</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider"
                                        colspan="3">Auditor 1</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kesepakatan</th>
                                </tr>
                                <tr class="bg-gray-25 dark:bg-gray-750">
                                    <th></th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-success-600 dark:text-success-400">
                                        Tercapai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-danger-600 dark:text-danger-400">
                                        Tidak Tercapai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-gray-600 dark:text-gray-400">
                                        Total</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-success-600 dark:text-success-400">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-danger-600 dark:text-danger-400">
                                        Tidak Sesuai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-gray-600 dark:text-gray-400">
                                        Total</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-info-600 dark:text-info-400">
                                        %</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                <tr>
                                    <td
                                        class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">
                                        Total Keseluruhan</td>
                                    <td
                                        class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                        {{ $auditeeAnalysis['tercapai'] ?? 0 }}</td>
                                    <td
                                        class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                        {{ $auditeeAnalysis['tidak_tercapai'] ?? 0 }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                        {{ $auditeeAnalysis['total_items'] ?? 0 }}</td>
                                    <td
                                        class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                        {{ $auditor1Analysis['sesuai'] ?? 0 }}</td>
                                    <td
                                        class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                        {{ $auditor1Analysis['tidak_sesuai'] ?? 0 }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                        {{ $auditor1Analysis['total_reviewed'] ?? 0 }}</td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-info-600 dark:text-info-400">
                                        {{ $overallAnalysis['agreement_rate'] ?? 0 }}%</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>

                {{-- Chart Section --}}
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <x-filament::section>
                        <x-slot name="heading">Perbandingan Distribusi</x-slot>
                        <div class="h-64 chart-container" data-chart="true">
                            <canvas id="overallComparisonChart" role="img" aria-label="Overall Comparison Chart"
                                data-chart-type="overall-comparison"></canvas>
                        </div>
                    </x-filament::section>

                    {{-- <x-filament::section>
                        <x-slot name="heading">Tingkat Kesepakatan</x-slot>
                        <div class="space-y-4">
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span
                                        class="text-sm font-medium text-gray-700 dark:text-gray-300">Kesepakatan</span>
                                    <span
                                        class="text-sm text-gray-500 dark:text-gray-400">{{ $overallAnalysis['agreement_rate'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3">
                                    <div class="bg-info-600 h-3 rounded-full transition-all duration-300"
                                        style="width: {{ $overallAnalysis['agreement_rate'] ?? 0 }}%"></div>
                                </div>
                            </div>
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Kualitas
                                        Audit</span>
                                    <span
                                        class="text-sm text-gray-500 dark:text-gray-400">{{ $overallAnalysis['audit_quality_score'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3">
                                    <div class="bg-purple-600 h-3 rounded-full transition-all duration-300"
                                        style="width: {{ $overallAnalysis['audit_quality_score'] ?? 0 }}%"></div>
                                </div>
                            </div>
                        </div>
                    </x-filament::section> --}}
                </div>

                {{-- Standards Comparison --}}
                <x-filament::section>
                    <x-slot name="heading">Perbandingan Berdasarkan Standar</x-slot>
                    <div class="mb-6">
                        <div class="chart-container" data-chart="true">
                            <canvas id="overallStandardChart" role="img"
                                aria-label="Overall Standards Comparison Chart"
                                data-chart-type="overall-standard"></canvas>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kode</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider"
                                        colspan="3">Auditee</th>
                                    <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider"
                                        colspan="2">Auditor 1</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kesepakatan</th>
                                </tr>
                                <tr class="bg-gray-25 dark:bg-gray-750">
                                    <th colspan="4"></th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-success-600 dark:text-success-400">
                                        Tercapai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-danger-600 dark:text-danger-400">
                                        Tidak</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-success-600 dark:text-success-400">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-danger-600 dark:text-danger-400">
                                        Tidak</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-info-600 dark:text-info-400">
                                        %</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($overallAnalysis['standar_comparison'] ?? [] as $index => $comparison)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900 dark:text-white">
                                            {{ $comparison['standar_code'] }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $comparison['standar_name'] }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $comparison['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $comparison['auditee_tercapai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $comparison['auditee_tidak_tercapai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $comparison['auditor1_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $comparison['auditor1_tidak_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-info-600 dark:text-info-400">
                                            {{ $comparison['agreement_percentage'] ?? 0 }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>

                {{-- Sub Standards Comparison --}}
                <x-filament::section>
                    <x-slot name="heading">Perbandingan Berdasarkan Sub Standar</x-slot>
                    <div class="mb-6">
                        <div class="h-96 chart-container" data-chart="true">
                            <canvas id="overallSubStandardChart" role="img"
                                aria-label="Overall Sub Standards Comparison Chart"
                                data-chart-type="overall-substandard"></canvas>
                        </div>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sub Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider"
                                        colspan="2">Auditee</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider"
                                        colspan="2">Auditor 1</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kesepakatan</th>
                                </tr>
                                <tr class="bg-gray-25 dark:bg-gray-750">
                                    <th colspan="4"></th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-success-600 dark:text-success-400">
                                        Tercapai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-danger-600 dark:text-danger-400">
                                        Tidak</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-success-600 dark:text-success-400">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-danger-600 dark:text-danger-400">
                                        Tidak</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-info-600 dark:text-info-400">
                                        %</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($overallAnalysis['sub_standar_comparison'] ?? [] as $index => $comparison)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $comparison['standar_code'] }} - {{ $comparison['standar_name'] }}
                                        </td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            {{ $comparison['sub_standar_name'] }}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $comparison['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $comparison['auditee_tercapai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $comparison['auditee_tidak_tercapai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $comparison['auditor1_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $comparison['auditor1_tidak_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-info-600 dark:text-info-400">
                                            {{ $comparison['agreement_percentage'] ?? 0 }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>

                {{-- Conflict Details --}}
                @if (!empty($overallAnalysis['conflict_items']))
                    <x-filament::section :collapsible="true" :collapsed="true">
                        <x-slot name="heading">
                            Detail Konflik ({{ count($overallAnalysis['conflict_items']) }} konflik)
                        </x-slot>
                        <div class="space-y-4">
                            @foreach ($overallAnalysis['conflict_items'] as $index => $conflict)
                                <div
                                    class="border-l-4 border-l-warning-400 bg-warning-50 dark:bg-warning-900/20 p-4 rounded">
                                    <div class="flex items-start justify-between mb-3">
                                        <h5 class="text-sm font-medium text-warning-800 dark:text-warning-200">
                                            Konflik {{ $index + 1 }}
                                        </h5>
                                        <x-filament::badge color="warning">
                                            Konflik
                                        </x-filament::badge>
                                    </div>
                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div>
                                            <h6 class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-2">
                                                Auditee</h6>
                                            <x-filament::badge :color="$conflict['auditee_status'] === 'tercapai' ? 'success' : 'danger'">
                                                {{ ucfirst(str_replace('_', ' ', $conflict['auditee_status'])) }}
                                            </x-filament::badge>
                                        </div>
                                        <div>
                                            <h6 class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-2">
                                                Auditor 1</h6>
                                            <x-filament::badge :color="$conflict['auditor1_finding'] === 'sesuai' ? 'success' : 'danger'">
                                                {{ ucfirst(str_replace('_', ' ', $conflict['auditor1_finding'])) }}
                                            </x-filament::badge>
                                            @if ($conflict['auditor1_note'])
                                                <div
                                                    class="mt-2 text-sm text-gray-700 dark:text-gray-300 bg-gray-100 dark:bg-gray-800 p-2 rounded">
                                                    {{ $conflict['auditor1_note'] }}
                                                </div>
                                            @endif
                                        </div>
                                    </div>
                                    <div class="mt-3 text-sm text-gray-700 dark:text-gray-300">
                                        <strong>Item:</strong> {{ Str::limit($conflict['item'], 150) }}
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </x-filament::section>
                @endif
            </div>
        @elseif ($activeTab === 'achievement')
            {{-- NEW: Hasil Analisis Ketercapaian Standar Tab --}}
            <div class="space-y-6">
                {{-- Chart Section --}}
                <x-filament::section>
                    <x-slot name="heading">Ketercapaian Standar</x-slot>
                    <div class="h-96 chart-container" data-chart="true">
                        <canvas id="achievementChart" role="img" aria-label="Standard Achievement Chart"
                            data-chart-type="achievement"></canvas>
                    </div>
                </x-filament::section>

                {{-- Summary Table --}}
                <x-filament::section>
                    <x-slot name="heading">Ringkasan Ketercapaian per Sub Standar</x-slot>
                    <div class="overflow-x-auto">
                        <div class="max-h-96 overflow-y-auto">
                            <table class="w-full table-auto divide-y divide-gray-200 dark:divide-gray-700">
                                <thead class="bg-gray-50 dark:bg-gray-800 sticky top-0 z-10">
                                    <tr>
                                        <th
                                            class="w-12 px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            No
                                        </th>
                                        <th
                                            class="px-4 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Sub Standar
                                        </th>
                                        <th
                                            class="w-20 px-4 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Total
                                        </th>
                                        <th
                                            class="w-20 px-4 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Tercapai
                                        </th>
                                        <th
                                            class="w-32 px-4 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Persentase
                                        </th>
                                        <th
                                            class="w-24 px-4 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Status
                                        </th>
                                        <th
                                            class="w-24 px-4 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Ranking
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                    @foreach ($standardAchievementAnalysis['sub_standar_analysis'] ?? [] as $index => $subStandar)
                                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                            <td class="px-4 py-3 text-center text-sm text-gray-900 dark:text-white">
                                                {{ $index + 1 }}
                                            </td>
                                            <td class="px-4 py-3 text-sm text-gray-900 dark:text-white">
                                                <div class="min-w-0">
                                                    <div class="font-medium">{{ $subStandar['sub_standar_name'] }}
                                                    </div>
                                                    <div class="text-xs text-gray-500 dark:text-gray-400">
                                                        {{ $subStandar['standar_code'] }} -
                                                        {{ $subStandar['standar_name'] }}
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-4 py-3 text-center text-sm text-gray-900 dark:text-white">
                                                {{ $subStandar['total_items'] }}
                                            </td>
                                            <td
                                                class="px-4 py-3 text-center text-sm text-success-600 dark:text-success-400">
                                                {{ $subStandar['tercapai'] }}
                                            </td>
                                            <td class="px-4 py-3 text-sm text-gray-900 dark:text-white">
                                                <div class="flex items-center justify-center space-x-2 min-w-0">
                                                    <div
                                                        class="flex-1 bg-gray-200 dark:bg-gray-700 rounded-full h-2 min-w-[60px]">
                                                        <div class="h-2 rounded-full transition-all duration-300 {{ $subStandar['percentage'] >= 100 ? 'bg-green-600' : 'bg-yellow-600' }}"
                                                            style="width: {{ min($subStandar['percentage'], 100) }}%">
                                                        </div>
                                                    </div>
                                                    <span class="text-sm font-medium whitespace-nowrap flex-shrink-0">
                                                        {{ $subStandar['percentage'] }}%
                                                    </span>
                                                </div>
                                            </td>
                                            <td class="px-4 py-3 text-center">
                                                <x-filament::badge :color="$subStandar['status'] === 'close' ? 'success' : 'warning'">
                                                    {{ $subStandar['status'] === 'close' ? 'Close' : 'Open' }}
                                                </x-filament::badge>
                                            </td>
                                            <td class="px-4 py-3 text-center">
                                                @if ($subStandar['ranking'] == 1)
                                                    <span>
                                                        1
                                                    </span>
                                                @else
                                                    <span>
                                                        {{ $subStandar['ranking'] }}
                                                    </span>
                                                @endif
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </div>
                </x-filament::section>

                @if (!empty($standardAchievementAnalysis['open_items']))
                    <x-filament::section>
                        <x-slot name="heading">
                            Detail Item yang Belum Tercapai (Open)
                        </x-slot>
                        <div class="overflow-x-auto">
                            <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                                <thead class="bg-gray-50 dark:bg-gray-800">
                                    <tr>
                                        <th
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            No</th>
                                        <th
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Sub Standar</th>
                                        <th
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Indikator</th>
                                        <th
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Status Temuan</th>
                                        <th
                                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                            Hasil Pengamatan</th>
                                    </tr>
                                </thead>
                                <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                    @foreach ($standardAchievementAnalysis['open_items'] as $index => $item)
                                        <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                            <td
                                                class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                                {{ $index + 1 }}</td>
                                            <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                                <div>
                                                    <div class="font-medium">{{ $item['sub_standar_name'] }}</div>
                                                    <div class="text-xs text-gray-500 dark:text-gray-400">
                                                        {{ $item['standar_code'] }} - {{ $item['standar_name'] }}
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                                @php
                                                    $content = $item['indikator'] ?? '-';
                                                    if (strip_tags($content) !== $content) {
                                                        $content = str_replace(
                                                            '<ul>',
                                                            '<ul style="list-style-type: disc; padding-left: 1rem;">',
                                                            $content,
                                                        );
                                                        $content = str_replace(
                                                            '<ol>',
                                                            '<ol style="list-style-type: decimal; padding-left: 1rem;">',
                                                            $content,
                                                        );
                                                        $content = str_replace(
                                                            '<li>',
                                                            '<li style="margin-bottom: 4px;">',
                                                            $content,
                                                        );

                                                        echo new \Illuminate\Support\HtmlString($content);
                                                    } else {
                                                        echo new \Illuminate\Support\HtmlString(nl2br(e($content)));
                                                    }
                                                @endphp
                                            </td>
                                            <td class="px-6 py-4 whitespace-nowrap">
                                                @if ($item['status_temuan'] === 'sesuai')
                                                    <x-filament::badge color="success">Sesuai</x-filament::badge>
                                                @elseif($item['status_temuan'] === 'tidak_sesuai')
                                                    <x-filament::badge color="danger">Tidak Sesuai</x-filament::badge>
                                                @else
                                                    <x-filament::badge
                                                        color="gray">{{ $item['status_temuan'] }}</x-filament::badge>
                                                @endif
                                            </td>
                                            <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                                {{ $item['hasil_pengamatan'] ?: '-' }}</td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    </x-filament::section>
                @endif
            </div>
        @elseif ($activeTab === 'auditor_comparison')
            {{-- NEW: Auditor 1 vs Auditor 2 Comparison Tab --}}
            <div class="space-y-6">
                {{-- Status Summary --}}
                <x-filament::section>
                    <x-slot name="heading">Status Perbandingan Auditor 1 vs Auditor 2</x-slot>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div class="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-blue-900 dark:text-blue-100">Tingkat Kesepakatan</h4>
                            <p class="text-lg font-semibold text-blue-700 dark:text-blue-300">
                                {{ $auditor1vs2Analysis['agreement_rate'] ?? 0 }}%
                            </p>
                        </div>
                        <div class="bg-green-50 dark:bg-green-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-green-900 dark:text-green-100">Item Sepakat</h4>
                            <p class="text-lg font-semibold text-green-700 dark:text-green-300">
                                {{ $auditor1vs2Analysis['consensus_items'] ?? 0 }}
                            </p>
                        </div>
                        <div class="bg-yellow-50 dark:bg-yellow-900/20 p-4 rounded-lg">
                            <h4 class="text-sm font-medium text-yellow-900 dark:text-yellow-100">Total Konflik</h4>
                            <p class="text-lg font-semibold text-yellow-700 dark:text-yellow-300">
                                {{ $auditor1vs2Analysis['total_conflicts'] ?? 0 }}
                            </p>
                        </div>
                    </div>
                </x-filament::section>

                {{-- Chart Section --}}
                <x-filament::section>
                    <x-slot name="heading">Perbandingan Review Auditor</x-slot>
                    <div class="h-96 chart-container" data-chart="true">
                        <canvas id="auditorComparisonChart" role="img" aria-label="Auditor Comparison Chart"
                            data-chart-type="auditor-comparison"></canvas>
                    </div>
                </x-filament::section>

                {{-- Comparison Table --}}
                <x-filament::section>
                    <x-slot name="heading">Perbandingan Berdasarkan Sub Standar</x-slot>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        No</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sub Standar</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total</th>
                                    <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider"
                                        colspan="2">Auditor 1</th>
                                    <th class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider"
                                        colspan="2">Auditor 2</th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Kesepakatan</th>
                                </tr>
                                <tr class="bg-gray-25 dark:bg-gray-750">
                                    <th colspan="3"></th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-success-600 dark:text-success-400">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-danger-600 dark:text-danger-400">
                                        Tidak</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-success-600 dark:text-success-400">
                                        Sesuai</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-danger-600 dark:text-danger-400">
                                        Tidak</th>
                                    <th
                                        class="px-6 py-2 text-left text-xs font-medium text-info-600 dark:text-info-400">
                                        %</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($auditor1vs2Analysis['sub_standar_comparison'] ?? [] as $index => $comparison)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $index + 1 }}</td>
                                        <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">
                                            <div>
                                                <div class="font-medium">{{ $comparison['sub_standar_name'] }}</div>
                                                <div class="text-xs text-gray-500 dark:text-gray-400">
                                                    {{ $comparison['standar_code'] }} -
                                                    {{ $comparison['standar_name'] }}
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900 dark:text-white">
                                            {{ $comparison['total_items'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $comparison['auditor1_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $comparison['auditor1_tidak_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-success-600 dark:text-success-400">
                                            {{ $comparison['auditor2_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-danger-600 dark:text-danger-400">
                                            {{ $comparison['auditor2_tidak_sesuai'] }}</td>
                                        <td
                                            class="px-6 py-4 whitespace-nowrap text-sm text-info-600 dark:text-info-400">
                                            {{ $comparison['agreement_percentage'] ?? 0 }}%</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </x-filament::section>

                {{-- Conflict Details --}}
                @if (!empty($auditor1vs2Analysis['conflict_items']))
                    <x-filament::section :collapsible="true" :collapsed="true">
                        <x-slot name="heading">
                            Detail Item yang Tidak Sepakat ({{ count($auditor1vs2Analysis['conflict_items']) }}
                            konflik)
                        </x-slot>
                        <div class="space-y-4">
                            @foreach ($auditor1vs2Analysis['conflict_items'] as $index => $conflict)
                                <div
                                    class="border-l-4 border-l-warning-400 bg-warning-50 dark:bg-warning-900/20 p-4 rounded">
                                    <div class="flex items-start justify-between mb-3">
                                        <h5 class="text-sm font-medium text-warning-800 dark:text-warning-200">
                                            Konflik {{ $index + 1 }}
                                        </h5>
                                        <x-filament::badge color="warning">
                                            Konflik
                                        </x-filament::badge>
                                    </div>

                                    <div class="mb-3">
                                        <h6 class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">
                                            Sub Standar
                                        </h6>
                                        <div class="text-sm text-gray-700 dark:text-gray-300">
                                            <strong>{{ $conflict['sub_standar_name'] }}</strong>
                                            <div class="text-xs text-gray-500 dark:text-gray-400">
                                                {{ $conflict['standar_code'] }} - {{ $conflict['standar_name'] }}
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <h6 class="text-xs font-medium text-gray-600 dark:text-gray-400 mb-1">
                                            Item Indikator
                                        </h6>
                                        <div
                                            class="text-sm text-gray-700 dark:text-gray-300 bg-gray-100 dark:bg-gray-800 p-2 rounded">
                                            {{ $conflict['item'] }}
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div class="border rounded-lg p-3 bg-blue-50 dark:bg-blue-900/20">
                                            <h6 class="text-xs font-medium text-blue-800 dark:text-blue-200 mb-2">
                                                <x-heroicon-o-user class="w-4 h-4 inline mr-1" />
                                                Auditor 1
                                            </h6>
                                            <div class="space-y-2">
                                                <div>
                                                    <span
                                                        class="text-xs text-gray-600 dark:text-gray-400">Temuan:</span>
                                                    <x-filament::badge :color="$conflict['auditor1_finding'] === 'sesuai' ? 'success' : 'danger'">
                                                        {{ ucfirst(str_replace('_', ' ', $conflict['auditor1_finding'])) }}
                                                    </x-filament::badge>
                                                </div>
                                                @if ($conflict['auditor1_note'])
                                                    <div>
                                                        <span
                                                            class="text-xs text-gray-600 dark:text-gray-400">Catatan:</span>
                                                        <div class="text-sm text-gray-700 dark:text-gray-300 mt-1">
                                                            {{ $conflict['auditor1_note'] }}
                                                        </div>
                                                    </div>
                                                @endif
                                                <div class="text-xs text-gray-500 dark:text-gray-400">
                                                    Direview:
                                                    {{ $conflict['auditor1_reviewed_at'] ? $conflict['auditor1_reviewed_at']->format('d/m/Y H:i') : '-' }}
                                                </div>
                                            </div>
                                        </div>

                                        <div class="border rounded-lg p-3 bg-green-50 dark:bg-green-900/20">
                                            <h6 class="text-xs font-medium text-green-800 dark:text-green-200 mb-2">
                                                <x-heroicon-o-user class="w-4 h-4 inline mr-1" />
                                                Auditor 2
                                            </h6>
                                            <div class="space-y-2">
                                                <div>
                                                    <span
                                                        class="text-xs text-gray-600 dark:text-gray-400">Temuan:</span>
                                                    <x-filament::badge :color="$conflict['auditor2_finding'] === 'sesuai' ? 'success' : 'danger'">
                                                        {{ ucfirst(str_replace('_', ' ', $conflict['auditor2_finding'])) }}
                                                    </x-filament::badge>
                                                </div>
                                                @if ($conflict['auditor2_note'])
                                                    <div>
                                                        <span
                                                            class="text-xs text-gray-600 dark:text-gray-400">Catatan:</span>
                                                        <div class="text-sm text-gray-700 dark:text-gray-300 mt-1">
                                                            {{ $conflict['auditor2_note'] }}
                                                        </div>
                                                    </div>
                                                @endif
                                                <div class="text-xs text-gray-500 dark:text-gray-400">
                                                    Direview:
                                                    {{ $conflict['auditor2_reviewed_at'] ? $conflict['auditor2_reviewed_at']->format('d/m/Y H:i') : '-' }}
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </x-filament::section>
                @else
                    <x-filament::section>
                        <x-slot name="heading">
                            Detail Konflik
                        </x-slot>
                        <div class="text-center py-8">
                            <div class="text-gray-500 dark:text-gray-400">
                                <p class="text-lg font-medium">Tidak Ada Konflik</p>
                            </div>
                        </div>
                    </x-filament::section>
                @endif
            </div>

        @endif

        {{-- Mobile Dropdown JavaScript --}}
        <script>
            function toggleTabDropdown() {
                const menu = document.getElementById('tab-dropdown-menu');
                menu.classList.toggle('hidden');
            }

            function closeTabDropdown() {
                const menu = document.getElementById('tab-dropdown-menu');
                menu.classList.add('hidden');
            }

            // Close dropdown when clicking outside
            document.addEventListener('click', function(event) {
                const button = document.getElementById('tab-dropdown-button');
                const menu = document.getElementById('tab-dropdown-menu');

                if (button && menu && !button.contains(event.target) && !menu.contains(event.target)) {
                    menu.classList.add('hidden');
                }
            });
        </script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-zoom@2.0.1/dist/chartjs-plugin-zoom.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels@2.2.0/dist/chartjs-plugin-datalabels.min.js">
        </script>

        <script>
            Chart.register(ChartZoom, ChartDataLabels);

            window.AuditResultChartManager = {
                instances: {},
                data: {
                    auditee: @json($auditeeAnalysis ?? []),
                    auditor1: @json($auditor1Analysis ?? []),
                    auditor2: @json($auditor2Analysis ?? []),
                    overall: @json($overallAnalysis ?? []),
                    achievement: @json($standardAchievementAnalysis ?? []),
                    auditorComparison: @json($auditor1vs2Analysis ?? [])
                },
                activeTab: '{{ $activeTab }}',
                chartJSLoaded: false,
                isInitializing: false,

                init: function(forceReset = false) {
                    console.log('Initializing charts for tab:', this.activeTab, 'Force reset:', forceReset);
                    this.destroyAllCharts();

                    if (this.isInitializing && !forceReset) {
                        console.log('Already initializing, skipping...');
                        return Promise.resolve();
                    }

                    this.isInitializing = true;

                    return new Promise((resolve) => {
                        this.chartJSLoaded = true;
                        this.createChartsForActiveTab().then(() => {
                            this.isInitializing = false;
                            resolve();
                        });
                    });
                },
                getCommonOptions: function(type = 'stack') {
                    const baseOptions = {
                        responsive: true,
                        maintainAspectRatio: false,
                        animation: {
                            duration: 800
                        },
                        layout: {
                            padding: {
                                top: 40, // Space for legend
                                bottom: 20,
                                left: 20,
                                right: 20
                            }
                        },
                        plugins: {
                            legend: {
                                display: true,
                                position: 'top',
                                align: 'center',
                                labels: {
                                    padding: 25, // Space between legend items
                                    boxWidth: 15, // Legend color box width
                                    boxHeight: 15, // Legend color box height
                                    font: {
                                        size: 14,
                                        family: 'Arial, sans-serif'
                                    },
                                    color: '#374151', // Legend text color
                                    usePointStyle: false,
                                    generateLabels: function(chart) {
                                        const labels = Chart.defaults.plugins.legend.labels.generateLabels(
                                            chart);
                                        // Ensure proper spacing between labels
                                        return labels;
                                    }
                                },
                                onHover: function(evt, legendItem, legend) {
                                    legend.chart.canvas.style.cursor = 'pointer';
                                },
                                onLeave: function(evt, legendItem, legend) {
                                    legend.chart.canvas.style.cursor = 'default';
                                },
                                onClick: function(evt, legendItem, legend) {
                                    Chart.defaults.plugins.legend.onClick.call(this, evt, legendItem, legend);
                                }
                            },
                            datalabels: {
                                anchor: 'end',
                                align: 'top',
                                offset: -8,
                                color: '#374151',
                                font: {
                                    weight: 'bold',
                                    size: 12
                                },
                                formatter: function(value, context) {
                                    return value > 0 ? value : '';
                                },
                                clip: false
                            },
                            zoom: {
                                zoom: {
                                    wheel: {
                                        enabled: true,
                                    },
                                    pinch: {
                                        enabled: true
                                    },
                                    mode: 'x',
                                    scaleMode: 'x'
                                },
                                pan: {
                                    enabled: true,
                                    mode: 'x'
                                }
                            }
                        },
                        scales: {
                            x: {
                                beginAtZero: true,
                                grid: {
                                    display: true,
                                    color: '#e5e7eb'
                                },
                                ticks: {
                                    font: {
                                        size: 12
                                    },
                                    color: '#6b7280'
                                }
                            },
                            y: {
                                beginAtZero: true,
                                max: 100, // Assuming percentage values
                                grid: {
                                    display: true,
                                    color: '#e5e7eb'
                                },
                                ticks: {
                                    font: {
                                        size: 12
                                    },
                                    color: '#6b7280',
                                    callback: function(value) {
                                        return value + '%'; // Add percentage sign
                                    }
                                }
                            }
                        }
                    };

                    if (type === 'doughnut') {
                        baseOptions.plugins.datalabels = {
                            color: '#ffffff',
                            font: {
                                weight: 'bold',
                                size: 14
                            },
                            formatter: function(value, context) {
                                const total = context.dataset.data.reduce((sum, val) => sum + val, 0);
                                const percentage = total > 0 ? ((value / total) * 100).toFixed(1) : 0;
                                return value > 0 ? `${value}\n(${percentage}%)` : '';
                            }
                        };
                        // Remove zoom for doughnut charts as they don't work well
                        delete baseOptions.plugins.zoom;
                    }

                    return baseOptions;
                },

                waitForCanvas: function(canvasId, maxAttempts = 20) {
                    return new Promise((resolve, reject) => {
                        let attempts = 0;

                        const checkCanvas = () => {
                            attempts++;
                            const canvas = document.getElementById(canvasId);

                            if (canvas && this.isCanvasReady(canvas)) {
                                console.log('Canvas', canvasId, 'found and ready on attempt', attempts);
                                resolve(canvas);
                            } else if (attempts < maxAttempts) {
                                setTimeout(checkCanvas, 200);
                            } else {
                                console.warn('Canvas', canvasId, 'not ready after', maxAttempts,
                                    'attempts');
                                reject(new Error(`Canvas ${canvasId} not ready`));
                            }
                        };

                        checkCanvas();
                    });
                },

                isCanvasReady: function(canvas) {
                    return canvas &&
                        canvas.offsetParent !== null &&
                        canvas.offsetWidth > 0 &&
                        canvas.offsetHeight > 0;
                },

                createChartsForActiveTab: function() {
                    console.log('Creating charts for active tab:', this.activeTab);

                    const chartPromises = [];

                    switch (this.activeTab) {
                        case 'auditee':
                            chartPromises.push(
                                this.createChartWithRetry('auditeeOverviewChart', () => this
                                    .createAuditeeOverviewChart()),
                                this.createChartWithRetry('auditeeStandardChart', () => this
                                    .createAuditeeStandardChart()),
                                this.createChartWithRetry('auditeeSubStandardChart', () => this
                                    .createAuditeeSubStandardChart())
                            );
                            break;
                        case 'auditor1':
                            chartPromises.push(
                                this.createChartWithRetry('auditor1OverviewChart', () => this
                                    .createAuditor1OverviewChart()),
                                this.createChartWithRetry('auditor1StandardChart', () => this
                                    .createAuditor1StandardChart()),
                                this.createChartWithRetry('auditor1SubStandardChart', () => this
                                    .createAuditor1SubStandardChart())
                            );
                            break;
                        case 'auditor2':
                            chartPromises.push(
                                this.createChartWithRetry('auditor2OverviewChart', () => this
                                    .createAuditor2OverviewChart()),
                                this.createChartWithRetry('auditor2StandardChart', () => this
                                    .createAuditor2StandardChart()),
                                this.createChartWithRetry('auditor2SubStandardChart', () => this
                                    .createAuditor2SubStandardChart())
                            );
                            break;
                        case 'overall':
                            chartPromises.push(
                                this.createChartWithRetry('overallComparisonChart', () => this
                                    .createOverallComparisonChart()),
                                this.createChartWithRetry('overallStandardChart', () => this
                                    .createOverallStandardChart()),
                                this.createChartWithRetry('overallSubStandardChart', () => this
                                    .createOverallSubStandardChart())
                            );
                            break;
                        case 'achievement':
                            chartPromises.push(
                                this.createChartWithRetry('achievementChart', () => this
                                    .createAchievementChart())
                            );
                            break;
                        case 'auditor_comparison':
                            chartPromises.push(
                                this.createChartWithRetry('auditor_comparisonChart', () => this
                                    .createAuditorComparisonChart())
                            );
                            break;
                    }

                    return Promise.allSettled(chartPromises);
                },

                createChartWithRetry: function(canvasId, createFunction, maxRetries = 3) {
                    return this.waitForCanvas(canvasId)
                        .then(() => {
                            return this.retryOperation(createFunction, maxRetries);
                        })
                        .catch(error => {
                            console.warn(`Failed to create chart for ${canvasId}:`, error);
                        });
                },

                retryOperation: function(operation, maxRetries) {
                    return new Promise((resolve, reject) => {
                        let attempts = 0;

                        const attempt = () => {
                            attempts++;
                            try {
                                const result = operation();
                                if (result) {
                                    resolve(result);
                                } else if (attempts < maxRetries) {
                                    setTimeout(attempt, 300);
                                } else {
                                    reject(new Error('Max retry attempts reached'));
                                }
                            } catch (error) {
                                if (attempts < maxRetries) {
                                    setTimeout(attempt, 300);
                                } else {
                                    reject(error);
                                }
                            }
                        };

                        attempt();
                    });
                },

                destroyChart: function(chartKey) {
                    if (this.instances[chartKey]) {
                        try {
                            console.log('Destroying chart:', chartKey);
                            this.instances[chartKey].destroy();
                        } catch (error) {
                            console.warn('Error destroying chart:', chartKey, error);
                        } finally {
                            delete this.instances[chartKey];
                        }
                    }
                },

                createChartSafely: function(canvasId, chartKey, chartConfig) {
                    const canvas = document.getElementById(canvasId);
                    if (!canvas || !this.isCanvasReady(canvas)) {
                        console.warn(`Canvas ${canvasId} not ready for chart creation`);
                        return null;
                    }

                    // Always destroy existing chart first
                    this.destroyChart(chartKey);

                    try {
                        // Clear canvas context
                        const ctx = canvas.getContext('2d');
                        ctx.clearRect(0, 0, canvas.width, canvas.height);

                        // Create new chart with plugins
                        this.instances[chartKey] = new Chart(ctx, chartConfig);
                        console.log(`Chart ${chartKey} created successfully`);

                        // Add zoom controls for bar charts only
                        if (chartConfig.type === 'bar') {
                            this.addZoomControls(canvasId, chartKey);
                        }

                        return this.instances[chartKey];
                    } catch (error) {
                        console.error(`Error creating chart ${chartKey}:`, error);
                        return null;
                    }
                },

                addZoomControls: function(canvasId, chartKey) {
                    const canvas = document.getElementById(canvasId);
                    if (!canvas) return;

                    // Remove existing controls
                    const existingControls = canvas.parentNode.querySelector('.zoom-controls');
                    if (existingControls) {
                        existingControls.remove();
                    }

                    // Create zoom controls
                    const controlsDiv = document.createElement('div');
                    controlsDiv.className = 'zoom-controls';
                    controlsDiv.style.cssText = `
                position: absolute;
                top: 10px;
                right: 10px;
                display: flex;
                gap: 5px;
                z-index: 1000;
                border-radius: 6px;
                padding: 4px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            `;

                    const zoomInBtn = this.createZoomButton('🔍+', 'Zoom In');
                    const zoomOutBtn = this.createZoomButton('🔍-', 'Zoom Out');
                    const resetBtn = this.createZoomButton('↻', 'Reset Zoom');

                    zoomInBtn.onclick = () => this.zoomChart(chartKey, 1.1);
                    zoomOutBtn.onclick = () => this.zoomChart(chartKey, 0.9);
                    resetBtn.onclick = () => this.resetZoom(chartKey);

                    controlsDiv.appendChild(zoomInBtn);
                    controlsDiv.appendChild(zoomOutBtn);
                    controlsDiv.appendChild(resetBtn);

                    // Make canvas container relative if not already
                    if (canvas.parentNode.style.position !== 'relative') {
                        canvas.parentNode.style.position = 'relative';
                    }

                    canvas.parentNode.appendChild(controlsDiv);
                },

                createZoomButton: function(text, title) {
                    const button = document.createElement('button');
                    button.textContent = text;
                    button.title = title;
                    button.style.cssText = `
                border: none;
                border-radius: 4px;
                padding: 4px 8px;
                cursor: pointer;
                font-size: 12px;
                transition: background-color 0.2s;
            `;
                    button.onmouseover = () => button.style.background = 'rgba(59, 130, 246, 1)';
                    button.onmouseout = () => button.style.background = 'rgba(59, 130, 246, 0.9)';
                    return button;
                },

                zoomChart: function(chartKey, factor) {
                    const chart = this.instances[chartKey];
                    if (chart && chart.zoom) {
                        chart.zoom(factor);
                    }
                },

                resetZoom: function(chartKey) {
                    const chart = this.instances[chartKey];
                    if (chart && chart.resetZoom) {
                        chart.resetZoom();
                    }
                },

                // Chart creation methods
                createAuditeeOverviewChart: function() {
                    const options = this.getCommonOptions('doughnut');

                    return this.createChartSafely('auditeeOverviewChart', 'auditeeOverview', {
                        type: 'doughnut',
                        data: {
                            labels: ['Tercapai', 'Tidak Tercapai', 'Belum Diisi'],
                            datasets: [{
                                data: [
                                    this.data.auditee.tercapai || 0,
                                    this.data.auditee.tidak_tercapai || 0,
                                    this.data.auditee.belum_diisi || 0
                                ],
                                backgroundColor: ['#10B981', '#EF4444', '#6B7280'],
                                borderWidth: 2,
                                borderColor: '#ffffff'
                            }]
                        },
                        options: {
                            ...options,
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        usePointStyle: true,
                                        padding: 15
                                    }
                                }
                            }
                        }
                    });
                },

                createAuditeeStandardChart: function() {
                    const standardData = this.data.auditee.standar_analysis || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('auditeeStandardChart', 'auditeeStandard', {
                        type: 'bar',
                        data: {
                            labels: standardData.map(item => item.standar_code || 'Unknown'),
                            datasets: [{
                                label: 'Tercapai',
                                data: standardData.map(item => item.tercapai || 0),
                                backgroundColor: '#10B981'
                            }, {
                                label: 'Tidak Tercapai',
                                data: standardData.map(item => item.tidak_tercapai || 0),
                                backgroundColor: '#EF4444'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    stacked: true
                                },
                                y: {
                                    stacked: true,
                                    beginAtZero: true
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                }
                            }
                        }
                    });
                },

                createAuditeeSubStandardChart: function() {
                    const subStandardData = this.data.auditee.sub_standar_analysis || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('auditeeSubStandardChart', 'auditeeSubStandard', {
                        type: 'bar',
                        data: {
                            labels: subStandardData.map(item => item.sub_standar_name || 'Unknown'),
                            datasets: [{
                                label: 'Tercapai',
                                data: subStandardData.map(item => item.tercapai || 0),
                                backgroundColor: '#10B981'
                            }, {
                                label: 'Tidak Tercapai',
                                data: subStandardData.map(item => item.tidak_tercapai || 0),
                                backgroundColor: '#EF4444'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    stacked: true,
                                    ticks: {
                                        maxRotation: 45
                                    }
                                },
                                y: {
                                    stacked: true,
                                    beginAtZero: true
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                }
                            }
                        }
                    });
                },

                createAuditor1OverviewChart: function() {
                    const options = this.getCommonOptions('doughnut');

                    return this.createChartSafely('auditor1OverviewChart', 'auditor1Overview', {
                        type: 'doughnut',
                        data: {
                            labels: ['Sesuai', 'Tidak Sesuai', 'Belum Review'],
                            datasets: [{
                                data: [
                                    this.data.auditor1.sesuai || 0,
                                    this.data.auditor1.tidak_sesuai || 0,
                                    this.data.auditor1.belum_review || 0
                                ],
                                backgroundColor: ['#10B981', '#EF4444', '#6B7280'],
                                borderWidth: 2,
                                borderColor: '#ffffff'
                            }]
                        },
                        options: {
                            ...options,
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        usePointStyle: true,
                                        padding: 15
                                    }
                                }
                            }
                        }
                    });
                },

                createAuditor1StandardChart: function() {
                    const standardData = this.data.auditor1.standar_analysis || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('auditor1StandardChart', 'auditor1Standard', {
                        type: 'bar',
                        data: {
                            labels: standardData.map(item => item.standar_code || 'Unknown'),
                            datasets: [{
                                label: 'Sesuai',
                                data: standardData.map(item => item.sesuai || 0),
                                backgroundColor: '#10B981'
                            }, {
                                label: 'Tidak Sesuai',
                                data: standardData.map(item => item.tidak_sesuai || 0),
                                backgroundColor: '#EF4444'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    stacked: true
                                },
                                y: {
                                    stacked: true,
                                    beginAtZero: true
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                }
                            }
                        }
                    });
                },

                createAuditor1SubStandardChart: function() {
                    const subStandardData = this.data.auditor1.sub_standar_analysis || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('auditor1SubStandardChart', 'auditor1SubStandard', {
                        type: 'bar',
                        data: {
                            labels: subStandardData.map(item => item.sub_standar_name || 'Unknown'),
                            datasets: [{
                                label: 'Sesuai',
                                data: subStandardData.map(item => item.sesuai || 0),
                                backgroundColor: '#10B981'
                            }, {
                                label: 'Tidak Sesuai',
                                data: subStandardData.map(item => item.tidak_sesuai || 0),
                                backgroundColor: '#EF4444'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    stacked: true,
                                    ticks: {
                                        maxRotation: 45
                                    }
                                },
                                y: {
                                    stacked: true,
                                    beginAtZero: true
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                }
                            }
                        }
                    });
                },

                createAuditor2OverviewChart: function() {
                    const options = this.getCommonOptions('doughnut');

                    return this.createChartSafely('auditor2OverviewChart', 'auditor2Overview', {
                        type: 'doughnut',
                        data: {
                            labels: ['Sesuai', 'Tidak Sesuai', 'Belum Review'],
                            datasets: [{
                                data: [
                                    this.data.auditor2.sesuai || 0,
                                    this.data.auditor2.tidak_sesuai || 0,
                                    this.data.auditor2.belum_review || 0
                                ],
                                backgroundColor: ['#10B981', '#EF4444', '#6B7280'],
                                borderWidth: 2,
                                borderColor: '#ffffff'
                            }]
                        },
                        options: {
                            ...options,
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        usePointStyle: true,
                                        padding: 15
                                    }
                                }
                            }
                        }
                    });
                },

                createAuditor2StandardChart: function() {
                    const standardData = this.data.auditor2.standar_analysis || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('auditor2StandardChart', 'auditor2Standard', {
                        type: 'bar',
                        data: {
                            labels: standardData.map(item => item.standar_code || 'Unknown'),
                            datasets: [{
                                label: 'Sesuai',
                                data: standardData.map(item => item.sesuai || 0),
                                backgroundColor: '#10B981'
                            }, {
                                label: 'Tidak Sesuai',
                                data: standardData.map(item => item.tidak_sesuai || 0),
                                backgroundColor: '#EF4444'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    stacked: true
                                },
                                y: {
                                    stacked: true,
                                    beginAtZero: true
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                }
                            }
                        }
                    });
                },

                createAuditor2SubStandardChart: function() {
                    const subStandardData = this.data.auditor2.sub_standar_analysis || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('auditor2SubStandardChart', 'auditor2SubStandard', {
                        type: 'bar',
                        data: {
                            labels: subStandardData.map(item => item.sub_standar_name || 'Unknown'),
                            datasets: [{
                                label: 'Sesuai',
                                data: subStandardData.map(item => item.sesuai || 0),
                                backgroundColor: '#10B981'
                            }, {
                                label: 'Tidak Sesuai',
                                data: subStandardData.map(item => item.tidak_sesuai || 0),
                                backgroundColor: '#EF4444'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    stacked: true,
                                    ticks: {
                                        maxRotation: 45
                                    }
                                },
                                y: {
                                    stacked: true,
                                    beginAtZero: true
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                }
                            }
                        }
                    });
                },

                createOverallComparisonChart: function() {
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('overallComparisonChart', 'overallComparison', {
                        type: 'bar',
                        data: {
                            labels: ['Auditee', 'Auditor 1'],
                            datasets: [{
                                label: 'Tercapai/Sesuai',
                                data: [
                                    this.data.auditee.tercapai || 0,
                                    this.data.auditor1.sesuai || 0
                                ],
                                backgroundColor: '#10B981'
                            }, {
                                label: 'Tidak Tercapai/Tidak Sesuai',
                                data: [
                                    this.data.auditee.tidak_tercapai || 0,
                                    this.data.auditor1.tidak_sesuai || 0
                                ],
                                backgroundColor: '#EF4444'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                y: {
                                    beginAtZero: true
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                }
                            }
                        }
                    });
                },

                createOverallStandardChart: function() {
                    const comparisonData = this.data.overall.standar_comparison || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('overallStandardChart', 'overallStandard', {
                        type: 'bar',
                        data: {
                            labels: comparisonData.map(item => item.standar_name || 'Unknown'),
                            datasets: [{
                                label: 'Indikator Tercapai',
                                data: comparisonData.map(item => item.auditee_tercapai_percentage || 0),
                                backgroundColor: '#3B82F6'
                            }, {
                                label: 'Auditor 1 Sesuai',
                                data: comparisonData.map(item => item.auditor1_sesuai_percentage || 0),
                                backgroundColor: '#10B981'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    position: 'left',
                                    ticks: {
                                        callback: function(value) {
                                            return value + '%';
                                        }
                                    }
                                }
                            },
                            plugins: {
                                ...options.plugins,

                                tooltip: {
                                    callbacks: {
                                        label: function(context) {
                                            return context.dataset.label + ': ' + context.parsed.y + '%';
                                        }
                                    }
                                }
                            }
                        }
                    });
                },

                createOverallSubStandardChart: function() {
                    const subComparisonData = this.data.overall.sub_standar_comparison || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('overallSubStandardChart', 'overallSubStandard', {
                        type: 'bar',
                        data: {
                            labels: subComparisonData.map(item => item.sub_standar_name || 'Unknown'),
                            datasets: [{
                                label: 'Kesepakatan (%)',
                                data: subComparisonData.map(item => item.agreement_percentage || 0),
                                backgroundColor: '#8B5CF6'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    ticks: {
                                        maxRotation: 45
                                    }
                                },
                                y: {
                                    beginAtZero: true,
                                    max: 100
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'bottom'
                                },
                                datalabels: {
                                    ...options.plugins.datalabels,
                                    formatter: function(value, context) {
                                        return value > 0 ? `${value}%` : '';
                                    }
                                }
                            }
                        }
                    });
                },
                createAchievementChart: function() {
                    const achievementData = this.data.achievement.sub_standar_analysis || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('achievementChart', 'achievement', {
                        type: 'bar',
                        data: {
                            labels: achievementData.map(item => item.sub_standar_name || 'Unknown'),
                            datasets: [{
                                label: 'Persentase Ketercapaian (%)',
                                data: achievementData.map(item => item.percentage || 0),
                                backgroundColor: achievementData.map(item =>
                                    item.percentage >= 100 ? '#10B981' : '#F59E0B'
                                ),
                                borderColor: achievementData.map(item =>
                                    item.percentage >= 100 ? '#047857' : '#D97706'
                                ),
                                borderWidth: 1
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    ticks: {
                                        maxRotation: 45
                                    }
                                },
                                y: {
                                    beginAtZero: true,
                                    max: 120,
                                    ticks: {
                                        callback: function(value) {
                                            return value + '%';
                                        }
                                    }
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                },
                                datalabels: {
                                    ...options.plugins.datalabels,
                                    formatter: function(value, context) {
                                        return value > 0 ? `${value}%` : '';
                                    }
                                }
                            }
                        }
                    });
                },

                createAuditorComparisonChart: function() {
                    const comparisonData = this.data.auditorComparison.sub_standar_comparison || [];
                    const options = this.getCommonOptions('bar');

                    return this.createChartSafely('auditorComparisonChart', 'auditorComparison', {
                        type: 'bar',
                        data: {
                            labels: comparisonData.map(item => item.sub_standar_name || 'Unknown'),
                            datasets: [{
                                label: 'Auditor 1 - Sesuai (%)',
                                data: comparisonData.map(item => item.auditor1_sesuai_percentage || 0),
                                backgroundColor: '#3B82F6'
                            }, {
                                label: 'Auditor 2 - Sesuai (%)',
                                data: comparisonData.map(item => item.auditor2_sesuai_percentage || 0),
                                backgroundColor: '#10B981'
                            }, {
                                label: 'Kesepakatan (%)',
                                data: comparisonData.map(item => item.agreement_percentage || 0),
                                backgroundColor: '#8B5CF6'
                            }]
                        },
                        options: {
                            ...options,
                            scales: {
                                x: {
                                    ticks: {
                                        maxRotation: 45
                                    }
                                },
                                y: {
                                    beginAtZero: true,
                                    max: 100,
                                    ticks: {
                                        callback: function(value) {
                                            return value + '%';
                                        }
                                    }
                                }
                            },
                            plugins: {
                                ...options.plugins,
                                legend: {
                                    position: 'top'
                                }
                            }
                        }
                    });
                },


                destroyAllCharts: function() {
                    console.log('Destroying all charts, count:', Object.keys(this.instances).length);
                    Object.keys(this.instances).forEach(key => {
                        this.destroyChart(key);
                    });
                    this.instances = {};

                    // Remove all zoom controls
                    document.querySelectorAll('.zoom-controls').forEach(control => {
                        control.remove();
                    });
                },

                updateActiveTab: function(tab) {
                    console.log('Tab clicked:', tab, 'Current:', this.activeTab);

                    // Always reset charts regardless of whether it's the same tab
                    this.activeTab = tab;
                    this.destroyAllCharts();

                    // Force reinitialize with a delay to ensure DOM is ready
                    setTimeout(() => {
                        this.init(true); // Force reset
                    }, 300);
                },

                forceRefresh: function() {
                    console.log('Force refreshing all charts');
                    this.destroyAllCharts();
                    setTimeout(() => {
                        this.init(true);
                    }, 200);
                }
            };

            // Global initialization tracking
            let initializationInProgress = false;

            // Initialize when DOM is ready
            document.addEventListener('DOMContentLoaded', function() {
                if (!initializationInProgress) {
                    console.log('DOM loaded, initializing chart manager');
                    initializationInProgress = true;
                    window.AuditResultChartManager.init().finally(() => {
                        initializationInProgress = false;
                    });
                }
            });

            // Handle Livewire updates
            document.addEventListener('livewire:updated', function() {
                console.log('Livewire updated, force refreshing charts');
                setTimeout(() => {
                    window.AuditResultChartManager.forceRefresh();
                }, 400);
            });

            // Enhanced tab click handling - always reset on any click
            document.addEventListener('click', function(e) {
                const tabButton = e.target.closest('button[wire\\:click*="setActiveTab"]');
                if (tabButton) {
                    const clickAttr = tabButton.getAttribute('wire:click');
                    const tabMatch = clickAttr.match(/setActiveTab\('([^']+)'\)/);
                    if (tabMatch) {
                        // Immediately update tab and reset charts
                        setTimeout(() => {
                            window.AuditResultChartManager.updateActiveTab(tabMatch[1]);
                        }, 100);
                    }
                }
            });

            // Cleanup on page unload
            window.addEventListener('beforeunload', function() {
                if (window.AuditResultChartManager) {
                    window.AuditResultChartManager.destroyAllCharts();
                }
            });

            // Handle window resize
            window.addEventListener('resize', function() {
                setTimeout(() => {
                    window.AuditResultChartManager.forceRefresh();
                }, 300);
            });

            // Expose global functions for manual control
            window.refreshCharts = function() {
                window.AuditResultChartManager.forceRefresh();
            };

            window.zoomAllCharts = function(factor) {
                Object.keys(window.AuditResultChartManager.instances).forEach(key => {
                    window.AuditResultChartManager.zoomChart(key, factor);
                });
            };

            window.resetAllZoom = function() {
                Object.keys(window.AuditResultChartManager.instances).forEach(key => {
                    window.AuditResultChartManager.resetZoom(key);
                });
            };

            // Add keyboard shortcuts for zoom
            document.addEventListener('keydown', function(e) {
                if (e.ctrlKey || e.metaKey) {
                    switch (e.key) {
                        case '=':
                        case '+':
                            e.preventDefault();
                            window.zoomAllCharts(1.1);
                            break;
                        case '-':
                            e.preventDefault();
                            window.zoomAllCharts(0.9);
                            break;
                        case '0':
                            e.preventDefault();
                            window.resetAllZoom();
                            break;
                    }
                }
            });

            // Global reset zoom function for compatibility
            window.resetZoom = function(chartId) {
                const chartKey = chartId.replace('Chart', '');
                if (window.AuditResultChartManager.instances[chartKey]) {
                    window.AuditResultChartManager.resetZoom(chartKey);
                }
            };
        </script>

        {{-- Chart Styles --}}
        <style>
            .chart-container {
                position: relative;
                width: 100% !important;
                height: 100% !important;
                min-height: 300px !important;
                display: block !important;
                overflow: visible !important;
                background: transparent;
            }

            .chart-container canvas {
                display: block !important;
                width: 100% !important;
                height: 100% !important;
                max-width: 100% !important;
                max-height: 100% !important;
                position: relative !important;
                top: auto !important;
                left: auto !important;
                z-index: 1;
                background: transparent;
            }

            .h-64 {
                height: 16rem !important;
            }

            .h-96 {
                height: 24rem !important;
            }

            @media (max-width: 768px) {
                .grid-cols-1.md\:grid-cols-4 {
                    grid-template-columns: repeat(2, 1fr);
                }

                .grid-cols-1.md\:grid-cols-3 {
                    grid-template-columns: repeat(1, 1fr);
                }

                .chart-container {
                    min-height: 250px !important;
                }
            }
        </style>
    </div>
</x-filament-panels::page>
