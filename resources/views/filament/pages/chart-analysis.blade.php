{{-- resources/views/filament/resources/pages/chart-analysis.blade.php --}}
<x-filament-panels::page>
    <div class="space-y-6">
        {{-- Header Section --}}
        <x-filament::section>
            <x-slot name="heading">
                Analisis Ketercapaian Standar
            </x-slot>
            <x-slot name="description">
                Analisis visual ketercapaian standar berdasarkan hasil audit pengisian auditee dan review auditor
            </x-slot>

            {{-- Filters Section --}}
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
                <div class="space-y-2">
                    <label class="text-sm font-medium text-gray-700 dark:text-gray-300">Periode</label>
                    <select wire:model.live="selectedPeriode" 
                            class="w-full rounded-lg border-gray-300 dark:border-gray-600 dark:bg-gray-800 dark:text-white">
                        <option value="">Semua Periode</option>
                        @foreach($periodes as $periode)
                            <option value="{{ $periode['id'] }}">{{ $periode['periode_name'] }}</option>
                        @endforeach
                    </select>
                </div>

                <div class="space-y-2">
                    <label class="text-sm font-medium text-gray-700 dark:text-gray-300">Unit</label>
                    <select wire:model.live="selectedUnit" 
                            class="w-full rounded-lg border-gray-300 dark:border-gray-600 dark:bg-gray-800 dark:text-white">
                        <option value="">Semua Unit</option>
                        @foreach($units as $unit)
                            <option value="{{ $unit['id'] }}">{{ $unit['nama_unit'] }}</option>
                        @endforeach
                    </select>
                </div>

                <div class="space-y-2">
                    <label class="text-sm font-medium text-gray-700 dark:text-gray-300">Standar</label>
                    <select wire:model.live="selectedStandar" 
                            class="w-full rounded-lg border-gray-300 dark:border-gray-600 dark:bg-gray-800 dark:text-white">
                        <option value="">Semua Standar</option>
                        @foreach($standars as $standar)
                            <option value="{{ $standar['id'] }}">{{ $standar['kode_standar'] }} - {{ $standar['nama_standar'] }}</option>
                        @endforeach
                    </select>
                </div>
            </div>

            {{-- Quick Stats --}}
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-6">
                <div class="stats-card stats-card-blue">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <x-heroicon-o-building-office class="h-8 w-8 text-white" />
                        </div>
                        <div class="ml-3">
                            <h4 class="text-sm font-medium text-white/90">Total Unit</h4>
                            <p class="text-2xl font-bold text-white">{{ $summaryStats['total_units'] ?? 0 }}</p>
                        </div>
                    </div>
                </div>
                <div class="stats-card stats-card-green">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <x-heroicon-o-chart-bar-square class="h-8 w-8 text-white" />
                        </div>
                        <div class="ml-3">
                            <h4 class="text-sm font-medium text-white/90">Tingkat Ketercapaian</h4>
                            <p class="text-2xl font-bold text-white">{{ $summaryStats['achievement_rate'] ?? 0 }}%</p>
                        </div>
                    </div>
                </div>
                <div class="stats-card stats-card-yellow">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <x-heroicon-o-hand-thumb-up class="h-8 w-8 text-white" />
                        </div>
                        <div class="ml-3">
                            <h4 class="text-sm font-medium text-white/90">Tingkat Kesepakatan</h4>
                            <p class="text-2xl font-bold text-white">{{ $summaryStats['agreement_rate'] ?? 0 }}%</p>
                        </div>
                    </div>
                </div>
                <div class="stats-card stats-card-purple">
                    <div class="flex items-center">
                        <div class="flex-shrink-0">
                            <x-heroicon-o-list-bullet class="h-8 w-8 text-white" />
                        </div>
                        <div class="ml-3">
                            <h4 class="text-sm font-medium text-white/90">Total Item</h4>
                            <p class="text-2xl font-bold text-white">{{ $summaryStats['total_items'] ?? 0 }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </x-filament::section>

        {{-- Chart Overview All Units --}}
        <x-filament::section>
            <x-slot name="heading">
                <div class="flex items-center justify-between">
                    <span>Overview Ketercapaian Per Unit</span>
                    <div class="chart-actions">
                        <button onclick="resetZoom('overviewChart')" 
                                class="chart-action-btn">
                            <x-heroicon-o-magnifying-glass-minus class="w-4 h-4 inline mr-1" />
                            Reset Zoom
                        </button>
                        <button onclick="downloadChart('overviewChart', 'overview-ketercapaian')" 
                                class="chart-action-btn">
                            <x-heroicon-o-arrow-down-tray class="w-4 h-4 inline mr-1" />
                            Download
                        </button>
                    </div>
                </div>
            </x-slot>

            <div class="chart-container" style="height: 500px;">
                @if(empty($chartData['overview']))
                    <div class="flex items-center justify-center h-full">
                        <div class="text-center">
                            <x-heroicon-o-chart-bar class="mx-auto h-12 w-12 text-gray-400" />
                            <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">
                                Tidak ada data untuk ditampilkan. Pastikan ada assignment yang aktif.
                            </p>
                        </div>
                    </div>
                @else
                    <canvas id="overviewChart" data-chart-type="overview"></canvas>
                @endif
            </div>
        </x-filament::section>

        {{-- Chart Standar Per Unit --}}
        <x-filament::section>
            <x-slot name="heading">
                <div class="flex items-center justify-between">
                    <span>Ketercapaian Standar Per Unit</span>
                    <div class="chart-actions">
                        <button onclick="resetZoom('standarChart')" 
                                class="chart-action-btn">
                            <x-heroicon-o-magnifying-glass-minus class="w-4 h-4 inline mr-1" />
                            Reset Zoom
                        </button>
                        <button onclick="downloadChart('standarChart', 'standar-per-unit')" 
                                class="chart-action-btn">
                            <x-heroicon-o-arrow-down-tray class="w-4 h-4 inline mr-1" />
                            Download
                        </button>
                    </div>
                </div>
            </x-slot>

            <div class="chart-container" style="height: 600px;">
                @if(empty($chartData['standar']))
                    <div class="flex items-center justify-center h-full">
                        <div class="text-center">
                            <x-heroicon-o-chart-bar class="mx-auto h-12 w-12 text-gray-400" />
                            <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">
                                Tidak ada data standar untuk ditampilkan.
                            </p>
                        </div>
                    </div>
                @else
                    <canvas id="standarChart" data-chart-type="standar"></canvas>
                @endif
            </div>
        </x-filament::section>

        {{-- Chart Sub Standar Per Unit --}}
        <x-filament::section>
            <x-slot name="heading">
                <div class="flex items-center justify-between">
                    <span>Ketercapaian Sub Standar Per Unit</span>
                    <div class="chart-actions">
                        <button onclick="resetZoom('subStandarChart')" 
                                class="chart-action-btn">
                            <x-heroicon-o-magnifying-glass-minus class="w-4 h-4 inline mr-1" />
                            Reset Zoom
                        </button>
                        <button onclick="downloadChart('subStandarChart', 'sub-standar-per-unit')" 
                                class="chart-action-btn">
                            <x-heroicon-o-arrow-down-tray class="w-4 h-4 inline mr-1" />
                            Download
                        </button>
                    </div>
                </div>
            </x-slot>

            <div class="chart-container" style="height: 700px;">
                @if(empty($chartData['substandar']))
                    <div class="flex items-center justify-center h-full">
                        <div class="text-center">
                            <x-heroicon-o-chart-bar class="mx-auto h-12 w-12 text-gray-400" />
                            <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">
                                Tidak ada data sub standar untuk ditampilkan.
                            </p>
                        </div>
                    </div>
                @else
                    <canvas id="subStandarChart" data-chart-type="substandar"></canvas>
                @endif
            </div>
        </x-filament::section>

        {{-- Comparison Chart Auditee vs Auditor --}}
        <x-filament::section>
            <x-slot name="heading">
                <div class="flex items-center justify-between">
                    <span>Perbandingan Auditee vs Auditor</span>
                    <div class="chart-actions">
                        <button onclick="resetZoom('comparisonChart')" 
                                class="chart-action-btn">
                            <x-heroicon-o-magnifying-glass-minus class="w-4 h-4 inline mr-1" />
                            Reset Zoom
                        </button>
                        <button onclick="downloadChart('comparisonChart', 'comparison-auditee-auditor')" 
                                class="chart-action-btn">
                            <x-heroicon-o-arrow-down-tray class="w-4 h-4 inline mr-1" />
                            Download
                        </button>
                    </div>
                </div>
            </x-slot>

            <div class="chart-container" style="height: 500px;">
                @if(empty($chartData['comparison']))
                    <div class="flex items-center justify-center h-full">
                        <div class="text-center">
                            <x-heroicon-o-chart-bar class="mx-auto h-12 w-12 text-gray-400" />
                            <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">
                                Tidak ada data perbandingan untuk ditampilkan.
                            </p>
                        </div>
                    </div>
                @else
                    <canvas id="comparisonChart" data-chart-type="comparison"></canvas>
                @endif
            </div>
        </x-filament::section>

        {{-- Trend Analysis --}}
        <x-filament::section>
            <x-slot name="heading">
                <div class="flex items-center justify-between">
                    <span>Trend Ketercapaian dari Waktu ke Waktu</span>
                    <div class="chart-actions">
                        <button onclick="resetZoom('trendChart')" 
                                class="chart-action-btn">
                            <x-heroicon-o-magnifying-glass-minus class="w-4 h-4 inline mr-1" />
                            Reset Zoom
                        </button>
                        <button onclick="downloadChart('trendChart', 'trend-ketercapaian')" 
                                class="chart-action-btn">
                            <x-heroicon-o-arrow-down-tray class="w-4 h-4 inline mr-1" />
                            Download
                        </button>
                    </div>
                </div>
            </x-slot>

            <div class="chart-container" style="height: 400px;">
                @if(empty($chartData['trend']))
                    <div class="flex items-center justify-center h-full">
                        <div class="text-center">
                            <x-heroicon-o-chart-bar class="mx-auto h-12 w-12 text-gray-400" />
                            <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">
                                Tidak ada data trend untuk ditampilkan.
                            </p>
                        </div>
                    </div>
                @else
                    <canvas id="trendChart" data-chart-type="trend"></canvas>
                @endif
            </div>
        </x-filament::section>

        {{-- Detailed Data Table --}}
        <x-filament::section :collapsible="true" :collapsed="true">
            <x-slot name="heading">
                Data Detail
            </x-slot>

            <div class="overflow-x-auto">
                @if(empty($detailData))
                    <div class="text-center py-8">
                        <x-heroicon-o-table-cells class="mx-auto h-12 w-12 text-gray-400" />
                        <p class="mt-2 text-sm text-gray-500 dark:text-gray-400">
                            Tidak ada data detail untuk ditampilkan.
                        </p>
                    </div>
                @else
                    <table class="data-table min-w-full divide-y divide-gray-200 dark:divide-gray-700">
                        <thead class="bg-gray-50 dark:bg-gray-800">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase">Unit</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase">Periode</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase">Total Item</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase">Auditee Tercapai</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase">Auditor Sesuai</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase">Kesepakatan</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white dark:bg-gray-900 divide-y divide-gray-200 dark:divide-gray-700">
                            @foreach($detailData as $item)
                                <tr class="hover:bg-gray-50 dark:hover:bg-gray-800">
                                    <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">{{ $item['unit_name'] ?? '-' }}</td>
                                    <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">{{ $item['periode_name'] ?? '-' }}</td>
                                    <td class="px-6 py-4 text-sm text-gray-900 dark:text-white">{{ $item['total_items'] ?? 0 }}</td>
                                    <td class="px-6 py-4 text-sm text-success-600 dark:text-success-400">
                                        {{ $item['auditee_tercapai'] ?? 0 }} ({{ $item['auditee_percentage'] ?? 0 }}%)
                                    </td>
                                    <td class="px-6 py-4 text-sm text-info-600 dark:text-info-400">
                                        {{ $item['auditor_sesuai'] ?? 0 }} ({{ $item['auditor_percentage'] ?? 0 }}%)
                                    </td>
                                    <td class="px-6 py-4 text-sm">
                                        @php
                                            $agreementRate = $item['agreement_rate'] ?? 0;
                                            $color = $agreementRate >= 80 ? 'success' : ($agreementRate >= 60 ? 'warning' : 'danger');
                                        @endphp
                                        <x-filament::badge :color="$color">
                                            {{ $agreementRate }}%
                                        </x-filament::badge>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                @endif
            </div>
        </x-filament::section>
    </div>

    {{-- Include Chart Styles --}}
    <style>
        /* Stats Cards */
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            padding: 20px;
            color: white;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .stats-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px -3px rgba(0, 0, 0, 0.2);
        }

        .stats-card-blue {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
        }

        .stats-card-green {
            background: linear-gradient(135deg, #10b981 0%, #047857 100%);
        }

        .stats-card-yellow {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
        }

        .stats-card-purple {
            background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
        }

        /* Chart Container */
        .chart-container {
            position: relative;
            width: 100%;
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
            border: 1px solid #e5e7eb;
            transition: all 0.3s ease;
        }

        .chart-container:hover {
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        .dark .chart-container {
            background: rgb(17 24 39);
            border-color: rgb(55 65 81);
        }

        /* Chart Actions */
        .chart-actions {
            display: flex;
            gap: 8px;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .chart-container:hover .chart-actions {
            opacity: 1;
        }

        .chart-action-btn {
            display: flex;
            align-items: center;
            padding: 6px 12px;
            font-size: 12px;
            background: rgba(255, 255, 255, 0.95);
            border: 1px solid #d1d5db;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s ease;
            backdrop-filter: blur(10px);
        }

        .chart-action-btn:hover {
            background: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transform: translateY(-1px);
        }

        .dark .chart-action-btn {
            background: rgba(17, 24, 39, 0.95);
            border-color: rgb(55 65 81);
            color: white;
        }

        .dark .chart-action-btn:hover {
            background: rgb(17 24 39);
        }

        /* Data Table */
        .data-table {
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .data-table th {
            background: #f9fafb;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        .dark .data-table th {
            background: rgb(31 41 55);
        }

        .data-table tr:hover {
            background: #f9fafb;
        }

        .dark .data-table tr:hover {
            background: rgb(31 41 55);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .chart-container {
                padding: 15px;
                height: 300px !important;
            }
            
            .chart-actions {
                position: static;
                opacity: 1;
                margin-bottom: 10px;
                justify-content: center;
                flex-wrap: wrap;
            }
            
            .stats-card {
                padding: 15px;
            }
            
            .chart-action-btn {
                padding: 4px 8px;
                font-size: 11px;
            }
        }

        @media (max-width: 640px) {
            .chart-container {
                height: 250px !important;
                padding: 10px;
            }
        }
    </style>

    {{-- Chart Scripts --}}
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-zoom@1.2.1/dist/chartjs-plugin-zoom.min.js"></script>
    <script>
        // Register zoom plugin
        Chart.register(ChartZoom);

        window.ChartAnalysisManager = {
            instances: {},
            data: {
                overview: @json($chartData['overview'] ?? []),
                standar: @json($chartData['standar'] ?? []),
                substandar: @json($chartData['substandar'] ?? []),
                comparison: @json($chartData['comparison'] ?? []),
                trend: @json($chartData['trend'] ?? [])
            },

            init: function() {
                console.log('Initializing Chart Analysis Manager');
                console.log('Chart data:', this.data);
                
                setTimeout(() => {
                    this.createOverviewChart();
                    this.createStandarChart();
                    this.createSubStandarChart();
                    this.createComparisonChart();
                    this.createTrendChart();
                }, 300);
            },

            createOverviewChart: function() {
                const ctx = document.getElementById('overviewChart');
                if (!ctx || !this.data.overview.length) return;

                if (this.instances.overview) {
                    this.instances.overview.destroy();
                }

                this.instances.overview = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: this.data.overview.map(item => item.unit_name),
                        datasets: [{
                            label: 'Auditee Tercapai (%)',
                            data: this.data.overview.map(item => item.auditee_percentage),
                            backgroundColor: '#10B981',
                            borderColor: '#059669',
                            borderWidth: 1
                        }, {
                            label: 'Auditor Sesuai (%)',
                            data: this.data.overview.map(item => item.auditor_percentage),
                            backgroundColor: '#3B82F6',
                            borderColor: '#2563EB',
                            borderWidth: 1
                        }, {
                            label: 'Kesepakatan (%)',
                            data: this.data.overview.map(item => item.agreement_rate),
                            backgroundColor: '#8B5CF6',
                            borderColor: '#7C3AED',
                            borderWidth: 1,
                            type: 'line',
                            yAxisID: 'y1'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            zoom: {
                                zoom: {
                                    wheel: { enabled: true },
                                    pinch: { enabled: true },
                                    mode: 'x',
                                },
                                pan: {
                                    enabled: true,
                                    mode: 'x',
                                }
                            },
                            legend: { position: 'top' },
                            tooltip: {
                                callbacks: {
                                    afterLabel: function(context) {
                                        const dataIndex = context.dataIndex;
                                        const item = window.ChartAnalysisManager.data.overview[dataIndex];
                                        return `Total Items: ${item.total_items}`;
                                    }
                                }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                max: 100,
                                title: { display: true, text: 'Percentage (%)' }
                            },
                            y1: {
                                type: 'linear',
                                display: true,
                                position: 'right',
                                max: 100,
                                grid: { drawOnChartArea: false },
                                title: { display: true, text: 'Agreement Rate (%)' }
                            },
                            x: {
                                title: { display: true, text: 'Unit' }
                            }
                        }
                    }
                });
            },

            createStandarChart: function() {
                const ctx = document.getElementById('standarChart');
                if (!ctx || !this.data.standar.length) return;

                if (this.instances.standar) {
                    this.instances.standar.destroy();
                }

                // Group data by unit
                const groupedData = {};
                this.data.standar.forEach(item => {
                    if (!groupedData[item.unit_name]) {
                        groupedData[item.unit_name] = {};
                    }
                    groupedData[item.unit_name][item.standar_code] = item;
                });

                const allStandars = [...new Set(this.data.standar.map(item => item.standar_code))];
                const units = Object.keys(groupedData);

                if (units.length === 0) return;

                const datasets = allStandars.map((standar, index) => ({
                    label: `${standar} - Auditee`,
                    data: units.map(unit => 
                        groupedData[unit][standar]?.auditee_percentage || 0
                    ),
                    backgroundColor: this.getColor(index * 2),
                    borderColor: this.getColor(index * 2, 0.8),
                    borderWidth: 1
                }));

                // Add auditor datasets
                allStandars.forEach((standar, index) => {
                    datasets.push({
                        label: `${standar} - Auditor`,
                        data: units.map(unit => 
                            groupedData[unit][standar]?.auditor_percentage || 0
                        ),
                        backgroundColor: this.getColor(index * 2 + 1),
                        borderColor: this.getColor(index * 2 + 1, 0.8),
                        borderWidth: 1
                    });
                });

                this.instances.standar = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: units,
                        datasets: datasets
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            zoom: {
                                zoom: {
                                    wheel: { enabled: true },
                                    pinch: { enabled: true },
                                    mode: 'x',
                                },
                                pan: {
                                    enabled: true,
                                    mode: 'x',
                                }
                            },
                            legend: { 
                                position: 'top',
                                labels: { boxWidth: 12 }
                            }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                max: 100,
                                title: { display: true, text: 'Percentage (%)' }
                            },
                            x: {
                                title: { display: true, text: 'Unit' }
                            }
                        }
                    }
                });
            },

            createSubStandarChart: function() {
                const ctx = document.getElementById('subStandarChart');
                if (!ctx || !this.data.substandar.length) return;

                if (this.instances.substandar) {
                    this.instances.substandar.destroy();
                }

                // Create horizontal bar chart for better readability with many sub standards
                const labels = this.data.substandar.map(item => 
                    `${item.unit_name} - ${item.sub_standar_name}`
                );

                this.instances.substandar = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Auditee Tercapai (%)',
                            data: this.data.substandar.map(item => item.auditee_percentage),
                            backgroundColor: '#10B981'
                        }, {
                            label: 'Auditor Sesuai (%)',
                            data: this.data.substandar.map(item => item.auditor_percentage),
                            backgroundColor: '#3B82F6'
                        }, {
                            label: 'Kesepakatan (%)',
                            data: this.data.substandar.map(item => item.agreement_rate),
                            backgroundColor: '#8B5CF6'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        indexAxis: 'y',
                        plugins: {
                            zoom: {
                                zoom: {
                                    wheel: { enabled: true },
                                    pinch: { enabled: true },
                                    mode: 'y',
                                },
                                pan: {
                                    enabled: true,
                                    mode: 'y',
                                }
                            },
                            legend: { position: 'top' }
                        },
                        scales: {
                            x: {
                                beginAtZero: true,
                                max: 100,
                                title: { display: true, text: 'Percentage (%)' }
                            },
                            y: {
                                title: { display: true, text: 'Unit - Sub Standar' }
                            }
                        }
                    }
                });
            },

            createComparisonChart: function() {
                const ctx = document.getElementById('comparisonChart');
                if (!ctx || !this.data.comparison.length) return;

                if (this.instances.comparison) {
                    this.instances.comparison.destroy();
                }

                this.instances.comparison = new Chart(ctx, {
                    type: 'radar',
                    data: {
                        labels: this.data.comparison.map(item => item.unit_name),
                        datasets: [{
                            label: 'Auditee Achievement Rate',
                            data: this.data.comparison.map(item => item.auditee_percentage),
                            backgroundColor: 'rgba(16, 185, 129, 0.2)',
                            borderColor: '#10B981',
                            borderWidth: 2,
                            pointBackgroundColor: '#10B981'
                        }, {
                            label: 'Auditor Conformity Rate',
                            data: this.data.comparison.map(item => item.auditor_percentage),
                            backgroundColor: 'rgba(59, 130, 246, 0.2)',
                            borderColor: '#3B82F6',
                            borderWidth: 2,
                            pointBackgroundColor: '#3B82F6'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            zoom: {
                                zoom: {
                                    wheel: { enabled: true },
                                    pinch: { enabled: true },
                                    mode: 'xy',
                                },
                                pan: {
                                    enabled: true,
                                    mode: 'xy',
                                }
                            },
                            legend: { position: 'top' }
                        },
                        scales: {
                            r: {
                                beginAtZero: true,
                                max: 100,
                                ticks: {
                                    stepSize: 20
                                }
                            }
                        }
                    }
                });
            },

            createTrendChart: function() {
                const ctx = document.getElementById('trendChart');
                if (!ctx || !this.data.trend.length) return;

                if (this.instances.trend) {
                    this.instances.trend.destroy();
                }

                const groupedByUnit = {};
                this.data.trend.forEach(item => {
                    if (!groupedByUnit[item.unit_name]) {
                        groupedByUnit[item.unit_name] = [];
                    }
                    groupedByUnit[item.unit_name].push(item);
                });

                const allPeriodes = [...new Set(this.data.trend.map(item => item.periode_name))];
                
                const datasets = Object.keys(groupedByUnit).map((unit, index) => ({
                    label: unit,
                    data: allPeriodes.map(periode => {
                        const item = groupedByUnit[unit].find(d => d.periode_name === periode);
                        return item ? item.agreement_rate : null;
                    }),
                    borderColor: this.getColor(index),
                    backgroundColor: this.getColor(index, 0.1),
                    borderWidth: 2,
                    fill: false,
                    tension: 0.3
                }));

                this.instances.trend = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: allPeriodes,
                        datasets: datasets
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            zoom: {
                                zoom: {
                                    wheel: { enabled: true },
                                    pinch: { enabled: true },
                                    mode: 'x',
                                },
                                pan: {
                                    enabled: true,
                                    mode: 'x',
                                }
                            },
                            legend: { position: 'top' }
                        },
                        scales: {
                            y: {
                                beginAtZero: true,
                                max: 100,
                                title: { display: true, text: 'Agreement Rate (%)' }
                            },
                            x: {
                                title: { display: true, text: 'Periode' }
                            }
                        }
                    }
                });
            },

            getColor: function(index, alpha = 1) {
                const colors = [
                    `rgba(239, 68, 68, ${alpha})`,   // red
                    `rgba(34, 197, 94, ${alpha})`,  // green
                    `rgba(59, 130, 246, ${alpha})`, // blue
                    `rgba(245, 158, 11, ${alpha})`, // yellow
                    `rgba(139, 92, 246, ${alpha})`, // purple
                    `rgba(236, 72, 153, ${alpha})`, // pink
                    `rgba(20, 184, 166, ${alpha})`, // teal
                    `rgba(251, 146, 60, ${alpha})`, // orange
                ];
                return colors[index % colors.length];
            },

            refreshCharts: function() {
                console.log('Refreshing all charts');
                Object.keys(this.instances).forEach(key => {
                    if (this.instances[key]) {
                        this.instances[key].destroy();
                    }
                });
                this.instances = {};
                setTimeout(() => {
                    this.init();
                }, 300);
            }
        };

        // Global functions for chart interactions
        function resetZoom(chartId) {
            const chartKey = chartId.replace('Chart', '');
            if (window.ChartAnalysisManager.instances[chartKey]) {
                window.ChartAnalysisManager.instances[chartKey].resetZoom();
            }
        }

        function downloadChart(chartId, filename) {
            const canvas = document.getElementById(chartId);
            if (canvas) {
                const link = document.createElement('a');
                link.download = `${filename}-${new Date().toISOString().split('T')[0]}.png`;
                link.href = canvas.toDataURL('image/png', 1.0);
                link.click();
            }
        }

        // Initialize charts when DOM is ready
        document.addEventListener('DOMContentLoaded', function() {
            window.ChartAnalysisManager.init();
        });

        // Handle Livewire updates
        document.addEventListener('livewire:updated', function() {
            console.log('Livewire updated - refreshing charts');
            setTimeout(() => {
                window.ChartAnalysisManager.refreshCharts();
            }, 500);
        });

        // Listen for refresh event from header actions
        document.addEventListener('charts-refreshed', function() {
            window.ChartAnalysisManager.refreshCharts();
        });

        // Cleanup on page unload
        window.addEventListener('beforeunload', function() {
            Object.keys(window.ChartAnalysisManager.instances).forEach(key => {
                if (window.ChartAnalysisManager.instances[key]) {
                    window.ChartAnalysisManager.instances[key].destroy();
                }
            });
        });

        // Handle window resize
        window.addEventListener('resize', function() {
            setTimeout(() => {
                Object.keys(window.ChartAnalysisManager.instances).forEach(key => {
                    if (window.ChartAnalysisManager.instances[key]) {
                        window.ChartAnalysisManager.instances[key].resize();
                    }
                });
            }, 300);
        });
    </script>
    <style>
        /* Add this to your CSS file or in a <style> section */

.chart-container {
    position: relative;
    width: 100%;
    background: white;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
    border: 1px solid #e5e7eb;
    transition: all 0.3s ease;
}

.chart-container:hover {
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

.dark .chart-container {
    background: rgb(17 24 39);
    border-color: rgb(55 65 81);
}

.chart-container canvas {
    max-width: 100%;
    height: auto;
}

/* Filter controls styling */
.filter-section {
    background: #f9fafb;
    border-radius: 8px;
    padding: 16px;
    margin-bottom: 20px;
}

.dark .filter-section {
    background: rgb(31 41 55);
}

/* Stats cards */
.stats-card {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border-radius: 12px;
    padding: 20px;
    color: white;
    transition: transform 0.2s ease;
}

.stats-card:hover {
    transform: translateY(-2px);
}

.stats-card-blue {
    background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
}

.stats-card-green {
    background: linear-gradient(135deg, #10b981 0%, #047857 100%);
}

.stats-card-yellow {
    background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
}

.stats-card-purple {
    background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%);
}

/* Chart action buttons */
.chart-actions {
    position: absolute;
    top: 10px;
    right: 10px;
    display: flex;
    gap: 8px;
    opacity: 0;
    transition: opacity 0.3s ease;
}

.chart-container:hover .chart-actions {
    opacity: 1;
}

.chart-action-btn {
    padding: 6px 12px;
    font-size: 12px;
    background: rgba(255, 255, 255, 0.9);
    border: 1px solid #d1d5db;
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.2s ease;
}

.chart-action-btn:hover {
    background: white;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.dark .chart-action-btn {
    background: rgba(17, 24, 39, 0.9);
    border-color: rgb(55 65 81);
    color: white;
}

.dark .chart-action-btn:hover {
    background: rgb(17 24 39);
}

/* Responsive design */
@media (max-width: 768px) {
    .chart-container {
        padding: 15px;
        height: 300px !important;
    }
    
    .chart-actions {
        position: static;
        opacity: 1;
        margin-bottom: 10px;
        justify-content: center;
    }
    
    .stats-card {
        padding: 15px;
    }
    
    .filter-section {
        padding: 12px;
    }
}

@media (max-width: 640px) {
    .chart-container {
        height: 250px !important;
        padding: 10px;
    }
    
    .chart-action-btn {
        padding: 4px 8px;
        font-size: 11px;
    }
}

/* Loading states */
.chart-loading {
    display: flex;
    items-center: center;
    justify-content: center;
    height: 200px;
    color: #6b7280;
}

.chart-loading::after {
    content: '';
    width: 40px;
    height: 40px;
    border: 4px solid #f3f4f6;
    border-top: 4px solid #3b82f6;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Table enhancements */
.data-table {
    border-collapse: separate;
    border-spacing: 0;
    border-radius: 8px;
    overflow: hidden;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.data-table th {
    background: #f9fafb;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

.dark .data-table th {
    background: rgb(31 41 55);
}

.data-table tr:hover {
    background: #f9fafb;
}

.dark .data-table tr:hover {
    background: rgb(31 41 55);
}

/* Chart zoom indicators */
.chart-container.zoomed::before {
    content: 'Zoomed - Use mouse wheel to zoom, drag to pan';
    position: absolute;
    top: 5px;
    left: 5px;
    background: #3b82f6;
    color: white;
    padding: 4px 8px;
    border-radius: 4px;
    font-size: 11px;
    z-index: 10;
}

/* Print styles */
@media print {
    .chart-actions {
        display: none !important;
    }
    
    .chart-container {
        break-inside: avoid;
        page-break-inside: avoid;
    }
    
    .filter-section {
        display: none !important;
    }
}
    </style>
</x-filament-panels::page>