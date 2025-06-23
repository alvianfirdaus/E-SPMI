<?php

namespace App\Filament\Resources\Pages;

use Filament\Pages\Page;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Concerns\InteractsWithForms;
use App\Models\AssignPengisian;
use App\Models\Periode;
use App\Models\Unit;
use App\Models\Standar;
use App\Models\UnitIndikator;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ChartAnalysis extends Page implements HasForms
{
    use InteractsWithForms;

    protected static ?string $navigationIcon = 'heroicon-o-chart-bar';
    protected static string $view = 'filament.pages.chart-analysis';
    protected static ?string $navigationLabel = 'Analisis Chart';
    protected static ?string $title = 'Analisis Ketercapaian Standar';
    protected static ?string $navigationGroup = 'Analytics';
    protected static ?int $navigationSort = 1;
    
    // Properties for filters
    public ?string $selectedPeriode = null;
    public ?string $selectedUnit = null;
    public ?string $selectedStandar = null;
    
    // Data properties
    public array $periodes = [];
    public array $units = [];
    public array $standars = [];
    public array $chartData = [];
    public array $summaryStats = [];
    public array $detailData = [];

    public static function shouldRegisterNavigation(): bool
    {
        return true;
    }

    public static function getNavigationBadge(): ?string
    {
        return (string) AssignPengisian::where('is_active', true)->count();
    }

    public static function getNavigationBadgeColor(): string|array|null
    {
        return 'success';
    }

    public function mount(): void
    {
        $this->loadFilterData();
        $this->setDefaultFilters();
        $this->prepareChartData();
    }

    protected function loadFilterData(): void
    {
        // Load periods
        $this->periodes = Periode::orderBy('created_at', 'desc')->get()->toArray();
        
        // Load units that have assignments - Fixed approach without using missing relationship
        $unitIds = DB::table('assign_pengisians')
            ->join('unit_indikators', 'assign_pengisians.unit_indikator_id', '=', 'unit_indikators.id')
            ->where('assign_pengisians.is_active', true)
            ->pluck('unit_indikators.unit_id')
            ->unique();
            
        $this->units = Unit::whereIn('id', $unitIds)->orderBy('nama_unit')->get()->toArray();
            
        // Load standards
        $this->standars = Standar::orderBy('kode_standar')->get()->toArray();
    }

    protected function setDefaultFilters(): void
    {
        // Set default to active period
        $activePeriode = Periode::where('status_periode', 'active')->first();
        if ($activePeriode) {
            $this->selectedPeriode = (string) $activePeriode->id;
        }
    }

    public function updatedSelectedPeriode(): void
    {
        $this->prepareChartData();
    }

    public function updatedSelectedUnit(): void
    {
        $this->prepareChartData();
    }

    public function updatedSelectedStandar(): void
    {
        $this->prepareChartData();
    }

    protected function prepareChartData(): void
    {
        $baseQuery = $this->getBaseQuery();
        
        $this->chartData = [
            'overview' => $this->getOverviewData($baseQuery),
            'standar' => $this->getStandarData($baseQuery),
            'substandar' => $this->getSubStandarData($baseQuery),
            'comparison' => $this->getComparisonData($baseQuery),
            'trend' => $this->getTrendData()
        ];
        
        $this->summaryStats = $this->calculateSummaryStats($baseQuery);
        $this->detailData = $this->getDetailData($baseQuery);
    }

    protected function getBaseQuery()
    {
        $query = AssignPengisian::with([
            'unitIndikator.unit',
            'periode',
            'pengisianIndikators.reviewAuditor1',
            'unitIndikator.unitIndikatorStandars.standar',
            'unitIndikator.unitIndikatorStandars.unitIndikatorIndikators.indikator.subStandar'
        ])->where('is_active', true);

        if ($this->selectedPeriode) {
            $query->where('periode_id', $this->selectedPeriode);
        }

        if ($this->selectedUnit) {
            $query->whereHas('unitIndikator', function ($q) {
                $q->where('unit_id', $this->selectedUnit);
            });
        }

        return $query;
    }

    protected function getOverviewData($baseQuery): array
    {
        try {
            $assignments = $baseQuery->get();
            $overviewData = [];

            if ($assignments->isEmpty()) {
                return [];
            }

            foreach ($assignments as $assignment) {
                $unitName = $assignment->unitIndikator?->unit?->nama_unit ?? 'Unknown Unit';
                $periodeName = $assignment->periode?->periode_name ?? 'Unknown Period';
                $key = $unitName . '|' . $periodeName;

                if (!isset($overviewData[$key])) {
                    $overviewData[$key] = [
                        'unit_name' => $unitName,
                        'periode_name' => $periodeName,
                        'total_items' => 0,
                        'auditee_tercapai' => 0,
                        'auditee_tidak_tercapai' => 0,
                        'auditor_sesuai' => 0,
                        'auditor_tidak_sesuai' => 0,
                        'agreements' => 0
                    ];
                }

                if ($assignment->pengisianIndikators) {
                    foreach ($assignment->pengisianIndikators as $pengisian) {
                        $overviewData[$key]['total_items']++;

                        // Auditee data
                        if ($pengisian->isi === 'tercapai') {
                            $overviewData[$key]['auditee_tercapai']++;
                        } elseif ($pengisian->isi === 'tidak_tercapai') {
                            $overviewData[$key]['auditee_tidak_tercapai']++;
                        }

                        // Auditor data
                        if ($pengisian->reviewAuditor1 && $pengisian->reviewAuditor1->status === 'reviewed') {
                            if ($pengisian->reviewAuditor1->status_temuan === 'sesuai') {
                                $overviewData[$key]['auditor_sesuai']++;
                            } else {
                                $overviewData[$key]['auditor_tidak_sesuai']++;
                            }

                            // Check agreement
                            if (($pengisian->isi === 'tercapai' && $pengisian->reviewAuditor1->status_temuan === 'sesuai') ||
                                ($pengisian->isi === 'tidak_tercapai' && $pengisian->reviewAuditor1->status_temuan === 'tidak_sesuai')) {
                                $overviewData[$key]['agreements']++;
                            }
                        }
                    }
                }
            }

            // Calculate percentages
            foreach ($overviewData as &$data) {
                if ($data['total_items'] > 0) {
                    $data['auditee_percentage'] = round(($data['auditee_tercapai'] / $data['total_items']) * 100, 2);
                    $totalReviewed = $data['auditor_sesuai'] + $data['auditor_tidak_sesuai'];
                    $data['auditor_percentage'] = $totalReviewed > 0 ? round(($data['auditor_sesuai'] / $totalReviewed) * 100, 2) : 0;
                    $data['agreement_rate'] = round(($data['agreements'] / $data['total_items']) * 100, 2);
                } else {
                    $data['auditee_percentage'] = 0;
                    $data['auditor_percentage'] = 0;
                    $data['agreement_rate'] = 0;
                }
            }

            return array_values($overviewData);
        } catch (\Exception $e) {
            // Log error for debugging but don't break the page
            if (config('app.debug')) {
                dd('Error in getOverviewData: ' . $e->getMessage());
            }
            return [];
        }
    }

    protected function getStandarData($baseQuery): array
    {
        try {
            $assignments = $baseQuery->get();
            $standarData = [];

            if ($assignments->isEmpty()) {
                return [];
            }

            foreach ($assignments as $assignment) {
                $unitName = $assignment->unitIndikator?->unit?->nama_unit ?? 'Unknown Unit';
                
                if (!$assignment->unitIndikator || !$assignment->unitIndikator->unitIndikatorStandars) {
                    continue;
                }

                foreach ($assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
                    $standar = $unitStandar->standar;
                    if (!$standar) continue;

                    $key = $unitName . '|' . $standar->kode_standar;

                    if (!isset($standarData[$key])) {
                        $standarData[$key] = [
                            'unit_name' => $unitName,
                            'standar_code' => $standar->kode_standar,
                            'standar_name' => $standar->nama_standar,
                            'total_items' => 0,
                            'auditee_tercapai' => 0,
                            'auditor_sesuai' => 0,
                            'agreements' => 0
                        ];
                    }

                    if ($unitStandar->unitIndikatorIndikators) {
                        foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                            if ($unitIndikator->unitIndikatorIsiIndikators) {
                                foreach ($unitIndikator->unitIndikatorIsiIndikators as $uiIsiIndikator) {
                                    $pengisian = $assignment->pengisianIndikators
                                        ->where('ui_isi_indikator_id', $uiIsiIndikator->id)
                                        ->first();

                                    if ($pengisian) {
                                        $standarData[$key]['total_items']++;

                                        if ($pengisian->isi === 'tercapai') {
                                            $standarData[$key]['auditee_tercapai']++;
                                        }

                                        if ($pengisian->reviewAuditor1 && 
                                            $pengisian->reviewAuditor1->status === 'reviewed' && 
                                            $pengisian->reviewAuditor1->status_temuan === 'sesuai') {
                                            $standarData[$key]['auditor_sesuai']++;
                                        }

                                        if (($pengisian->isi === 'tercapai' && 
                                             $pengisian->reviewAuditor1?->status_temuan === 'sesuai') ||
                                            ($pengisian->isi === 'tidak_tercapai' && 
                                             $pengisian->reviewAuditor1?->status_temuan === 'tidak_sesuai')) {
                                            $standarData[$key]['agreements']++;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Calculate percentages
            foreach ($standarData as &$data) {
                if ($data['total_items'] > 0) {
                    $data['auditee_percentage'] = round(($data['auditee_tercapai'] / $data['total_items']) * 100, 2);
                    $data['auditor_percentage'] = round(($data['auditor_sesuai'] / $data['total_items']) * 100, 2);
                    $data['agreement_rate'] = round(($data['agreements'] / $data['total_items']) * 100, 2);
                } else {
                    $data['auditee_percentage'] = 0;
                    $data['auditor_percentage'] = 0;
                    $data['agreement_rate'] = 0;
                }
            }

            return array_values($standarData);
        } catch (\Exception $e) {
            if (config('app.debug')) {
                dd('Error in getStandarData: ' . $e->getMessage());
            }
            return [];
        }
    }

    protected function getSubStandarData($baseQuery): array
    {
        try {
            $assignments = $baseQuery->get();
            $subStandarData = [];

            if ($assignments->isEmpty()) {
                return [];
            }

            foreach ($assignments as $assignment) {
                $unitName = $assignment->unitIndikator?->unit?->nama_unit ?? 'Unknown Unit';
                
                if (!$assignment->unitIndikator || !$assignment->unitIndikator->unitIndikatorStandars) {
                    continue;
                }

                foreach ($assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
                    if ($unitStandar->unitIndikatorIndikators) {
                        foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                            $subStandar = $unitIndikator->indikator?->subStandar;
                            $subStandarName = $subStandar?->nama_sub_standar ?? 'Tanpa Sub Standar';
                            $key = $unitName . '|' . $subStandarName;

                            if (!isset($subStandarData[$key])) {
                                $subStandarData[$key] = [
                                    'unit_name' => $unitName,
                                    'sub_standar_name' => $subStandarName,
                                    'total_items' => 0,
                                    'auditee_tercapai' => 0,
                                    'auditor_sesuai' => 0,
                                    'agreements' => 0
                                ];
                            }

                            if ($unitIndikator->unitIndikatorIsiIndikators) {
                                foreach ($unitIndikator->unitIndikatorIsiIndikators as $uiIsiIndikator) {
                                    $pengisian = $assignment->pengisianIndikators
                                        ->where('ui_isi_indikator_id', $uiIsiIndikator->id)
                                        ->first();

                                    if ($pengisian) {
                                        $subStandarData[$key]['total_items']++;

                                        if ($pengisian->isi === 'tercapai') {
                                            $subStandarData[$key]['auditee_tercapai']++;
                                        }

                                        if ($pengisian->reviewAuditor1 && 
                                            $pengisian->reviewAuditor1->status === 'reviewed' && 
                                            $pengisian->reviewAuditor1->status_temuan === 'sesuai') {
                                            $subStandarData[$key]['auditor_sesuai']++;
                                        }

                                        if (($pengisian->isi === 'tercapai' && 
                                             $pengisian->reviewAuditor1?->status_temuan === 'sesuai') ||
                                            ($pengisian->isi === 'tidak_tercapai' && 
                                             $pengisian->reviewAuditor1?->status_temuan === 'tidak_sesuai')) {
                                            $subStandarData[$key]['agreements']++;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // Calculate percentages
            foreach ($subStandarData as &$data) {
                if ($data['total_items'] > 0) {
                    $data['auditee_percentage'] = round(($data['auditee_tercapai'] / $data['total_items']) * 100, 2);
                    $data['auditor_percentage'] = round(($data['auditor_sesuai'] / $data['total_items']) * 100, 2);
                    $data['agreement_rate'] = round(($data['agreements'] / $data['total_items']) * 100, 2);
                } else {
                    $data['auditee_percentage'] = 0;
                    $data['auditor_percentage'] = 0;
                    $data['agreement_rate'] = 0;
                }
            }

            return array_values($subStandarData);
        } catch (\Exception $e) {
            if (config('app.debug')) {
                dd('Error in getSubStandarData: ' . $e->getMessage());
            }
            return [];
        }
    }

    protected function getComparisonData($baseQuery): array
    {
        // Use overview data for radar chart
        return $this->getOverviewData($baseQuery);
    }

    protected function getTrendData(): array
    {
        try {
            // Get trend data across all periods if no specific period is selected
            $query = AssignPengisian::with([
                'unitIndikator.unit',
                'periode',
                'pengisianIndikators.reviewAuditor1'
            ])->where('is_active', true);

            if ($this->selectedUnit) {
                $query->whereHas('unitIndikator', function ($q) {
                    $q->where('unit_id', $this->selectedUnit);
                });
            }

            $assignments = $query->get();
            $trendData = [];

            if ($assignments->isEmpty()) {
                return [];
            }

            foreach ($assignments as $assignment) {
                $unitName = $assignment->unitIndikator?->unit?->nama_unit ?? 'Unknown Unit';
                $periodeName = $assignment->periode?->periode_name ?? 'Unknown Period';
                $key = $unitName . '|' . $periodeName;

                if (!isset($trendData[$key])) {
                    $trendData[$key] = [
                        'unit_name' => $unitName,
                        'periode_name' => $periodeName,
                        'total_items' => 0,
                        'agreements' => 0
                    ];
                }

                if ($assignment->pengisianIndikators) {
                    foreach ($assignment->pengisianIndikators as $pengisian) {
                        $trendData[$key]['total_items']++;

                        if ($pengisian->reviewAuditor1 && $pengisian->reviewAuditor1->status === 'reviewed') {
                            if (($pengisian->isi === 'tercapai' && $pengisian->reviewAuditor1->status_temuan === 'sesuai') ||
                                ($pengisian->isi === 'tidak_tercapai' && $pengisian->reviewAuditor1->status_temuan === 'tidak_sesuai')) {
                                $trendData[$key]['agreements']++;
                            }
                        }
                    }
                }
            }

            // Calculate agreement rates
            foreach ($trendData as &$data) {
                $data['agreement_rate'] = $data['total_items'] > 0 
                    ? round(($data['agreements'] / $data['total_items']) * 100, 2) 
                    : 0;
            }

            return array_values($trendData);
        } catch (\Exception $e) {
            if (config('app.debug')) {
                dd('Error in getTrendData: ' . $e->getMessage());
            }
            return [];
        }
    }

    protected function calculateSummaryStats($baseQuery): array
    {
        try {
            $assignments = $baseQuery->get();
            
            $totalUnits = $assignments->pluck('unitIndikator.unit.id')->filter()->unique()->count();
            $totalItems = 0;
            $totalAuditeeAchieved = 0;
            $totalAgreements = 0;

            foreach ($assignments as $assignment) {
                if ($assignment->pengisianIndikators) {
                    foreach ($assignment->pengisianIndikators as $pengisian) {
                        $totalItems++;

                        if ($pengisian->isi === 'tercapai') {
                            $totalAuditeeAchieved++;
                        }

                        if ($pengisian->reviewAuditor1 && $pengisian->reviewAuditor1->status === 'reviewed') {
                            if (($pengisian->isi === 'tercapai' && $pengisian->reviewAuditor1->status_temuan === 'sesuai') ||
                                ($pengisian->isi === 'tidak_tercapai' && $pengisian->reviewAuditor1->status_temuan === 'tidak_sesuai')) {
                                $totalAgreements++;
                            }
                        }
                    }
                }
            }

            return [
                'total_units' => $totalUnits,
                'total_items' => $totalItems,
                'achievement_rate' => $totalItems > 0 ? round(($totalAuditeeAchieved / $totalItems) * 100, 2) : 0,
                'agreement_rate' => $totalItems > 0 ? round(($totalAgreements / $totalItems) * 100, 2) : 0
            ];
        } catch (\Exception $e) {
            if (config('app.debug')) {
                dd('Error in calculateSummaryStats: ' . $e->getMessage());
            }
            return [
                'total_units' => 0,
                'total_items' => 0,
                'achievement_rate' => 0,
                'agreement_rate' => 0
            ];
        }
    }

    protected function getDetailData($baseQuery): array
    {
        return $this->getOverviewData($baseQuery);
    }

    public function getTitle(): string
    {
        return 'Analisis Ketercapaian Standar';
    }

    protected function getHeaderActions(): array
    {
        return [
            \Filament\Actions\Action::make('refresh_data')
                ->label('Refresh')
                ->icon('heroicon-o-arrow-path')
                ->color('gray')
                ->action(function () {
                    $this->loadFilterData();
                    $this->prepareChartData();
                    $this->dispatch('charts-refreshed');
                    
                    \Filament\Notifications\Notification::make()
                        ->title('Data berhasil direfresh')
                        ->success()
                        ->send();
                }),
                
            \Filament\Actions\Action::make('debug_info')
                ->label('Debug Info')
                ->icon('heroicon-o-bug-ant')
                ->color('warning')
                ->visible(config('app.debug'))
                ->action(function () {
                    $debugInfo = [
                        'Units Count' => count($this->units),
                        'Periods Count' => count($this->periodes),
                        'Standards Count' => count($this->standars),
                        'Selected Period' => $this->selectedPeriode,
                        'Selected Unit' => $this->selectedUnit,
                        'Chart Data Keys' => array_keys($this->chartData),
                        'Has Assignment Data' => AssignPengisian::where('is_active', true)->exists(),
                    ];
                    
                    \Filament\Notifications\Notification::make()
                        ->title('Debug Information')
                        ->body(json_encode($debugInfo, JSON_PRETTY_PRINT))
                        ->info()
                        ->persistent()
                        ->send();
                }),
        ];
    }
}