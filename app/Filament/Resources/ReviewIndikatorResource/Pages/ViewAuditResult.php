<?php

namespace App\Filament\Resources\ReviewIndikatorResource\Pages;

use Filament\Forms;
use Filament\Forms\Form;
use Filament\Actions\Action;
use App\Models\AssignPengisian;
use App\Exports\AuditResultExport;
use Filament\Resources\Pages\Page;
use Illuminate\Support\Facades\Auth;
use Maatwebsite\Excel\Facades\Excel;
use Filament\Forms\Contracts\HasForms;
use Filament\Actions\Contracts\HasActions;
use Filament\Forms\Concerns\InteractsWithForms;
use App\Filament\Resources\ReviewIndikatorResource;
use Filament\Actions\Concerns\InteractsWithActions;

class ViewAuditResult extends Page implements HasForms, HasActions
{
    use InteractsWithForms, InteractsWithActions;

    protected static string $resource = ReviewIndikatorResource::class;
    protected static string $view = 'filament.resources.review-indikator-resource.pages.view-audit-result';
    protected static ?string $navigationIcon = 'heroicon-o-eye';
    protected static bool $shouldRegisterNavigation = false;

    public ?AssignPengisian $assignment = null;
    public ?string $assignmentId = null;
    public string $activeTab = 'overview';
    public string $auditStatus = 'open';
    public array $statistik = [];
    public array $chartData = [];
    public array $auditeeAnalysis = [];
    public array $auditor1Analysis = [];
    public array $auditor2Analysis = [];
    public array $overallAnalysis = [];
    public array $standardAchievementAnalysis = [];
    public array $auditor1vs2Analysis = [];

    public function mount(): void
    {
        $this->assignmentId = request()->route('assignmentId');

        if ($this->assignmentId) {
            $this->assignment = AssignPengisian::with([
                'unitIndikator.unit',
                'unitIndikator.unitIndikatorStandars.standar',
                'unitIndikator.unitIndikatorStandars.unitIndikatorIndikators.indikator.subStandar',
                'unitIndikator.unitIndikatorStandars.unitIndikatorIndikators.unitIndikatorIsiIndikators.isiIndikator',
                'periode',
                'unitIndikator.auditeeUser',
                'assignAuditors.auditor1Relation',
                'assignAuditors.auditor2Relation',
                'pengisianIndikators.reviewAuditor1',
                'pengisianIndikators.reviewAuditor2',
                'pengisianIndikators.unitIndikatorIsiIndikator.isiIndikator'
            ])->findOrFail($this->assignmentId);

            $this->validateUserAccess();
            $this->prepareAllAnalysisData();
            $this->determineAuditStatus();
        } else {
            abort(404, 'Assignment not found');
        }
    }

    protected function validateUserAccess(): void
    {
        $user = Auth::user();
        $hasAccess = false;

        $allowedRoles = ['super_admin', 'p2mpp', 'pimpinan', 'auditor', 'auditee'];
        if ($user->hasAnyRole($allowedRoles)) {
            $hasAccess = true;
        }

        if (!$hasAccess) {
            abort(403, 'Anda tidak memiliki akses untuk melihat hasil audit ini.');
        }

        if ($this->assignment->pengisianIndikators->isEmpty()) {
            abort(403, 'Belum ada pengisian untuk ditampilkan.');
        }

        if (!$this->assignment->is_active) {
            abort(403, 'Assignment ini tidak aktif.');
        }
    }

    protected function prepareAllAnalysisData(): void
    {
        $this->statistik = $this->calculateStatistik();
        $this->chartData = $this->prepareChartData();
        $this->auditeeAnalysis = $this->prepareAuditeeAnalysis();

        $this->auditor1Analysis = $this->prepareAuditor1Analysis();
        $this->auditor2Analysis = $this->prepareAuditor2Analysis();
        $this->overallAnalysis = $this->prepareOverallAnalysis();
        $this->standardAchievementAnalysis = $this->prepareStandardAchievementAnalysis(); // New
        $this->auditor1vs2Analysis = $this->prepareAuditor1vs2Analysis(); // New
    }

    protected function determineAuditStatus(): void
    {
        $hasIncomplete = false;
        $hasNotSesuai = false;
        
        foreach ($this->assignment->pengisianIndikators as $pengisian) {
            $review1 = $pengisian->reviewAuditor1;
            $review2 = $pengisian->reviewAuditor2;

            // Check if any review is incomplete
            if (!$review1 || $review1->status !== 'reviewed' || 
                !$review2 || $review2->status !== 'reviewed') {
                $hasIncomplete = true;
                break;
            }

            // Check if any review has "tidak_sesuai"
            if ($review1->status_temuan === 'tidak_sesuai' || 
                $review2->status_temuan === 'tidak_sesuai') {
                $hasNotSesuai = true;
            }
        }

        // Return OPEN if incomplete reviews or any "tidak_sesuai" found
        $this->auditStatus = ($hasIncomplete || $hasNotSesuai) ? 'open' : 'close';
    }

    protected function calculateStatistik(): array
    {
        $totalUiIsiIndikators = collect();
        foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                foreach ($unitIndikator->unitIndikatorIsiIndikators as $uiIsiIndikator) {
                    $totalUiIsiIndikators->push($uiIsiIndikator);
                }
            }
        }

        $totalItems = $totalUiIsiIndikators->count();
        $pengisianData = $this->assignment->pengisianIndikators->keyBy('ui_isi_indikator_id');

        $statusCounts = [
            'tercapai' => 0,
            'tidak_tercapai' => 0,
            'belum_diisi' => 0,
        ];

        foreach ($totalUiIsiIndikators as $uiIsiIndikator) {
            $pengisian = $pengisianData->get($uiIsiIndikator->id);

            if ($pengisian && $pengisian->isi) {
                $statusCounts[$pengisian->isi]++;
            } else {
                $statusCounts['belum_diisi']++;
            }
        }

        return [
            'total_items' => $totalItems,
            'tercapai' => $statusCounts['tercapai'],
            'tidak_tercapai' => $statusCounts['tidak_tercapai'],
            'belum_diisi' => $statusCounts['belum_diisi'],
            'percentage_tercapai' => $totalItems > 0 ? round(($statusCounts['tercapai'] / $totalItems) * 100, 2) : 0,
            'percentage_tidak_tercapai' => $totalItems > 0 ? round(($statusCounts['tidak_tercapai'] / $totalItems) * 100, 2) : 0,
            'percentage_belum_diisi' => $totalItems > 0 ? round(($statusCounts['belum_diisi'] / $totalItems) * 100, 2) : 0,
            'percentage_completion' => $totalItems > 0 ? round((($statusCounts['tercapai'] + $statusCounts['tidak_tercapai']) / $totalItems) * 100, 2) : 0,
        ];
    }

    protected function prepareChartData(): array
    {
        $standarData = [];
        $subStandarData = [];
        $pengisianData = $this->assignment->pengisianIndikators->keyBy('ui_isi_indikator_id');

        foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
            $standar = $unitStandar->standar;
            $standarKey = $standar->kode_standar . ' - ' . $standar->nama_standar;

            if (!isset($standarData[$standarKey])) {
                $standarData[$standarKey] = [
                    'name' => $standarKey,
                    'tercapai' => 0,
                    'tidak_tercapai' => 0,
                    'belum_diisi' => 0,
                    'total' => 0,
                ];
            }

            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                $indikator = $unitIndikator->indikator;
                $subStandar = $indikator->subStandar;
                $subStandarKey = ($subStandar ? $subStandar->nama_sub_standar : 'Tanpa Sub Standar') . ' (' . $standarKey . ')';

                if (!isset($subStandarData[$subStandarKey])) {
                    $subStandarData[$subStandarKey] = [
                        'name' => $subStandar ? $subStandar->nama_sub_standar : 'Tanpa Sub Standar',
                        'standar' => $standarKey,
                        'tercapai' => 0,
                        'tidak_tercapai' => 0,
                        'belum_diisi' => 0,
                        'total' => 0,
                    ];
                }

                foreach ($unitIndikator->unitIndikatorIsiIndikators as $uiIsiIndikator) {
                    $pengisian = $pengisianData->get($uiIsiIndikator->id);

                    $standarData[$standarKey]['total']++;
                    $subStandarData[$subStandarKey]['total']++;

                    if ($pengisian && $pengisian->isi) {
                        $standarData[$standarKey][$pengisian->isi]++;
                        $subStandarData[$subStandarKey][$pengisian->isi]++;
                    } else {
                        $standarData[$standarKey]['belum_diisi']++;
                        $subStandarData[$subStandarKey]['belum_diisi']++;
                    }
                }
            }
        }

        foreach ($standarData as $key => $data) {
            if ($data['total'] > 0) {
                $standarData[$key]['percentage_tercapai'] = round(($data['tercapai'] / $data['total']) * 100, 2);
                $standarData[$key]['percentage_tidak_tercapai'] = round(($data['tidak_tercapai'] / $data['total']) * 100, 2);
                $standarData[$key]['percentage_belum_diisi'] = round(($data['belum_diisi'] / $data['total']) * 100, 2);
            }
        }

        foreach ($subStandarData as $key => $data) {
            if ($data['total'] > 0) {
                $subStandarData[$key]['percentage_tercapai'] = round(($data['tercapai'] / $data['total']) * 100, 2);
                $subStandarData[$key]['percentage_tidak_tercapai'] = round(($data['tidak_tercapai'] / $data['total']) * 100, 2);
                $subStandarData[$key]['percentage_belum_diisi'] = round(($data['belum_diisi'] / $data['total']) * 100, 2);
            }
        }

        return [
            'standar' => array_values($standarData),
            'sub_standar' => array_values($subStandarData),
            'overview' => [
                [
                    'status' => 'Tercapai',
                    'count' => $this->statistik['tercapai'],
                    'percentage' => $this->statistik['percentage_tercapai'],
                    'color' => '#10B981',
                ],
                [
                    'status' => 'Tidak Tercapai',
                    'count' => $this->statistik['tidak_tercapai'],
                    'percentage' => $this->statistik['percentage_tidak_tercapai'],
                    'color' => '#EF4444',
                ],
                [
                    'status' => 'Belum Diisi',
                    'count' => $this->statistik['belum_diisi'],
                    'percentage' => $this->statistik['percentage_belum_diisi'],
                    'color' => '#6B7280',
                ],
            ],
        ];
    }

    protected function prepareAuditeeAnalysis(): array
    {
        $analysis = [
            'total_items' => 0,
            'filled_items' => 0,
            'tercapai' => 0,
            'tidak_tercapai' => 0,
            'belum_diisi' => 0,
            'percentage_tercapai' => 0,
            'percentage_tidak_tercapai' => 0,
            'percentage_belum_diisi' => 0,
            'percentage_completion' => 0,
            'first_filled_at' => null,
            'last_updated_at' => null,
            'standar_analysis' => [],
            'sub_standar_analysis' => [],
        ];

        $totalUiIsiIndikators = collect();
        foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                foreach ($unitIndikator->unitIndikatorIsiIndikators as $uiIsiIndikator) {
                    $totalUiIsiIndikators->push($uiIsiIndikator);
                }
            }
        }

        $analysis['total_items'] = $totalUiIsiIndikators->count();
        $pengisianData = $this->assignment->pengisianIndikators->keyBy('ui_isi_indikator_id');

        $statusCounts = [
            'tercapai' => 0,
            'tidak_tercapai' => 0,
            'belum_diisi' => 0,
        ];

        $filledDates = [];
        $updatedDates = [];

        foreach ($totalUiIsiIndikators as $uiIsiIndikator) {
            $pengisian = $pengisianData->get($uiIsiIndikator->id);

            if ($pengisian && $pengisian->isi) {
                $statusCounts[$pengisian->isi]++;
                $analysis['filled_items']++;

                if ($pengisian->created_at) {
                    $filledDates[] = $pengisian->created_at;
                }
                if ($pengisian->updated_at) {
                    $updatedDates[] = $pengisian->updated_at;
                }
            } else {
                $statusCounts['belum_diisi']++;
            }
        }

        $analysis['tercapai'] = $statusCounts['tercapai'];
        $analysis['tidak_tercapai'] = $statusCounts['tidak_tercapai'];
        $analysis['belum_diisi'] = $statusCounts['belum_diisi'];

        if ($analysis['total_items'] > 0) {
            $analysis['percentage_tercapai'] = round(($statusCounts['tercapai'] / $analysis['total_items']) * 100, 2);
            $analysis['percentage_tidak_tercapai'] = round(($statusCounts['tidak_tercapai'] / $analysis['total_items']) * 100, 2);
            $analysis['percentage_belum_diisi'] = round(($statusCounts['belum_diisi'] / $analysis['total_items']) * 100, 2);
            $analysis['percentage_completion'] = round((($statusCounts['tercapai'] + $statusCounts['tidak_tercapai']) / $analysis['total_items']) * 100, 2);
        }

        if (!empty($filledDates)) {
            $analysis['first_filled_at'] = collect($filledDates)->min()->format('d/m/Y H:i');
        }

        if (!empty($updatedDates)) {
            $analysis['last_updated_at'] = collect($updatedDates)->max()->format('d/m/Y H:i');
        }

        // Prepare standar and sub standar analysis
        $standarData = [];
        $subStandarData = [];

        foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
            $standar = $unitStandar->standar;
            $standarKey = $standar->kode_standar . ' - ' . $standar->nama_standar;

            if (!isset($standarData[$standarKey])) {
                $standarData[$standarKey] = [
                    'standar_code' => $standar->kode_standar,
                    'standar_name' => $standar->nama_standar,
                    'total_items' => 0,
                    'tercapai' => 0,
                    'tidak_tercapai' => 0,
                    'belum_diisi' => 0,
                ];
            }

            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                $indikator = $unitIndikator->indikator;
                $subStandar = $indikator->subStandar;
                $subStandarKey = ($subStandar ? $subStandar->nama_sub_standar : 'Tanpa Sub Standar');

                $fullSubStandarKey = $standarKey . '|' . $subStandarKey;
                if (!isset($subStandarData[$fullSubStandarKey])) {
                    $subStandarData[$fullSubStandarKey] = [
                        'standar_code' => $standar->kode_standar,
                        'standar_name' => $standar->nama_standar,
                        'sub_standar_name' => $subStandarKey,
                        'total_items' => 0,
                        'tercapai' => 0,
                        'tidak_tercapai' => 0,
                        'belum_diisi' => 0,
                    ];
                }

                foreach ($unitIndikator->unitIndikatorIsiIndikators as $uiIsiIndikator) {
                    $pengisian = $pengisianData->get($uiIsiIndikator->id);

                    $standarData[$standarKey]['total_items']++;
                    $subStandarData[$fullSubStandarKey]['total_items']++;

                    if ($pengisian && $pengisian->isi) {
                        $standarData[$standarKey][$pengisian->isi]++;
                        $subStandarData[$fullSubStandarKey][$pengisian->isi]++;
                    } else {
                        $standarData[$standarKey]['belum_diisi']++;
                        $subStandarData[$fullSubStandarKey]['belum_diisi']++;
                    }
                }
            }
        }

        // kalkulasi persentase untuk standar
        foreach ($standarData as $key => $data) {
            if ($data['total_items'] > 0) {
                $standarData[$key]['percentage_tercapai'] = round(($data['tercapai'] / $data['total_items']) * 100, 2);
                $standarData[$key]['percentage_tidak_tercapai'] = round(($data['tidak_tercapai'] / $data['total_items']) * 100, 2);
                $standarData[$key]['percentage_belum_diisi'] = round(($data['belum_diisi'] / $data['total_items']) * 100, 2);
            }
        }

        // Kalkulasi persentase untuk sub standar
        foreach ($subStandarData as $key => $data) {
            if ($data['total_items'] > 0) {
                $subStandarData[$key]['percentage_tercapai'] = round(($data['tercapai'] / $data['total_items']) * 100, 2);
                $subStandarData[$key]['percentage_tidak_tercapai'] = round(($data['tidak_tercapai'] / $data['total_items']) * 100, 2);
                $subStandarData[$key]['percentage_belum_diisi'] = round(($data['belum_diisi'] / $data['total_items']) * 100, 2);
            }
        }

        $analysis['standar_analysis'] = array_values($standarData);
        $analysis['sub_standar_analysis'] = array_values($subStandarData);

        return $analysis;
    }

    protected function prepareAuditor1Analysis(): array
    {
        $analysis = [
            'total_items' => 0,
            'total_reviewed' => 0,
            'sesuai' => 0,
            'tidak_sesuai' => 0,
            'belum_review' => 0,
            'percentage_complete' => 0,
            'percentage_sesuai' => 0,
            'percentage_tidak_sesuai' => 0,
            'percentage_belum_review' => 0,
            'first_reviewed_at' => null,
            'last_reviewed_at' => null,
            'findings_summary' => [],
            'standar_analysis' => [],
            'sub_standar_analysis' => [],
        ];

        $analysis['total_items'] = $this->assignment->pengisianIndikators->count();
        $findings = [];
        $standarData = [];
        $subStandarData = [];
        $reviewedDates = [];

        foreach ($this->assignment->pengisianIndikators as $pengisian) {
            $review = $pengisian->reviewAuditor1;
            $unitIsiIndikator = $pengisian->unitIndikatorIsiIndikator;
            $unitIndikator = $unitIsiIndikator->unitIndikatorIndikator;
            $standar = $unitIndikator->unitIndikatorStandar->standar;
            $subStandar = $unitIndikator->indikator->subStandar;

            $standarKey = $standar->kode_standar . ' - ' . $standar->nama_standar;
            $subStandarKey = ($subStandar ? $subStandar->nama_sub_standar : 'Tanpa Sub Standar');

            // Initialize standar data
            if (!isset($standarData[$standarKey])) {
                $standarData[$standarKey] = [
                    'standar_code' => $standar->kode_standar,
                    'standar_name' => $standar->nama_standar,
                    'total_items' => 0,
                    'sesuai' => 0,
                    'tidak_sesuai' => 0,
                    'belum_review' => 0,
                ];
            }

            // Initialize sub standar data
            $fullSubStandarKey = $standarKey . '|' . $subStandarKey;
            if (!isset($subStandarData[$fullSubStandarKey])) {
                $subStandarData[$fullSubStandarKey] = [
                    'standar_code' => $standar->kode_standar,
                    'standar_name' => $standar->nama_standar,
                    'sub_standar_name' => $subStandarKey,
                    'total_items' => 0,
                    'sesuai' => 0,
                    'tidak_sesuai' => 0,
                    'belum_review' => 0,
                    'rank' => 0,
                    'status' => 'open'
                ];
            }

            $standarData[$standarKey]['total_items']++;
            $subStandarData[$fullSubStandarKey]['total_items']++;

            if ($review && $review->status === 'reviewed') {
                $analysis['total_reviewed']++;

                if ($review->reviewed_at) {
                    $reviewedDates[] = $review->reviewed_at;
                }

                if ($review->status_temuan === 'sesuai') {
                    $analysis['sesuai']++;
                    $standarData[$standarKey]['sesuai']++;
                    $subStandarData[$fullSubStandarKey]['sesuai']++;
                } else {
                    $analysis['tidak_sesuai']++;
                    $standarData[$standarKey]['tidak_sesuai']++;
                    $subStandarData[$fullSubStandarKey]['tidak_sesuai']++;

                    if ($review->hasil_pengamatan) {
                        $findings[] = $review->hasil_pengamatan;
                    }
                }
            } else {
                $analysis['belum_review']++;
                $standarData[$standarKey]['belum_review']++;
                $subStandarData[$fullSubStandarKey]['belum_review']++;
            }
        }

        // Calculate percentages
        if ($analysis['total_items'] > 0) {
            $analysis['percentage_complete'] = round(($analysis['total_reviewed'] / $analysis['total_items']) * 100, 2);
            $analysis['percentage_belum_review'] = round(($analysis['belum_review'] / $analysis['total_items']) * 100, 2);
        }

        if ($analysis['total_reviewed'] > 0) {
            $analysis['percentage_sesuai'] = round(($analysis['sesuai'] / $analysis['total_reviewed']) * 100, 2);
            $analysis['percentage_tidak_sesuai'] = round(($analysis['tidak_sesuai'] / $analysis['total_reviewed']) * 100, 2);
        }

        if (!empty($reviewedDates)) {
            $analysis['first_reviewed_at'] = collect($reviewedDates)->min()->format('d/m/Y H:i');
            $analysis['last_reviewed_at'] = collect($reviewedDates)->max()->format('d/m/Y H:i');
        }

        // Calculate percentages for standar
        foreach ($standarData as $key => $data) {
            $totalReviewed = $data['sesuai'] + $data['tidak_sesuai'];
            $standarData[$key]['percentage_sesuai'] = $totalReviewed > 0 ? round(($data['sesuai'] / $totalReviewed) * 100, 2) : 0;
            $standarData[$key]['percentage_tidak_sesuai'] = $totalReviewed > 0 ? round(($data['tidak_sesuai'] / $totalReviewed) * 100, 2) : 0;
            $standarData[$key]['percentage_complete'] = $data['total_items'] > 0 ? round(($totalReviewed / $data['total_items']) * 100, 2) : 0;
        }

        // Calculate percentages for sub standar
        foreach ($subStandarData as $key => $data) {
            $totalReviewed = $data['sesuai'] + $data['tidak_sesuai'];
            $subStandarData[$key]['percentage_sesuai'] = $totalReviewed > 0 ? round(($data['sesuai'] / $totalReviewed) * 100, 2) : 0;
            $subStandarData[$key]['percentage_tidak_sesuai'] = $totalReviewed > 0 ? round(($data['tidak_sesuai'] / $totalReviewed) * 100, 2) : 0;
            $subStandarData[$key]['percentage_complete'] = $data['total_items'] > 0 ? round(($totalReviewed / $data['total_items']) * 100, 2) : 0;
        }

        $analysis['findings_summary'] = array_slice($findings, 0, 10);
        $analysis['standar_analysis'] = array_values($standarData);
        $analysis['sub_standar_analysis'] = array_values($subStandarData);

        return $analysis;
    }

    protected function prepareAuditor2Analysis(): array
    {
        $analysis = [
            'total_items' => 0,
            'total_reviewed' => 0,
            'sesuai' => 0,
            'tidak_sesuai' => 0,
            'belum_review' => 0,
            'percentage_complete' => 0,
            'percentage_sesuai' => 0,
            'percentage_tidak_sesuai' => 0,
            'percentage_belum_review' => 0,
            'first_reviewed_at' => null,
            'last_reviewed_at' => null,
            'findings_summary' => [],
            'standar_analysis' => [],
            'sub_standar_analysis' => [],
        ];

        $analysis['total_items'] = $this->assignment->pengisianIndikators->count();
        $findings = [];
        $standarData = [];
        $subStandarData = [];
        $reviewedDates = [];

        // Group pengisian by standar and sub standar
        foreach ($this->assignment->pengisianIndikators as $pengisian) {
            $review = $pengisian->reviewAuditor2;
            $unitIsiIndikator = $pengisian->unitIndikatorIsiIndikator;
            $unitIndikator = $unitIsiIndikator->unitIndikatorIndikator;
            $standar = $unitIndikator->unitIndikatorStandar->standar;
            $subStandar = $unitIndikator->indikator->subStandar;

            $standarKey = $standar->kode_standar . ' - ' . $standar->nama_standar;
            $subStandarKey = ($subStandar ? $subStandar->nama_sub_standar : 'Tanpa Sub Standar');

            // Initialize standar data
            if (!isset($standarData[$standarKey])) {
                $standarData[$standarKey] = [
                    'standar_code' => $standar->kode_standar,
                    'standar_name' => $standar->nama_standar,
                    'total_items' => 0,
                    'sesuai' => 0,
                    'tidak_sesuai' => 0,
                    'belum_review' => 0,
                ];
            }

            // Initialize sub standar data
            $fullSubStandarKey = $standarKey . '|' . $subStandarKey;
            if (!isset($subStandarData[$fullSubStandarKey])) {
                $subStandarData[$fullSubStandarKey] = [
                    'standar_code' => $standar->kode_standar,
                    'standar_name' => $standar->nama_standar,
                    'sub_standar_name' => $subStandarKey,
                    'total_items' => 0,
                    'sesuai' => 0,
                    'tidak_sesuai' => 0,
                    'belum_review' => 0,
                ];
            }

            $standarData[$standarKey]['total_items']++;
            $subStandarData[$fullSubStandarKey]['total_items']++;

            if ($review && $review->status === 'reviewed') {
                $analysis['total_reviewed']++;

                if ($review->reviewed_at) {
                    $reviewedDates[] = $review->reviewed_at;
                }

                if ($review->status_temuan === 'sesuai') {
                    $analysis['sesuai']++;
                    $standarData[$standarKey]['sesuai']++;
                    $subStandarData[$fullSubStandarKey]['sesuai']++;
                } else {
                    $analysis['tidak_sesuai']++;
                    $standarData[$standarKey]['tidak_sesuai']++;
                    $subStandarData[$fullSubStandarKey]['tidak_sesuai']++;

                    if ($review->hasil_pengamatan) {
                        $findings[] = $review->hasil_pengamatan;
                    }
                }
            } else {
                $analysis['belum_review']++;
                $standarData[$standarKey]['belum_review']++;
                $subStandarData[$fullSubStandarKey]['belum_review']++;
            }
        }

        // Calculate percentages (same logic as auditor1)
        if ($analysis['total_items'] > 0) {
            $analysis['percentage_complete'] = round(($analysis['total_reviewed'] / $analysis['total_items']) * 100, 2);
            $analysis['percentage_belum_review'] = round(($analysis['belum_review'] / $analysis['total_items']) * 100, 2);
        }

        if ($analysis['total_reviewed'] > 0) {
            $analysis['percentage_sesuai'] = round(($analysis['sesuai'] / $analysis['total_reviewed']) * 100, 2);
            $analysis['percentage_tidak_sesuai'] = round(($analysis['tidak_sesuai'] / $analysis['total_reviewed']) * 100, 2);
        }

        if (!empty($reviewedDates)) {
            $analysis['first_reviewed_at'] = collect($reviewedDates)->min()->format('d/m/Y H:i');
            $analysis['last_reviewed_at'] = collect($reviewedDates)->max()->format('d/m/Y H:i');
        }

        // Calculate percentages for standar
        foreach ($standarData as $key => $data) {
            $totalReviewed = $data['sesuai'] + $data['tidak_sesuai'];
            $standarData[$key]['percentage_sesuai'] = $totalReviewed > 0 ? round(($data['sesuai'] / $totalReviewed) * 100, 2) : 0;
            $standarData[$key]['percentage_tidak_sesuai'] = $totalReviewed > 0 ? round(($data['tidak_sesuai'] / $totalReviewed) * 100, 2) : 0;
            $standarData[$key]['percentage_complete'] = $data['total_items'] > 0 ? round(($totalReviewed / $data['total_items']) * 100, 2) : 0;
        }

        // Calculate percentages for sub standar
        foreach ($subStandarData as $key => $data) {
            $totalReviewed = $data['sesuai'] + $data['tidak_sesuai'];
            $subStandarData[$key]['percentage_sesuai'] = $totalReviewed > 0 ? round(($data['sesuai'] / $totalReviewed) * 100, 2) : 0;
            $subStandarData[$key]['percentage_tidak_sesuai'] = $totalReviewed > 0 ? round(($data['tidak_sesuai'] / $totalReviewed) * 100, 2) : 0;
            $subStandarData[$key]['percentage_complete'] = $data['total_items'] > 0 ? round(($totalReviewed / $data['total_items']) * 100, 2) : 0;
        }

        $analysis['findings_summary'] = array_slice($findings, 0, 10);
        $analysis['standar_analysis'] = array_values($standarData);
        $analysis['sub_standar_analysis'] = array_values($subStandarData);

        return $analysis;
    }

    protected function prepareOverallAnalysis(): array
    {
        $analysis = [
            'total_conflicts' => 0,
            'agreement_rate' => 0,
            'consensus_items' => 0,
            'audit_quality_score' => 0,
            'standar_comparison' => [],
            'sub_standar_comparison' => [],
        ];

        $totalReviewedByBoth = 0;
        $agreements = 0;
        $standarComparison = [];
        $subStandarComparison = [];

        foreach ($this->assignment->pengisianIndikators as $pengisian) {
            $auditeeStatus = $pengisian->isi;
            $auditor1Review = $pengisian->reviewAuditor1;
            // $auditor2Review = $pengisian->reviewAuditor2;

            $unitIsiIndikator = $pengisian->unitIndikatorIsiIndikator;
            $unitIndikator = $unitIsiIndikator->unitIndikatorIndikator;
            $standar = $unitIndikator->unitIndikatorStandar->standar;
            $subStandar = $unitIndikator->indikator->subStandar;

            $standarKey = $standar->kode_standar . ' - ' . $standar->nama_standar;
            $subStandarKey = ($subStandar ? $subStandar->nama_sub_standar : 'Tanpa Sub Standar');

            // Initialize standar comparison
            if (!isset($standarComparison[$standarKey])) {
                $standarComparison[$standarKey] = [
                    'standar_code' => $standar->kode_standar,
                    'standar_name' => $standar->nama_standar,
                    'total_items' => 0,
                    'auditee_tercapai' => 0,
                    'auditee_tidak_tercapai' => 0,
                    'auditor1_sesuai' => 0,
                    'auditor1_tidak_sesuai' => 0,
                    'agreements' => 0,
                    'conflicts' => 0,
                ];
            }

            // Initialize sub standar comparison
            $fullSubStandarKey = $standarKey . '|' . $subStandarKey;
            if (!isset($subStandarComparison[$fullSubStandarKey])) {
                $subStandarComparison[$fullSubStandarKey] = [
                    'standar_code' => $standar->kode_standar,
                    'standar_name' => $standar->nama_standar,
                    'sub_standar_name' => $subStandarKey,
                    'total_items' => 0,
                    'auditee_tercapai' => 0,
                    'auditee_tidak_tercapai' => 0,
                    'auditor1_sesuai' => 0,
                    'auditor1_tidak_sesuai' => 0,
                    'agreements' => 0,
                    'conflicts' => 0,
                ];
            }

            $standarComparison[$standarKey]['total_items']++;
            $subStandarComparison[$fullSubStandarKey]['total_items']++;

            // Hitung hasil auditee
            if ($auditeeStatus === 'tercapai') {
                $standarComparison[$standarKey]['auditee_tercapai']++;
                $subStandarComparison[$fullSubStandarKey]['auditee_tercapai']++;
            } elseif ($auditeeStatus === 'tidak_tercapai') {
                $standarComparison[$standarKey]['auditee_tidak_tercapai']++;
                $subStandarComparison[$fullSubStandarKey]['auditee_tidak_tercapai']++;
            }

            // Hitung hasil review auditor1
            if ($auditor1Review && $auditor1Review->status === 'reviewed') {
                if ($auditor1Review->status_temuan === 'sesuai') {
                    $standarComparison[$standarKey]['auditor1_sesuai']++;
                    $subStandarComparison[$fullSubStandarKey]['auditor1_sesuai']++;
                } else {
                    $standarComparison[$standarKey]['auditor1_tidak_sesuai']++;
                    $subStandarComparison[$fullSubStandarKey]['auditor1_tidak_sesuai']++;
                }

                // Check kesamaan hasil antara auditee and auditor1
                $auditeeAgreesWithAuditor = false;
                if ($auditeeStatus === 'tercapai' && $auditor1Review->status_temuan === 'sesuai') {
                    $auditeeAgreesWithAuditor = true;
                } elseif ($auditeeStatus === 'tidak_tercapai' && $auditor1Review->status_temuan === 'tidak_sesuai') {
                    $auditeeAgreesWithAuditor = true;
                }

                if ($auditeeAgreesWithAuditor) {
                    $agreements++;
                    $standarComparison[$standarKey]['agreements']++;
                    $subStandarComparison[$fullSubStandarKey]['agreements']++;
                } else {
                    $analysis['total_conflicts']++;
                    $standarComparison[$standarKey]['conflicts']++;
                    $subStandarComparison[$fullSubStandarKey]['conflicts']++;
                }

                $totalReviewedByBoth++;
            }
        }

        // Calculate agreement rate and consensus items
        if ($totalReviewedByBoth > 0) {
            $analysis['agreement_rate'] = round(($agreements / $totalReviewedByBoth) * 100, 2);
            $analysis['consensus_items'] = $agreements;
        }

        // Calculate percentages for standar comparison
        foreach ($standarComparison as $key => $data) {
            $totalReviewed = $data['total_items'];
            if ($totalReviewed > 0) {
                $standarComparison[$key]['auditee_tercapai_percentage'] = round(($data['auditee_tercapai'] / $totalReviewed) * 100, 2);
                $standarComparison[$key]['auditee_tidak_tercapai_percentage'] = round(($data['auditee_tidak_tercapai'] / $totalReviewed) * 100, 2);
                $standarComparison[$key]['auditor1_sesuai_percentage'] = round(($data['auditor1_sesuai'] / $totalReviewed) * 100, 2);
                $standarComparison[$key]['auditor1_tidak_sesuai_percentage'] = round(($data['auditor1_tidak_sesuai'] / $totalReviewed) * 100, 2);
                $standarComparison[$key]['agreement_percentage'] = round(($data['agreements'] / $totalReviewed) * 100, 2);
            }
        }

        // Calculate percentages for sub standar comparison
        foreach ($subStandarComparison as $key => $data) {
            $totalReviewed = $data['total_items'];
            if ($totalReviewed > 0) {
                $subStandarComparison[$key]['auditee_tercapai_percentage'] = round(($data['auditee_tercapai'] / $totalReviewed) * 100, 2);
                $subStandarComparison[$key]['auditee_tidak_tercapai_percentage'] = round(($data['auditee_tidak_tercapai'] / $totalReviewed) * 100, 2);
                $subStandarComparison[$key]['auditor1_sesuai_percentage'] = round(($data['auditor1_sesuai'] / $totalReviewed) * 100, 2);
                $subStandarComparison[$key]['auditor1_tidak_sesuai_percentage'] = round(($data['auditor1_tidak_sesuai'] / $totalReviewed) * 100, 2);
                $subStandarComparison[$key]['agreement_percentage'] = round(($data['agreements'] / $totalReviewed) * 100, 2);
            }
        }

        // Set comparison arrays
        $analysis['standar_comparison'] = array_values($standarComparison);
        $analysis['sub_standar_comparison'] = array_values($subStandarComparison);

        // Calculate audit quality score
        // $completionRate1 = $this->auditor1Analysis['percentage_complete'] ?? 0;
        // $completionRate2 = $this->auditor2Analysis['percentage_complete'] ?? 0;
        // $avgCompletion = ($completionRate1 + $completionRate2) / 2;
        // $agreementRate = $analysis['agreement_rate'];

        // $analysis['audit_quality_score'] = round(($avgCompletion * 0.4) + ($agreementRate * 0.6), 2);

        return $analysis;
    }
    public function setActiveTab(string $tab): void
    {
        $this->activeTab = $tab;
    }

    protected function getViewItems(): array
    {
        $standarGroups = [];

        foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
            $standar = $unitStandar->standar;

            $standarIndex = null;
            foreach ($standarGroups as $index => $group) {
                if ($group['standar_id'] === $standar->id) {
                    $standarIndex = $index;
                    break;
                }
            }

            if ($standarIndex === null) {
                $standarGroups[] = [
                    'standar_id' => $standar->id,
                    'standar_name' => $standar->nama_standar,
                    'standar_code' => $standar->kode_standar,
                    'standar_description' => $standar->deskripsi ?? '',
                    'sub_standars' => [],
                ];
                $standarIndex = count($standarGroups) - 1;
            }

            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                $indikator = $unitIndikator->indikator;
                $subStandar = $indikator->subStandar;

                $isiIndikators = [];
                foreach ($unitIndikator->unitIndikatorIsiIndikators as $index => $unitIsiIndikator) {
                    $isiIndikator = $unitIsiIndikator->isiIndikator;
                    $existingPengisian = $this->assignment->pengisianIndikators
                        ->where('ui_isi_indikator_id', $unitIsiIndikator->id)
                        ->first();

                    if ($existingPengisian) {
                        $reviewAuditor1 = $existingPengisian->reviewAuditor1;
                        $reviewAuditor2 = $existingPengisian->reviewAuditor2;

                        $isiIndikators[] = [
                            'order' => $index + 1,
                            'isi_indikator' => $isiIndikator->isi_indikator,
                            'target' => $isiIndikator->target,

                            // Data dari UnitIndikatorIsiIndikator
                            'pertanyaan' => $unitIsiIndikator->pertanyaan,
                            'target' => $unitIsiIndikator->target,
                            'bukti' => $unitIsiIndikator->bukti,

                            // Pengisian data
                            'pengisian_isi' => $existingPengisian->isi,
                            'pengisian_bukti' => $existingPengisian->bukti,
                            'pengisian_faktor_penghambat' => $existingPengisian->faktor_penghambat,
                            'pengisian_answered_at' => $existingPengisian->answered_at,

                            // Review Auditor 1
                            'auditor1_status_temuan' => $reviewAuditor1?->status_temuan,
                            'auditor1_hasil_pengamatan' => $reviewAuditor1?->hasil_pengamatan,
                            'auditor1_status' => $reviewAuditor1?->status,
                            'auditor1_reviewed_at' => $reviewAuditor1?->reviewed_at,

                            // Review Auditor 2
                            'auditor2_status_temuan' => $reviewAuditor2?->status_temuan,
                            'auditor2_hasil_pengamatan' => $reviewAuditor2?->hasil_pengamatan,
                            'auditor2_status' => $reviewAuditor2?->status,
                            'auditor2_reviewed_at' => $reviewAuditor2?->reviewed_at,

                            // Conflict status
                            'has_conflict' => $existingPengisian->hasConflict(),
                        ];
                    }
                }

                if (!empty($isiIndikators)) {
                    $standarGroups[$standarIndex]['sub_standars'][] = [
                        'sub_standar_name' => $subStandar?->nama_sub_standar ?? 'Sub Standar',
                        'isi_indikators' => $isiIndikators,
                    ];
                }
            }
        }

        return $standarGroups;
    }

    public function getTitle(): string
    {
        return 'Hasil Audit - ' . ($this->assignment->unitIndikator->unit->nama_unit ?? 'Unknown');
    }

    public function getBreadcrumbs(): array
    {
        return [
            ReviewIndikatorResource::getUrl('index') => 'Review Audit',
            '#' => 'Hasil Audit',
        ];
    }

    protected function getHeaderActions(): array
    {
        return [
            Action::make('export')
                ->label('Export')
                ->icon('heroicon-o-arrow-down-tray')
                ->action(function ($record) {
                    return Excel::download(
                        new AuditResultExport($record),
                        'isi-standar-' . $record->id . '.xlsx'
                    );
                }),

            Action::make('back_to_list')
                ->label('Kembali ke Daftar')
                ->icon('heroicon-o-arrow-left')
                ->color('gray')
                ->url(ReviewIndikatorResource::getUrl('index')),
        ];
    }

    protected function prepareStandardAchievementAnalysis(): array
    {
        $analysis = [
            'sub_standar_analysis' => [],
            'open_items' => [],
        ];

        $subStandarData = [];
        $openItems = [];
        $pengisianData = $this->assignment->pengisianIndikators->keyBy('ui_isi_indikator_id');

        foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
            $standar = $unitStandar->standar;

            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                $indikator = $unitIndikator->indikator;
                $subStandar = $indikator->subStandar;
                $subStandarKey = ($subStandar ? $subStandar->nama_sub_standar : 'Tanpa Sub Standar');

                // Initialize sub standar data for achievement analysis
                if (!isset($subStandarData[$subStandarKey])) {
                    $subStandarData[$subStandarKey] = [
                        'standar_code' => $standar->kode_standar,
                        'standar_name' => $standar->nama_standar,
                        'sub_standar_name' => $subStandarKey,
                        'total_items' => 0,
                        'tercapai' => 0,
                        'percentage' => 0,
                        'status' => 'close',
                        'ranking' => 0,
                    ];
                }

                foreach ($unitIndikator->unitIndikatorIsiIndikators as $uiIsiIndikator) {
                    $pengisian = $pengisianData->get($uiIsiIndikator->id);
                    $subStandarData[$subStandarKey]['total_items']++;

                    if ($pengisian && $pengisian->isi === 'tercapai') {
                        $subStandarData[$subStandarKey]['tercapai']++;
                    } else {
                        // Collect open items (not achieved)
                        $auditor1Review = $pengisian ? $pengisian->reviewAuditor1 : null;

                        $openItems[] = [
                            'standar_code' => $standar->kode_standar,
                            'standar_name' => $standar->nama_standar,
                            'sub_standar_name' => $subStandarKey,
                            'indikator' => $uiIsiIndikator->isiIndikator->isi_indikator ?? 'N/A',
                            'status_temuan' => $auditor1Review ? $auditor1Review->status_temuan : 'Belum direview',
                            'hasil_pengamatan' => $auditor1Review ? $auditor1Review->hasil_pengamatan : '-',
                        ];
                    }
                }
            }
        }

        // Calculate percentages and determine status
        foreach ($subStandarData as $key => $data) {
            if ($data['total_items'] > 0) {
                $percentage = round(($data['tercapai'] / $data['total_items']) * 100, 2);
                $subStandarData[$key]['percentage'] = $percentage;
                $subStandarData[$key]['status'] = $percentage >= 100 ? 'close' : 'open';
            }
        }

        // Sort by percentage (descending) and then by total_items (descending) for tie-breaker
        $sortedData = collect($subStandarData)
            ->sortBy([
                ['percentage', 'desc'],      // Primary: Sort by percentage descending
                ['total_items', 'desc'],     // Secondary: Sort by total items descending
                ['sub_standar_name', 'asc']  // Tertiary: Sort by name ascending for consistency
            ])
            ->values()
            ->toArray();

        // Assign ranking - ALL 100% get rank 1, then continue from rank after count of 100%
        $perfectCount = 0; // Count how many have 100%
        $nonPerfectRank = 2; // Start ranking for non-100% items

        // First pass: count perfect scores and assign rank 1
        foreach ($sortedData as $index => $item) {
            if ($item['percentage'] >= 100) {
                $sortedData[$index]['ranking'] = 1;
                $perfectCount++;
            }
        }

        // Second pass: assign ranking for non-perfect scores
        $currentRank = $perfectCount + 1; // Start after all rank 1 items
        $lastPercentage = null;
        $rankOffset = 0;

        foreach ($sortedData as $index => $item) {
            if ($item['percentage'] < 100) {
                if ($lastPercentage !== null && $item['percentage'] < $lastPercentage) {
                    // Different percentage, increment rank
                    $currentRank += $rankOffset;
                    $rankOffset = 1;
                } else {
                    // Same percentage, keep same rank but increment offset for next different percentage
                    $rankOffset++;
                }

                $sortedData[$index]['ranking'] = $currentRank;
                $lastPercentage = $item['percentage'];
            }
        }

        $analysis['sub_standar_analysis'] = $sortedData;
        $analysis['open_items'] = $openItems;

        return $analysis;
    }

     protected function prepareAuditor1vs2Analysis(): array
    {
        $analysis = [
            'total_conflicts' => 0,
            'agreement_rate' => 0,
            'consensus_items' => 0,
            'sub_standar_comparison' => [],
            'conflict_items' => [],
        ];

        $totalReviewedByBoth = 0;
        $agreements = 0;
        $subStandarComparison = [];
        $conflictItems = [];

        foreach ($this->assignment->pengisianIndikators as $pengisian) {
            $auditor1Review = $pengisian->reviewAuditor1;
            $auditor2Review = $pengisian->reviewAuditor2;

            $unitIsiIndikator = $pengisian->unitIndikatorIsiIndikator;
            $unitIndikator = $unitIsiIndikator->unitIndikatorIndikator;
            $standar = $unitIndikator->unitIndikatorStandar->standar;
            $subStandar = $unitIndikator->indikator->subStandar;

            $standarKey = $standar->kode_standar . ' - ' . $standar->nama_standar;
            $subStandarKey = ($subStandar ? $subStandar->nama_sub_standar : 'Tanpa Sub Standar');

            // Initialize sub standar comparison
            $fullSubStandarKey = $standarKey . '|' . $subStandarKey;
            if (!isset($subStandarComparison[$fullSubStandarKey])) {
                $subStandarComparison[$fullSubStandarKey] = [
                    'standar_code' => $standar->kode_standar,
                    'standar_name' => $standar->nama_standar,
                    'sub_standar_name' => $subStandarKey,
                    'total_items' => 0,
                    'auditor1_sesuai' => 0,
                    'auditor1_tidak_sesuai' => 0,
                    'auditor1_belum_review' => 0,
                    'auditor2_sesuai' => 0,
                    'auditor2_tidak_sesuai' => 0,
                    'auditor2_belum_review' => 0,
                    'agreements' => 0,
                    'conflicts' => 0,
                    'both_reviewed' => 0,
                ];
            }

            $subStandarComparison[$fullSubStandarKey]['total_items']++;

            // Check review status for each auditor
            $auditor1HasReviewed = $auditor1Review && $auditor1Review->status === 'reviewed';
            $auditor2HasReviewed = $auditor2Review && $auditor2Review->status === 'reviewed';

            // Count auditor1 results
            if ($auditor1HasReviewed) {
                if ($auditor1Review->status_temuan === 'sesuai') {
                    $subStandarComparison[$fullSubStandarKey]['auditor1_sesuai']++;
                } else {
                    $subStandarComparison[$fullSubStandarKey]['auditor1_tidak_sesuai']++;
                }
            } else {
                $subStandarComparison[$fullSubStandarKey]['auditor1_belum_review']++;
            }

            // Count auditor2 results
            if ($auditor2HasReviewed) {
                if ($auditor2Review->status_temuan === 'sesuai') {
                    $subStandarComparison[$fullSubStandarKey]['auditor2_sesuai']++;
                } else {
                    $subStandarComparison[$fullSubStandarKey]['auditor2_tidak_sesuai']++;
                }
            } else {
                $subStandarComparison[$fullSubStandarKey]['auditor2_belum_review']++;
            }

            // Check agreements and conflicts (only when both reviewed)
            if ($auditor1HasReviewed && $auditor2HasReviewed) {
                $subStandarComparison[$fullSubStandarKey]['both_reviewed']++;
                $totalReviewedByBoth++;

                if ($auditor1Review->status_temuan === $auditor2Review->status_temuan) {
                    $agreements++;
                    $subStandarComparison[$fullSubStandarKey]['agreements']++;
                } else {
                    $analysis['total_conflicts']++;
                    $subStandarComparison[$fullSubStandarKey]['conflicts']++;
                    
                    // Add conflict item details
                    $conflictItems[] = [
                        'standar_code' => $standar->kode_standar,
                        'standar_name' => $standar->nama_standar,
                        'sub_standar_name' => $subStandarKey,
                        'item' => $unitIsiIndikator->isiIndikator->isi_indikator ?? 'Item tidak tersedia',
                        'auditor1_finding' => $auditor1Review->status_temuan,
                        'auditor1_note' => $auditor1Review->hasil_pengamatan,
                        'auditor2_finding' => $auditor2Review->status_temuan,
                        'auditor2_note' => $auditor2Review->hasil_pengamatan,
                        'auditor1_reviewed_at' => $auditor1Review->reviewed_at,
                        'auditor2_reviewed_at' => $auditor2Review->reviewed_at,
                    ];
                }
            }
        }

        // Calculate agreement rate and consensus items (only for items reviewed by both)
        if ($totalReviewedByBoth > 0) {
            $analysis['agreement_rate'] = round(($agreements / $totalReviewedByBoth) * 100, 2);
            $analysis['consensus_items'] = $agreements;
        }

        // Calculate percentages for sub standar comparison
        foreach ($subStandarComparison as $key => $data) {
            // Calculate auditor1 percentages
            $auditor1Total = $data['auditor1_sesuai'] + $data['auditor1_tidak_sesuai'];
            if ($auditor1Total > 0) {
                $subStandarComparison[$key]['auditor1_sesuai_percentage'] = round(($data['auditor1_sesuai'] / $auditor1Total) * 100, 2);
                $subStandarComparison[$key]['auditor1_tidak_sesuai_percentage'] = round(($data['auditor1_tidak_sesuai'] / $auditor1Total) * 100, 2);
            } else {
                $subStandarComparison[$key]['auditor1_sesuai_percentage'] = 0;
                $subStandarComparison[$key]['auditor1_tidak_sesuai_percentage'] = 0;
            }
            
            // Calculate auditor2 percentages
            $auditor2Total = $data['auditor2_sesuai'] + $data['auditor2_tidak_sesuai'];
            if ($auditor2Total > 0) {
                $subStandarComparison[$key]['auditor2_sesuai_percentage'] = round(($data['auditor2_sesuai'] / $auditor2Total) * 100, 2);
                $subStandarComparison[$key]['auditor2_tidak_sesuai_percentage'] = round(($data['auditor2_tidak_sesuai'] / $auditor2Total) * 100, 2);
            } else {
                $subStandarComparison[$key]['auditor2_sesuai_percentage'] = 0;
                $subStandarComparison[$key]['auditor2_tidak_sesuai_percentage'] = 0;
            }
            
            // Calculate agreement percentage (only for items reviewed by both)
            $bothReviewed = $data['both_reviewed'];
            if ($bothReviewed > 0) {
                $subStandarComparison[$key]['agreement_percentage'] = round(($data['agreements'] / $bothReviewed) * 100, 2);
            } else {
                $subStandarComparison[$key]['agreement_percentage'] = 0;
            }
        }

        $analysis['sub_standar_comparison'] = array_values($subStandarComparison);
        $analysis['conflict_items'] = $conflictItems;

        return $analysis;
    }

}
