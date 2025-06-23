{{-- resources/views/filament/resources/review-indikator-resource/pages/review-auditor1.blade.php --}}
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
                        Review audit untuk periode {{ $assignment->periode->periode_name ?? '-' }}
                    </p>
                </div>
                <div class="text-right">
                    <div class="text-sm text-gray-500 dark:text-gray-400">
                        Status Pengisian:
                        <span
                            class="fi-badge inline-flex items-center justify-center gap-x-1 rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset fi-color-success bg-success-50 text-success-600 ring-success-600/10 dark:bg-success-400/10 dark:text-success-400 dark:ring-success-400/30">
                            Selesai
                        </span>
                    </div>
                </div>
            </div>
        </div>

        @php
            $conflicts = [];
            foreach($assignment->pengisianIndikators as $pengisian) {
                if ($pengisian->hasConflict()) {
                    $conflicts[] = $pengisian;
                }
            }
        @endphp
        
        @if(count($conflicts) > 0)
        <div class="fi-section-content-ctn bg-danger-50 dark:bg-danger-950 border border-danger-200 dark:border-danger-800 rounded-xl p-4">
            <div class="flex items-center space-x-2 mb-3">
                <svg class="w-5 h-5 text-danger-600 dark:text-danger-400" fill="currentColor" viewBox="0 0 20 20">
                    <path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>
                </svg>
                <h3 class="text-sm font-medium text-danger-800 dark:text-danger-200">Konflik Terdeteksi</h3>
            </div>
            <p class="text-sm text-danger-700 dark:text-danger-300">
                Terdapat {{ count($conflicts) }} item dengan temuan berbeda antara Anda dan Auditor 2. 
                Item dengan konflik akan ditandai dengan ikon peringatan (⚠️).
            </p>
        </div>
        @endif

        @if($assignment->assignAuditors)
        <div class="fi-section-content-ctn bg-info-50 dark:bg-info-950 border border-info-200 dark:border-info-800 rounded-xl p-4">
            <h3 class="text-sm font-medium text-info-800 dark:text-info-200 mb-2">Tim Audit</h3>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                @if($assignment->unitIndikator->auditeeUser)
                <div class="flex items-center space-x-2">
                    <div class="w-8 h-8 bg-info-100 dark:bg-info-800 rounded-full flex items-center justify-center">
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
                
                @if($assignment->assignAuditors->auditor1Relation)
                <div class="flex items-center space-x-2">
                    <div class="w-8 h-8 bg-info-100 dark:bg-info-800 rounded-full flex items-center justify-center">
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

                @if($assignment->assignAuditors->auditor2Relation)
                <div class="flex items-center space-x-2">
                    <div class="w-8 h-8 bg-primary-100 dark:bg-primary-800 rounded-full flex items-center justify-center">
                        <span class="text-xs font-medium text-primary-600 dark:text-primary-300">A2</span>
                    </div>
                    <div>
                        <p class="text-sm font-medium text-primary-900 dark:text-primary-100">
                            {{ $assignment->assignAuditors->auditor2Relation->name }}
                        </p>
                        <p class="text-xs text-primary-600 dark:text-primary-400">Auditor 2 (Anda)</p>
                    </div>
                </div>
                @endif
            </div>
        </div>
        @endif

        <div
            class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl">
            <div class="border-b border-gray-200 dark:border-gray-700">
                <nav class="-mb-px flex space-x-8 px-6" aria-label="Tabs">
                    <button wire:click="setActiveTab('review')"
                        class="@if ($activeTab === 'review') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z">
                                </path>
                            </svg>
                            Review Audit
                        </div>
                    </button>
                    <button wire:click="setActiveTab('analisis')"
                        class="@if ($activeTab === 'analisis') border-primary-500 text-primary-600 dark:text-primary-400 @else border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 dark:text-gray-400 dark:hover:text-gray-300 @endif whitespace-nowrap py-4 px-1 border-b-2 font-medium text-sm transition-colors duration-200">
                        <div class="flex items-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                    d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z">
                                </path>
                            </svg>
                            Analisis Pengisian
                            <span
                                class="ml-2 inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-primary-100 text-primary-800 dark:bg-primary-800 dark:text-primary-100">
                                {{ $statistik['percentage_completion'] ?? 0 }}%
                            </span>
                        </div>
                    </button>
                </nav>
            </div>
        </div>

        @if ($activeTab === 'review')
            <div
                class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl">
                <form wire:submit="save" class="space-y-6">
                    {{ $this->form }}
                    <div
                        class="flex items-center justify-between p-6 bg-gray-50 dark:bg-white/5 rounded-b-xl border-t border-gray-200 dark:border-white/10">
                        <div class="flex space-x-4">
                            <x-filament::button type="submit" wire:click="save" color="primary">
                                Simpan Review
                            </x-filament::button>
                        </div>
                        <div>
                            <x-filament::button tag="a" :href="App\Filament\Resources\ReviewIndikatorResource::getUrl('index')" color="gray" outlined>
                                Kembali
                            </x-filament::button>
                        </div>
                    </div>
                </form>
            </div>
        @elseif($activeTab === 'analisis')
            <div class="space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                    <div
                        class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <div
                                    class="w-12 h-12 bg-success-100 dark:bg-success-800 rounded-full flex items-center justify-center">
                                    <svg class="w-6 h-6 text-success-600 dark:text-success-300" fill="none"
                                        stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M5 13l4 4L19 7"></path>
                                    </svg>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Tercapai</p>
                                <p class="text-2xl font-bold text-success-600 dark:text-success-400">
                                    {{ $statistik['percentage_tercapai'] ?? 0 }}%
                                </p>
                                <p class="text-xs text-gray-500 dark:text-gray-400">{{ $statistik['tercapai'] ?? 0 }}
                                    item</p>
                            </div>
                        </div>
                    </div>

                    {{-- Tidak Tercapai --}}
                    <div
                        class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <div
                                    class="w-12 h-12 bg-danger-100 dark:bg-danger-800 rounded-full flex items-center justify-center">
                                    <svg class="w-6 h-6 text-danger-600 dark:text-danger-300" fill="none"
                                        stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M6 18L18 6M6 6l12 12"></path>
                                    </svg>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Tidak Tercapai</p>
                                <p class="text-2xl font-bold text-danger-600 dark:text-danger-400">
                                    {{ $statistik['percentage_tidak_tercapai'] ?? 0 }}%
                                </p>
                                <p class="text-xs text-gray-500 dark:text-gray-400">
                                    {{ $statistik['tidak_tercapai'] ?? 0 }} item</p>
                            </div>
                        </div>
                    </div>

                    {{-- Belum Diisi --}}
                    <div
                        class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-6">
                        <div class="flex items-center">
                            <div class="flex-shrink-0">
                                <div
                                    class="w-12 h-12 bg-warning-100 dark:bg-warning-800 rounded-full flex items-center justify-center">
                                    <svg class="w-6 h-6 text-warning-600 dark:text-warning-300" fill="none"
                                        stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                                            d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                    </svg>
                                </div>
                            </div>
                            <div class="ml-4 flex-1">
                                <p class="text-sm font-medium text-gray-600 dark:text-gray-400">Belum Diisi</p>
                                <p class="text-2xl font-bold text-warning-600 dark:text-warning-400">
                                    {{ $statistik['percentage_belum_diisi'] ?? 0 }}%
                                </p>
                                <p class="text-xs text-gray-500 dark:text-gray-400">
                                    {{ $statistik['belum_diisi'] ?? 0 }} item</p>
                            </div>
                        </div>
                    </div>
                </div>

                {{-- Charts Section --}}
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    {{-- Overview Pie Chart --}}
                    <div
                        class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-6">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
                            Distribusi Status Pengisian
                        </h3>
                        <div class="h-80 chart-container" data-chart="true">
                            <canvas id="overviewChart" role="img" aria-label="Distribusi Status Pengisian Chart"
                                data-chart-type="overview">
                            </canvas>
                        </div>
                    </div>

                    {{-- Completion Progress --}}
                    <div
                        class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-6">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-4">
                            Progress Pengisian
                        </h3>
                        <div class="space-y-4">
                            {{-- Overall Progress --}}
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span class="text-sm font-medium text-gray-700 dark:text-gray-300">Total
                                        Progress</span>
                                    <span
                                        class="text-sm text-gray-500 dark:text-gray-400">{{ $statistik['percentage_completion'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-3">
                                    <div class="bg-primary-600 h-3 rounded-full transition-all duration-300"
                                        style="width: {{ $statistik['percentage_completion'] ?? 0 }}%"></div>
                                </div>
                            </div>

                            {{-- Tercapai Progress --}}
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span
                                        class="text-sm font-medium text-success-700 dark:text-success-300">Tercapai</span>
                                    <span
                                        class="text-sm text-success-600 dark:text-success-400">{{ $statistik['percentage_tercapai'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                                    <div class="bg-success-500 h-2 rounded-full transition-all duration-300"
                                        style="width: {{ $statistik['percentage_tercapai'] ?? 0 }}%"></div>
                                </div>
                            </div>

                            {{-- Tidak Tercapai Progress --}}
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span class="text-sm font-medium text-danger-700 dark:text-danger-300">Tidak
                                        Tercapai</span>
                                    <span
                                        class="text-sm text-danger-600 dark:text-danger-400">{{ $statistik['percentage_tidak_tercapai'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                                    <div class="bg-danger-500 h-2 rounded-full transition-all duration-300"
                                        style="width: {{ $statistik['percentage_tidak_tercapai'] ?? 0 }}%"></div>
                                </div>
                            </div>

                            {{-- Belum Diisi Progress --}}
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <span class="text-sm font-medium text-warning-700 dark:text-warning-300">Belum
                                        Diisi</span>
                                    <span
                                        class="text-sm text-warning-600 dark:text-warning-400">{{ $statistik['percentage_belum_diisi'] ?? 0 }}%</span>
                                </div>
                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2">
                                    <div class="bg-warning-500 h-2 rounded-full transition-all duration-300"
                                        style="width: {{ $statistik['percentage_belum_diisi'] ?? 0 }}%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                {{-- Analysis by Standar Chart --}}
                <div
                    class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-6">
                    <h3 class="text-lg font-semibold text-gray-900 dark:text-white mb-6">
                        Analisis per Standar
                    </h3>
                    <div class="h-96 chart-container" data-chart="true">
                        <canvas id="standarChart" role="img" aria-label="Analisis per Standar Chart"
                            data-chart-type="standard">
                        </canvas>
                    </div>
                </div>

                {{-- Analysis by Sub Standar Chart --}}
                <div
                    class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl p-6">
                    <div class="flex items-center justify-between mb-6">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Analisis per Sub Standar
                        </h3>
                        {{-- Chart Type Toggle --}}
                        <div class="flex items-center space-x-2">
                            <label class="text-sm text-gray-600 dark:text-gray-400">Tampilan:</label>
                            <select id="subStandarChartType"
                                class="text-sm border rounded px-2 py-1 bg-white dark:bg-gray-800 border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300">
                                <option value="bar">Bar Chart</option>
                                <option value="horizontalBar">Horizontal Bar</option>
                                <option value="line">Line Chart</option>
                            </select>
                        </div>
                    </div>

                    {{-- Chart Container with Scroll for Many Items --}}
                    <div class="relative">
                        <div class="h-96 chart-container overflow-x-auto" data-chart="true"
                            style="min-height: 600px;">
                            <canvas id="subStandarChart" role="img" aria-label="Analisis per Sub Standar Chart"
                                data-chart-type="sub-standard">
                            </canvas>
                        </div>
                    </div>

                    {{-- Chart Legend/Info --}}
                    <div class="mt-4 text-xs text-gray-500 dark:text-gray-400">
                        <p>💡 <strong>Tips:</strong> Gunakan mouse wheel untuk scroll jika ada banyak sub standar. Hover
                            pada chart untuk detail lengkap.</p>
                    </div>
                </div>

                {{-- Standar Analysis Table --}}
                <div
                    class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl">
                    <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Detail Statistik per Standar
                        </h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tercapai
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Persentase
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tidak Tercapai
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Persentase
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Progress
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($chartData['standar'] ?? [] as $standar)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4">
                                            <div class="text-sm font-medium text-gray-900 dark:text-white">
                                                {{ $standar['name'] }}
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span
                                                class="text-sm font-medium text-gray-900 dark:text-white">{{ $standar['total'] }}</span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span
                                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-success-100 text-success-800 dark:bg-success-800 dark:text-success-100">
                                                {{ $standar['tercapai'] }}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span class="text-sm font-semibold text-success-600 dark:text-success-400">
                                                {{ $standar['percentage_tercapai'] ?? 0 }}%
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span
                                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-danger-100 text-danger-800 dark:bg-danger-800 dark:text-danger-100">
                                                {{ $standar['tidak_tercapai'] }}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span class="text-sm font-semibold text-danger-600 dark:text-danger-400">
                                                {{ $standar['percentage_tidak_tercapai'] ?? 0 }}%
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            @php
                                                $completion =
                                                    $standar['total'] > 0
                                                        ? round(
                                                            (($standar['tercapai'] + $standar['tidak_tercapai']) /
                                                                $standar['total']) *
                                                                100,
                                                            2,
                                                        )
                                                        : 0;
                                            @endphp
                                            <div class="flex items-center">
                                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2 mr-3">
                                                    <div class="bg-primary-600 h-2 rounded-full"
                                                        style="width: {{ $completion }}%"></div>
                                                </div>
                                                <span
                                                    class="text-xs text-gray-500 dark:text-gray-400 min-w-[45px]">{{ $completion }}%</span>
                                            </div>
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>

                <div
                    class="fi-section-content-ctn bg-white shadow-sm ring-1 ring-gray-950/5 dark:bg-gray-900 dark:ring-white/10 rounded-xl">
                    <div class="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
                        <h3 class="text-lg font-semibold text-gray-900 dark:text-white">
                            Detail Statistik per Sub Standar
                        </h3>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full divide-y divide-gray-200 dark:divide-gray-700">
                            <thead class="bg-gray-50 dark:bg-gray-800">
                                <tr>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Sub Standar
                                    </th>
                                    <th
                                        class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Standar
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Total
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tercapai
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Persentase
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Tidak Tercapai
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Persentase
                                    </th>
                                    <th
                                        class="px-6 py-3 text-center text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
                                        Progress
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                                @foreach ($chartData['sub_standar'] ?? [] as $subStandar)
                                    <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                        <td class="px-6 py-4">
                                            <div class="text-sm font-medium text-gray-900 dark:text-white">
                                                {{ $subStandar['name'] }}
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="text-sm text-gray-600 dark:text-gray-400">
                                                {{ Str::limit($subStandar['standar'], 40) }}
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span
                                                class="text-sm font-medium text-gray-900 dark:text-white">{{ $subStandar['total'] }}</span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span
                                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-success-100 text-success-800 dark:bg-success-800 dark:text-success-100">
                                                {{ $subStandar['tercapai'] }}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span class="text-sm font-semibold text-success-600 dark:text-success-400">
                                                {{ $subStandar['percentage_tercapai'] ?? 0 }}%
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span
                                                class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-danger-100 text-danger-800 dark:bg-danger-800 dark:text-danger-100">
                                                {{ $subStandar['tidak_tercapai'] }}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-center">
                                            <span class="text-sm font-semibold text-danger-600 dark:text-danger-400">
                                                {{ $subStandar['percentage_tidak_tercapai'] ?? 0 }}%
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            @php
                                                $completion =
                                                    $subStandar['total'] > 0
                                                        ? round(
                                                            (($subStandar['tercapai'] + $subStandar['tidak_tercapai']) /
                                                                $subStandar['total']) *
                                                                100,
                                                            2,
                                                        )
                                                        : 0;
                                            @endphp
                                            <div class="flex items-center">
                                                <div class="w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2 mr-3">
                                                    <div class="bg-primary-600 h-2 rounded-full"
                                                        style="width: {{ $completion }}%"></div>
                                                </div>
                                                <span
                                                    class="text-xs text-gray-500 dark:text-gray-400 min-w-[45px]">{{ $completion }}%</span>
                                            </div>
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        @endif

        <div class="fi-section-content-ctn bg-gray-50 dark:bg-white/5 rounded-xl p-6">
            <h3 class="text-base font-semibold leading-6 text-gray-950 dark:text-white mb-4">
                @if ($activeTab === 'review')
                    Panduan Review Auditor 1
                @else
                    Panduan Analisis
                @endif
            </h3>

            @if ($activeTab === 'review')
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Temuan</h4>
                        <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                            <li>• Pilih "Sesuai" jika bukti mendukung pencapaian</li>
                            <li>• Pilih "Tidak Sesuai" jika ada kekurangan</li>
                            <li>• Berikan pengamatan yang objektif dan detail</li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Hasil Pengamatan</h4>
                        <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                            <li>• Jelaskan basis temuan secara detail</li>
                            <li>• Berikan rekomendasi untuk perbaikan</li>
                            <li>• Gunakan bahasa yang profesional dan konstruktif</li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Kolaborasi</h4>
                        <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                            <li>• Anda dapat melihat review Auditor 2 jika sudah ada</li>
                            <li>• Perbedaan temuan akan ditandai sebagai konflik</li>
                            <li>• Diskusikan dengan Auditor 2 jika ada perbedaan</li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Proses</h4>
                        <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                            <li>• Review dapat disimpan sebagai draft</li>
                            <li>• Data tersimpan otomatis saat mengisi</li>
                            <li>• Anda dapat mengedit review kapan saja</li>
                        </ul>
                    </div>
                </div>
            @else
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Statistik</h4>
                        <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                            <li>• Persentase dihitung dengan presisi 2 desimal</li>
                            <li>• Tingkat penyelesaian = (Tercapai + Tidak Tercapai) / Total</li>
                            <li>• Data dikelompokkan berdasarkan standar dan sub standar</li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Charts</h4>
                        <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                            <li>• Pie chart menunjukkan distribusi status keseluruhan</li>
                            <li>• Bar chart menampilkan breakdown per standar</li>
                            <li>• Sub standar chart dengan multiple view options</li>
                            <li>• Hover pada chart untuk melihat detail</li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Tabel Detail</h4>
                        <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                            <li>• Tabel standar menunjukkan agregasi per standar</li>
                            <li>• Tabel sub standar memberikan breakdown lebih detail</li>
                            <li>• Progress bar menunjukkan tingkat penyelesaian</li>
                        </ul>
                    </div>
                    <div>
                        <h4 class="text-sm font-medium text-gray-950 dark:text-white mb-2">Interpretasi</h4>
                        <ul class="text-sm text-gray-500 dark:text-gray-400 space-y-1">
                            <li>• Hijau: Item yang sudah tercapai</li>
                            <li>• Merah: Item yang tidak tercapai</li>
                            <li>• Abu-abu: Item yang belum diisi</li>
                        </ul>
                    </div>
                </div>
            @endif
        </div>
    </div>

    {{-- Stable Chart JavaScript - Anti Disappearing Solution --}}
    <script>
        // Global Chart Management System
        window.ChartManager = {
            instances: {},
            data: @json($chartData),
            activeTab: '{{ $activeTab }}',
            initialized: false,
            initAttempts: 0,
            maxAttempts: 10,
            isInitializing: false,
            observers: {},

            // Debounced initialization to prevent multiple rapid calls
            debouncedInit: null,

            init() {
                // Clear any existing debounced call
                if (this.debouncedInit) {
                    clearTimeout(this.debouncedInit);
                }

                // Debounce initialization to prevent rapid calls
                this.debouncedInit = setTimeout(() => {
                    this.initializeCharts();
                }, 150);
            },

            // Load Chart.js with better error handling
            loadChartJS() {
                return new Promise((resolve, reject) => {
                    if (typeof Chart !== 'undefined') {
                        resolve();
                        return;
                    }

                    const script = document.createElement('script');
                    script.src = 'https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js';
                    script.onload = () => {
                        console.log('✓ Chart.js loaded successfully');
                        resolve();
                    };
                    script.onerror = () => {
                        console.error('✗ Failed to load Chart.js');
                        reject(new Error('Chart.js failed to load'));
                    };
                    document.head.appendChild(script);
                });
            },

            // Enhanced canvas readiness check
            canvasReady() {
                const canvases = {
                    overview: document.getElementById('overviewChart'),
                    standard: document.getElementById('standarChart'),
                    subStandard: document.getElementById('subStandarChart')
                };

                const ready = Object.keys(canvases).every(key => {
                    const canvas = canvases[key];
                    return canvas &&
                        canvas.parentNode &&
                        canvas.getContext &&
                        canvas.offsetParent !== null &&
                        canvas.clientWidth > 0 &&
                        canvas.clientHeight > 0 &&
                        !canvas.hasAttribute('data-chart-destroyed');
                });

                console.log('Canvas readiness check:', ready);
                return ready;
            },

            // Create chart with persistence protection
            createChart(type, canvasId, config) {
                const canvas = document.getElementById(canvasId);
                if (!canvas || !canvas.getContext) {
                    console.warn(`Canvas ${canvasId} not ready for chart creation`);
                    return null;
                }

                // Destroy existing chart instance
                if (this.instances[type]) {
                    try {
                        this.instances[type].destroy();
                        console.log(`✓ Destroyed existing ${type} chart`);
                    } catch (e) {
                        console.warn(`Warning destroying ${type} chart:`, e);
                    }
                    this.instances[type] = null;
                }

                try {
                    const ctx = canvas.getContext('2d');
                    ctx.clearRect(0, 0, canvas.width, canvas.height);

                    // Mark canvas as active
                    canvas.removeAttribute('data-chart-destroyed');
                    canvas.setAttribute('data-chart-active', 'true');

                    this.instances[type] = new Chart(ctx, config);
                    console.log(`✓ Created ${type} chart successfully`);

                    // Add mutation observer to watch for canvas removal
                    this.observeCanvas(canvas, type);

                    // Add resize observer
                    if (!canvas._chartResizeObserver) {
                        canvas._chartResizeObserver = new ResizeObserver(() => {
                            if (this.instances[type] && canvas.offsetParent !== null) {
                                this.instances[type].resize();
                            }
                        });
                        canvas._chartResizeObserver.observe(canvas);
                    }

                    return this.instances[type];
                } catch (error) {
                    console.error(`✗ Error creating ${type} chart:`, error);
                    return null;
                }
            },

            // Observe canvas for removal/changes
            observeCanvas(canvas, type) {
                if (this.observers[type]) {
                    this.observers[type].disconnect();
                }

                this.observers[type] = new MutationObserver((mutations) => {
                    mutations.forEach((mutation) => {
                        // Check if canvas was removed
                        if (mutation.type === 'childList') {
                            mutation.removedNodes.forEach((node) => {
                                if (node === canvas || (node.contains && node.contains(
                                    canvas))) {
                                    console.log(
                                        `Canvas ${type} was removed, marking for recreation`
                                        );
                                    canvas.setAttribute('data-chart-destroyed', 'true');
                                    if (this.instances[type]) {
                                        this.instances[type].destroy();
                                        this.instances[type] = null;
                                    }
                                }
                            });
                        }
                    });
                });

                // Observe the canvas parent for changes
                if (canvas.parentNode) {
                    this.observers[type].observe(canvas.parentNode, {
                        childList: true,
                        subtree: true
                    });
                }
            },

            // Create overview chart
            createOverviewChart() {
                const data = this.data.overview || [];
                if (data.length === 0) {
                    console.warn('No overview data available');
                    return;
                }

                const config = {
                    type: 'doughnut',
                    data: {
                        labels: data.map(item => item.status),
                        datasets: [{
                            data: data.map(item => item.count),
                            backgroundColor: data.map(item => item.color),
                            borderWidth: 2,
                            borderColor: '#ffffff'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        animation: {
                            duration: 600,
                            animateRotate: true,
                            animateScale: true
                        },
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    usePointStyle: true,
                                    padding: 15,
                                    font: {
                                        size: 11
                                    }
                                }
                            },
                            tooltip: {
                                callbacks: {
                                    label: function(context) {
                                        const item = data[context.dataIndex];
                                        return `${item.status}: ${item.count} (${item.percentage}%)`;
                                    }
                                }
                            }
                        }
                    }
                };

                return this.createChart('overview', 'overviewChart', config);
            },

            // Create standard chart
            createStandardChart() {
                const data = this.data.standar || [];
                if (data.length === 0) {
                    console.warn('No standard data available');
                    return;
                }

                const config = {
                    type: 'bar',
                    data: {
                        labels: data.map(item => item.name.length > 25 ? item.name.substring(0, 25) + '...' : item
                            .name),
                        datasets: [{
                                label: 'Tercapai',
                                data: data.map(item => item.tercapai),
                                backgroundColor: '#10B981',
                                borderWidth: 1
                            },
                            {
                                label: 'Tidak Tercapai',
                                data: data.map(item => item.tidak_tercapai),
                                backgroundColor: '#EF4444',
                                borderWidth: 1
                            },
                            {
                                label: 'Belum Diisi',
                                data: data.map(item => item.belum_diisi),
                                backgroundColor: '#6B7280',
                                borderWidth: 1
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        animation: {
                            duration: 600
                        },
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
                            legend: {
                                position: 'top'
                            },
                            tooltip: {
                                callbacks: {
                                    afterLabel: function(context) {
                                        const item = data[context.dataIndex];
                                        const percentage = item.total > 0 ? Math.round((context.parsed.y / item
                                            .total) * 100) : 0;
                                        return `Persentase: ${percentage}%`;
                                    }
                                }
                            }
                        }
                    }
                };

                return this.createChart('standard', 'standarChart', config);
            },

            // Create sub standard chart
            createSubStandardChart(chartType = 'bar') {
                const data = this.data.sub_standar || [];
                if (data.length === 0) {
                    console.warn('No sub standard data available');
                    return;
                }

                let config = {
                    type: chartType === 'horizontalBar' ? 'bar' : chartType,
                    data: {
                        labels: data.map(item => item.name.length > 20 ? item.name.substring(0, 20) + '...' : item
                            .name),
                        datasets: [{
                                label: 'Tercapai',
                                data: data.map(item => item.tercapai),
                                backgroundColor: '#10B981',
                                borderWidth: 1
                            },
                            {
                                label: 'Tidak Tercapai',
                                data: data.map(item => item.tidak_tercapai),
                                backgroundColor: '#EF4444',
                                borderWidth: 1
                            },
                            {
                                label: 'Belum Diisi',
                                data: data.map(item => item.belum_diisi),
                                backgroundColor: '#6B7280',
                                borderWidth: 1
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        animation: {
                            duration: 600
                        },
                        plugins: {
                            legend: {
                                position: 'top'
                            },
                            tooltip: {
                                callbacks: {
                                    title: function(context) {
                                        const item = data[context[0].dataIndex];
                                        return `${item.name}\nStandar: ${item.standar}`;
                                    }
                                }
                            }
                        }
                    }
                };

                // Configure based on chart type
                if (chartType === 'horizontalBar') {
                    config.options.indexAxis = 'y';
                    config.options.scales = {
                        x: {
                            stacked: true,
                            beginAtZero: true
                        },
                        y: {
                            stacked: true
                        }
                    };
                } else if (chartType === 'line') {
                    config.data.datasets = [{
                            label: 'Persentase Tercapai',
                            data: data.map(item => item.percentage_tercapai || 0),
                            borderColor: '#10B981',
                            backgroundColor: 'rgba(16, 185, 129, 0.1)',
                            tension: 0.4,
                            fill: true
                        },
                        {
                            label: 'Persentase Tidak Tercapai',
                            data: data.map(item => item.percentage_tidak_tercapai || 0),
                            borderColor: '#EF4444',
                            backgroundColor: 'rgba(239, 68, 68, 0.1)',
                            tension: 0.4,
                            fill: true
                        }
                    ];
                    config.options.scales = {
                        x: {
                            ticks: {
                                maxRotation: 45
                            }
                        },
                        y: {
                            beginAtZero: true,
                            max: 100,
                            ticks: {
                                callback: v => v + '%'
                            }
                        }
                    };
                } else {
                    config.options.scales = {
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
                    };
                }

                return this.createChart('subStandard', 'subStandarChart', config);
            },

            // Enhanced initialization with protection
            async initializeCharts() {
                if (this.activeTab !== 'analisis') {
                    console.log('Not on analisis tab, skipping chart initialization');
                    return;
                }

                if (this.isInitializing) {
                    console.log('Already initializing, skipping...');
                    return;
                }

                if (this.initAttempts >= this.maxAttempts) {
                    console.error('Max initialization attempts reached');
                    return;
                }

                this.isInitializing = true;
                this.initAttempts++;
                console.log(`Chart initialization attempt ${this.initAttempts}/${this.maxAttempts}`);

                try {
                    // Ensure Chart.js is loaded
                    await this.loadChartJS();

                    // Wait for canvas elements to be ready
                    if (!this.canvasReady()) {
                        console.log('Canvas elements not ready, retrying...');
                        this.isInitializing = false;
                        setTimeout(() => this.init(), 300);
                        return;
                    }

                    // Add loading indicators
                    this.showLoadingIndicators();

                    // Create charts with small delays to prevent conflicts
                    console.log('Creating charts...');
                    this.createOverviewChart();

                    await new Promise(resolve => setTimeout(resolve, 50));
                    this.createStandardChart();

                    await new Promise(resolve => setTimeout(resolve, 50));
                    this.createSubStandardChart();

                    // Setup interactions
                    this.setupInteractions();

                    // Remove loading indicators
                    this.hideLoadingIndicators();

                    this.initialized = true;
                    this.initAttempts = 0;
                    this.isInitializing = false;
                    console.log('✓ All charts initialized successfully');

                    // Start monitoring
                    this.startMonitoring();

                } catch (error) {
                    console.error('✗ Chart initialization failed:', error);
                    this.isInitializing = false;
                    this.hideLoadingIndicators();
                    setTimeout(() => this.init(), 1000);
                }
            },

            // Show loading indicators
            showLoadingIndicators() {
                const canvases = ['overviewChart', 'standarChart', 'subStandarChart'];
                canvases.forEach(id => {
                    const canvas = document.getElementById(id);
                    if (canvas && canvas.parentNode) {
                        const container = canvas.closest('.chart-container');
                        if (container && !container.querySelector('.chart-loading-indicator')) {
                            const loader = document.createElement('div');
                            loader.className = 'chart-loading-indicator';
                            loader.style.cssText = `
                        position: absolute;
                        top: 50%;
                        left: 50%;
                        transform: translate(-50%, -50%);
                        color: #6B7280;
                        font-size: 14px;
                        z-index: 10;
                        pointer-events: none;
                    `;
                            loader.textContent = '📊 Loading chart...';
                            container.appendChild(loader);
                        }
                    }
                });
            },

            // Hide loading indicators
            hideLoadingIndicators() {
                document.querySelectorAll('.chart-loading-indicator').forEach(el => el.remove());
            },

            // Setup chart interactions
            setupInteractions() {
                const selector = document.getElementById('subStandarChartType');
                if (selector && !selector._chartManagerListener) {
                    selector.addEventListener('change', (e) => {
                        console.log('Chart type changed to:', e.target.value);
                        this.createSubStandardChart(e.target.value);
                    });
                    selector._chartManagerListener = true;
                }
            },

            // Start monitoring for disappearing charts
            startMonitoring() {
                // Clear existing monitor
                if (this.monitorInterval) {
                    clearInterval(this.monitorInterval);
                }

                this.monitorInterval = setInterval(() => {
                    if (this.activeTab === 'analisis' && this.initialized && !this.isInitializing) {
                        const missingCharts = this.checkMissingCharts();
                        if (missingCharts.length > 0) {
                            console.log('Detected missing charts:', missingCharts, '- Recreating...');
                            this.recreateMissingCharts(missingCharts);
                        }
                    }
                }, 1000);
            },

            // Check for missing charts
            checkMissingCharts() {
                const charts = [{
                        type: 'overview',
                        canvasId: 'overviewChart'
                    },
                    {
                        type: 'standard',
                        canvasId: 'standarChart'
                    },
                    {
                        type: 'subStandard',
                        canvasId: 'subStandarChart'
                    }
                ];

                return charts.filter(chart => {
                    const canvas = document.getElementById(chart.canvasId);
                    return canvas &&
                        canvas.offsetParent !== null &&
                        !canvas.hasAttribute('data-chart-destroyed') &&
                        !this.instances[chart.type];
                });
            },

            // Recreate missing charts
            recreateMissingCharts(missingCharts) {
                missingCharts.forEach(chart => {
                    console.log(`Recreating ${chart.type} chart...`);
                    switch (chart.type) {
                        case 'overview':
                            this.createOverviewChart();
                            break;
                        case 'standard':
                            this.createStandardChart();
                            break;
                        case 'subStandard':
                            const selector = document.getElementById('subStandarChartType');
                            const type = selector ? selector.value : 'bar';
                            this.createSubStandardChart(type);
                            break;
                    }
                });
            },

            // Stop monitoring
            stopMonitoring() {
                if (this.monitorInterval) {
                    clearInterval(this.monitorInterval);
                    this.monitorInterval = null;
                }
            },

            // Destroy all charts
            destroyCharts() {
                this.stopMonitoring();

                Object.keys(this.instances).forEach(type => {
                    if (this.instances[type]) {
                        try {
                            this.instances[type].destroy();
                            console.log(`✓ Destroyed ${type} chart`);
                        } catch (e) {
                            console.warn(`Warning destroying ${type} chart:`, e);
                        }
                        this.instances[type] = null;
                    }

                    // Disconnect observers
                    if (this.observers[type]) {
                        this.observers[type].disconnect();
                        this.observers[type] = null;
                    }
                });

                // Mark canvases as destroyed
                ['overviewChart', 'standarChart', 'subStandarChart'].forEach(id => {
                    const canvas = document.getElementById(id);
                    if (canvas) {
                        canvas.setAttribute('data-chart-destroyed', 'true');
                        canvas.removeAttribute('data-chart-active');
                    }
                });

                this.hideLoadingIndicators();
                this.initialized = false;
                this.initAttempts = 0;
                this.isInitializing = false;
                console.log('✓ All charts destroyed');
            },

            // Update data and reinitialize
            updateData(newData) {
                console.log('Updating chart data...');
                this.data = newData;
                this.destroyCharts();
                setTimeout(() => this.init(), 200);
            },

            // Force reinitialize
            forceReinit() {
                console.log('Force reinitializing charts...');
                this.destroyCharts();
                this.activeTab = 'analisis';
                setTimeout(() => this.init(), 300);
            }
        };

        // Event Handlers
        function handleTabSwitch() {
            setTimeout(() => {
                const activeButton = document.querySelector(
                    'button[wire\\:click*="setActiveTab"][class*="border-primary-500"]');
                if (activeButton) {
                    const isAnalisisTab = activeButton.textContent.includes('Analisis');
                    window.ChartManager.activeTab = isAnalisisTab ? 'analisis' : 'review';

                    if (isAnalisisTab) {
                        console.log('Switched to analisis tab');
                        setTimeout(() => window.ChartManager.init(), 200);
                    } else {
                        console.log('Left analisis tab');
                        window.ChartManager.destroyCharts();
                    }
                }
            }, 100);
        }

        // Initialize when DOM is ready
        document.addEventListener('DOMContentLoaded', () => {
            console.log('DOM ready, initializing ChartManager...');
            if (window.ChartManager.activeTab === 'analisis') {
                window.ChartManager.init();
            }
        });

        // Handle Livewire updates
        document.addEventListener('livewire:updated', () => {
            console.log('Livewire updated - checking charts...');
            handleTabSwitch();
        });

        // Handle tab clicks
        document.addEventListener('click', (e) => {
            const tabButton = e.target.closest('button[wire\\:click*="setActiveTab"]');
            if (tabButton && tabButton.textContent.includes('Analisis')) {
                console.log('Analisis tab clicked');
                setTimeout(() => {
                    window.ChartManager.activeTab = 'analisis';
                    window.ChartManager.init();
                }, 300);
            }
        });

        // Cleanup on page unload
        window.addEventListener('beforeunload', () => {
            window.ChartManager.destroyCharts();
        });

        // Global debug functions
        window.debugCharts = () => window.ChartManager.debug();
        window.reinitCharts = () => window.ChartManager.forceReinit();
        window.updateChartData = (data) => window.ChartManager.updateData(data);
    </script>
    <style>
        /* Chart container with stable positioning */
        .chart-container {
            position: relative;
            width: 100%;
            height: 100%;
            display: block;
            overflow: hidden;
            /* Prevent layout shifts */
            contain: layout style;
        }

        /* Fixed height containers to prevent disappearing */
        .h-80 {
            height: 20rem !important;
            min-height: 320px !important;
            max-height: 20rem !important;
            position: relative;
            display: block;
            /* Force stable dimensions */
            box-sizing: border-box;
        }

        .h-96 {
            height: 24rem !important;
            min-height: 384px !important;
            max-height: 24rem !important;
            position: relative;
            display: block;
            /* Force stable dimensions */
            box-sizing: border-box;
        }

        /* Canvas elements with forced dimensions */
        canvas {
            display: block !important;
            box-sizing: border-box !important;
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 100% !important;
            /* Prevent disappearing */
            opacity: 1 !important;
            visibility: visible !important;
            pointer-events: auto !important;
        }

        /* Specific canvas styling */
        #overviewChart,
        #standarChart,
        #subStandarChart {
            /* Force visibility and dimensions */
            display: block !important;
            position: absolute !important;
            top: 0 !important;
            left: 0 !important;
            width: 100% !important;
            height: 100% !important;
            min-width: 200px !important;
            min-height: 200px !important;
        }

        /* Sub standard chart container */
        .chart-container[data-chart="true"]:has(#subStandarChart) {
            min-height: 600px !important;
            height: 600px !important;
        }

        /* Chart type selector styling */
        #subStandarChartType {
            @apply text-sm border rounded px-2 py-1 bg-white dark:bg-gray-800 border-gray-300 dark:border-gray-600 text-gray-700 dark:text-gray-300;
            transition: all 0.2s ease-in-out;
            /* Prevent layout shift */
            min-width: 120px;
        }

        #subStandarChartType:focus {
            @apply ring-2 ring-primary-500 border-primary-500 outline-none;
        }

        /* Container sizing with forced minimums */
        .fi-section-content-ctn:has(canvas) {
            min-height: 400px !important;
            /* Prevent collapse */
            contain: layout;
        }

        .fi-section-content-ctn:has(#subStandarChart) {
            min-height: 650px !important;
            /* Extra space for sub standard chart */
            contain: layout;
        }

        /* Anti-disappearing classes */
        [data-chart="true"] {
            position: relative !important;
            display: block !important;
            width: 100% !important;
            height: 100% !important;
            /* Stability insurance */
            min-height: inherit !important;
            contain: layout style;
        }

        [data-chart="true"]::before {
            content: "";
            display: block;
            width: 100%;
            height: 100%;
            position: absolute;
            top: 0;
            left: 0;
            z-index: -1;
            /* Background to maintain space */
            background: transparent;
            pointer-events: none;
        }

        /* Loading state for charts */
        .chart-loading {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #6B7280;
            font-size: 14px;
            z-index: 1;
        }

        .chart-loading::before {
            content: "📊 Loading chart...";
        }

        /* Error state */
        .chart-error {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #EF4444;
            font-size: 14px;
            z-index: 1;
        }

        .chart-error::before {
            content: "⚠️ Chart error";
        }

        /* Progress bar styling */
        .progress-bar {
            transition: width 0.3s ease-in-out;
        }

        /* Table hover effects */
        tbody tr:hover {
            background-color: rgba(0, 0, 0, 0.02);
        }

        .dark tbody tr:hover {
            background-color: rgba(255, 255, 255, 0.02);
        }

        /* Tab button styling */
        button[wire\:click*="setActiveTab"] {
            transition: all 0.2s ease-in-out;
        }

        button[wire\:click*="setActiveTab"]:hover {
            background-color: rgba(0, 0, 0, 0.02);
        }

        .dark button[wire\:click*="setActiveTab"]:hover {
            background-color: rgba(255, 255, 255, 0.02);
        }

        /* Tab content with stable transitions */
        .tab-content {
            animation: fadeIn 0.3s ease-in-out;
            /* Prevent content jumping */
            contain: layout;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Mobile responsive with stable dimensions */
        @media (max-width: 768px) {
            .grid-cols-1.md\:grid-cols-4 {
                grid-template-columns: repeat(2, 1fr);
            }

            .h-80 {
                height: 16rem !important;
                min-height: 256px !important;
                max-height: 16rem !important;
            }

            .h-96 {
                height: 20rem !important;
                min-height: 320px !important;
                max-height: 20rem !important;
            }

            .px-6 {
                padding-left: 1rem;
                padding-right: 1rem;
            }

            /* Mobile chart adjustments */
            #subStandarChart {
                min-height: 400px !important;
            }

            .fi-section-content-ctn:has(#subStandarChart) {
                min-height: 450px !important;
            }

            /* Responsive chart type selector */
            @media (max-width: 480px) {
                .flex.items-center.justify-between {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 0.5rem;
                }

                #subStandarChartType {
                    min-width: 100px;
                    font-size: 12px;
                }
            }
        }

        /* Enhanced scrollbar for chart containers */
        .chart-container::-webkit-scrollbar {
            height: 8px;
            width: 8px;
        }

        .chart-container::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 4px;
        }

        .chart-container::-webkit-scrollbar-thumb {
            background: #c1c1c1;
            border-radius: 4px;
        }

        .chart-container::-webkit-scrollbar-thumb:hover {
            background: #a1a1a1;
        }

        .dark .chart-container::-webkit-scrollbar-track {
            background: #374151;
        }

        .dark .chart-container::-webkit-scrollbar-thumb {
            background: #6B7280;
        }

        .dark .chart-container::-webkit-scrollbar-thumb:hover {
            background: #9CA3AF;
        }

        /* Force hardware acceleration for smooth rendering */
        .chart-container,
        canvas {
            transform: translateZ(0);
            backface-visibility: hidden;
            perspective: 1000px;
        }

        /* Prevent text selection on charts */
        .chart-container {
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        /* Loading animation */
        @keyframes chartPulse {

            0%,
            100% {
                opacity: 1;
            }

            50% {
                opacity: 0.7;
            }
        }

        .chart-loading-animation {
            animation: chartPulse 1.5s ease-in-out infinite;
        }

        /* Dark mode chart adjustments */
        .dark .chart-loading {
            color: #9CA3AF;
        }

        .dark .chart-error {
            color: #F87171;
        }

        /* Chart stability insurance - prevents any layout shifts */
        .fi-section-content-ctn {
            /* Prevent container collapse */
            min-height: fit-content;
            contain: layout;
        }

        .fi-section-content-ctn .chart-container {
            /* Additional stability for chart containers */
            flex-shrink: 0;
            isolation: isolate;
        }

        /* Ensure charts maintain space even when destroyed */
        .chart-container:empty {
            min-height: inherit;
            background: rgba(0, 0, 0, 0.01);
            /* Minimal background to maintain space */
        }

        .chart-container:empty::after {
            content: "Chart loading...";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #6B7280;
            font-size: 14px;
            opacity: 0.7;
        }

        .dark .chart-container:empty::after {
            color: #9CA3AF;
        }
    </style>
</x-filament-panels::page>
