<?php

namespace App\Filament\Resources\ReviewIndikatorResource\Pages;

use Filament\Forms;
use Filament\Forms\Form;
use Filament\Actions\Action;
use App\Models\AssignPengisian;
use App\Models\ReviewAuditor1;
use Filament\Resources\Pages\Page;
use Illuminate\Support\Facades\Auth;
use Filament\Forms\Contracts\HasForms;
use Filament\Notifications\Notification;
use Filament\Actions\Contracts\HasActions;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Actions\Concerns\InteractsWithActions;
use App\Filament\Resources\ReviewIndikatorResource;

class ReviewAudit2 extends Page implements HasForms, HasActions
{
    use InteractsWithForms, InteractsWithActions;

    protected static string $resource = ReviewIndikatorResource::class;
    protected static string $view = 'filament.resources.review-indikator-resource.pages.review-auditor2';
    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-check';
    protected static bool $shouldRegisterNavigation = false;

    public ?array $data = [];
    public ?AssignPengisian $assignment = null;
    public ?string $assignmentId = null;
    public string $activeTab = 'review';
    public array $statistik = [];
    public array $chartData = [];

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

            $this->prepareAnalysisData();

            $formData = [
                'assign_pengisian_id' => $this->assignment->id,
                'reviewed_at' => now(),
                'standar_groups' => $this->prepareReviewItems(),
            ];

            $this->form->fill($formData);
        } else {
            abort(404, 'Assignment not found');
        }
    }

    protected function validateUserAccess(): void
    {
        $user = Auth::user();
        $isAuditor2 = $this->assignment->assignAuditors &&
            $this->assignment->assignAuditors->auditor2 == $user->id;

        if (!$isAuditor2) {
            abort(403, 'Anda bukan auditor 2 untuk assignment ini.');
        }

        if ($this->assignment->pengisianIndikators->isEmpty()) {
            abort(403, 'Belum ada pengisian untuk direview. Tunggu auditee selesai mengisi.');
        }

        if ($this->assignment->status_pengisian !== 'selesai') {
            abort(403, 'Pengisian belum selesai. Status: ' . $this->assignment->status_pengisian);
        }

        if (!$this->assignment->is_active) {
            abort(403, 'Assignment ini tidak aktif.');
        }
    }

    protected function prepareReviewItems(): array
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
                    'unit_indikator_standar_id' => $unitStandar->id,
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
                        $reviewAuditor1 = $existingPengisian->getOrCreateReviewAuditor1();
                        $reviewAuditor2 = $existingPengisian->getOrCreateReviewAuditor2();

                        $isiIndikators[] = [
                            'isi_indikator_id' => $isiIndikator->id,
                            'ui_isi_indikator_id' => $unitIsiIndikator->id,
                            'pengisian_id' => $existingPengisian->id,
                            'order' => $index,
                            'isi_indikator' => $isiIndikator->isi_indikator,

                            'pertanyaan_existing' => $unitIsiIndikator->pertanyaan,
                            'target_existing' => $unitIsiIndikator->target,
                            'bukti_existing' => $unitIsiIndikator->bukti,
                            'pengisian_isi' => $existingPengisian->isi,
                            'pengisian_bukti' => $existingPengisian->bukti,
                            'pengisian_faktor_penghambat' => $existingPengisian->faktor_penghambat,
                            'pengisian_answered_at' => $existingPengisian->answered_at?->format('Y-m-d H:i:s'),

                            'review_auditor1_id' => $reviewAuditor1->id,
                            'review_auditor1_status_temuan' => $reviewAuditor1->status_temuan,
                            'review_auditor1_hasil_pengamatan' => $reviewAuditor1->hasil_pengamatan,
                            'review_auditor1_status' => $reviewAuditor1->status,
                            'review_auditor1_reviewed_at' => $reviewAuditor1->reviewed_at?->format('Y-m-d H:i:s'),

                            'review_auditor2_id' => $reviewAuditor2->id,
                            'review_auditor2_status_temuan' => $reviewAuditor2->status_temuan,
                            'review_auditor2_hasil_pengamatan' => $reviewAuditor2->hasil_pengamatan,
                            'review_auditor2_status' => $reviewAuditor2->status,
                            'review_auditor2_reviewed_at' => $reviewAuditor2->reviewed_at?->format('Y-m-d H:i:s'),
                        ];
                    }
                }

                if (!empty($isiIndikators)) {
                    $standarGroups[$standarIndex]['sub_standars'][] = [
                        'indikator_id' => $indikator->id,
                        'unit_indikator_indikator_id' => $unitIndikator->id,
                        'sub_standar_name' => $subStandar?->nama_sub_standar ?? 'Sub Standar',
                        'indikator_target' => $indikator->target ?? '-',
                        'isi_indikators' => $isiIndikators,
                    ];
                }
            }
        }

        return $standarGroups;
    }

    protected function prepareAnalysisData(): void
    {
        $this->statistik = $this->calculateStatistik();
        $this->chartData = $this->prepareChartData();
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

    public function setActiveTab(string $tab): void
    {
        $this->activeTab = $tab;
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Assignment')
                    ->description('Detail assignment yang akan direview')
                    ->schema([
                        Forms\Components\Hidden::make('assign_pengisian_id'),

                        Forms\Components\Grid::make(3)
                            ->schema([
                                Forms\Components\Placeholder::make('unit_info')
                                    ->label('Unit')
                                    ->content($this->assignment->unitIndikator->unit->nama_unit ?? '-'),

                                Forms\Components\Placeholder::make('periode_info')
                                    ->label('Periode')
                                    ->content($this->assignment->periode->periode_name ?? '-'),

                                Forms\Components\Placeholder::make('auditee_info')
                                    ->label('Auditee')
                                    ->content($this->assignment->unitIndikator->auditeeUser->name ?? '-'),
                            ]),
                    ])
                    ->collapsible()
                    ->collapsed(true),

                Forms\Components\Section::make('Review Data Audit - Auditor 1')
                    ->description('Review setiap item audit yang telah diisi auditee')
                    ->schema([
                        Forms\Components\Repeater::make('standar_groups')
                            ->label('Standar Audit')
                            ->schema([
                                Forms\Components\Hidden::make('standar_id'),
                                Forms\Components\Hidden::make('unit_indikator_standar_id'),

                                Forms\Components\Section::make(fn(Forms\Get $get) => ($get('standar_code') ? '[' . $get('standar_code') . '] ' : '') .
                                    ($get('standar_name') ?: 'Standar'))
                                    ->description(fn(Forms\Get $get) => $get('standar_description') ?: '')
                                    ->schema([
                                        Forms\Components\Grid::make(2)
                                            ->schema([
                                                Forms\Components\Placeholder::make('standar_info')
                                                    ->label('Nama Standar')
                                                    ->content(fn(Forms\Get $get) => $get('standar_name') ?: '-'),

                                                Forms\Components\Placeholder::make('standar_code_info')
                                                    ->label('Kode Standar')
                                                    ->content(fn(Forms\Get $get) => $get('standar_code') ?: '-'),
                                            ]),
                                        Forms\Components\Repeater::make('sub_standars')
                                            ->label('Sub Standar')
                                            ->schema([
                                                Forms\Components\Hidden::make('indikator_id'),
                                                Forms\Components\Hidden::make('unit_indikator_indikator_id'),
                                                Forms\Components\Section::make(fn(Forms\Get $get) =>
                                                'Sub Standar: ' . ($get('sub_standar_name') ?: '-'))
                                                    ->schema([
                                                        Forms\Components\Grid::make(2)
                                                            ->schema([
                                                                Forms\Components\Placeholder::make('sub_standar_info')
                                                                    ->label('Nama Sub Standar')
                                                                    ->content(fn(Forms\Get $get) => $get('sub_standar_name') ?: '-'),

                                                                Forms\Components\Placeholder::make('indikator_target_info')
                                                                    ->label('Target Indikator')
                                                                    ->content(fn(Forms\Get $get) => $get('indikator_target') ?: '-'),
                                                            ]),

                                                        Forms\Components\Repeater::make('isi_indikators')
                                                            ->label('Isi Indikator')
                                                            ->schema([
                                                                Forms\Components\Hidden::make('isi_indikator_id'),
                                                                Forms\Components\Hidden::make('ui_isi_indikator_id'),
                                                                Forms\Components\Hidden::make('pengisian_id'),
                                                                Forms\Components\Hidden::make('review_auditor1_id'),
                                                                Forms\Components\Hidden::make('review_auditor2_id'),

                                                                Forms\Components\Section::make('Item Review')
                                                                    ->schema([
                                                                        Forms\Components\Placeholder::make('isi_indikator_content')
                                                                            ->label('Isi Indikator')
                                                                            ->content(function (Forms\Get $get) {
                                                                                $content = $get('isi_indikator') ?? '-';
                                                                                if (strip_tags($content) !== $content) {
                                                                                    $content = str_replace('<ul>', '<ul style="list-style-type: disc; padding-left: 1rem;">', $content);
                                                                                    $content = str_replace('<ol>', '<ol style="list-style-type: decimal; padding-left: 1rem;">', $content);
                                                                                    $content = str_replace('<li>', '<li style="margin-bottom: 4px;">', $content);
                                                                                    return new \Illuminate\Support\HtmlString($content);
                                                                                }
                                                                                return new \Illuminate\Support\HtmlString(nl2br(e($content)));
                                                                            })
                                                                            ->columnSpanFull(),
                                                                        Forms\Components\Grid::make(3)
                                                                            ->schema([
                                                                                Forms\Components\Placeholder::make('pertanyaan_existing')
                                                                                    ->label('Pertanyaan (Existing)')
                                                                                    ->content(fn(Forms\Get $get) => $get('pertanyaan_existing') ?: '-'),

                                                                                Forms\Components\Placeholder::make('target_existing')
                                                                                    ->label('Target (Existing)')
                                                                                    ->content(fn(Forms\Get $get) => $get('target_existing') ?: '-'),

                                                                                Forms\Components\Placeholder::make('bukti_existing')
                                                                                    ->label('Bukti (Existing)')
                                                                                    ->content(function (Forms\Get $get) {
                                                                                        $bukti = trim($get('bukti_existing') ?? '');

                                                                                        if ($bukti === '') {
                                                                                            return '-';
                                                                                        }

                                                                                        $url = str_starts_with($bukti, 'http://') || str_starts_with($bukti, 'https://')
                                                                                            ? $bukti
                                                                                            : 'http://' . $bukti;

                                                                                        return new \Illuminate\Support\HtmlString(
                                                                                            '<a href="' . e($url) . '" target="_blank" rel="noopener noreferrer" class="text-primary-600 hover:text-primary-800 dark:text-primary-400 dark:hover:text-primary-300 underline">'
                                                                                                . e($bukti) . ' ↗</a>'
                                                                                        );
                                                                                    }),
                                                                            ]),


                                                                        Forms\Components\Section::make('Data Pengisian Auditee')
                                                                            ->schema([
                                                                                Forms\Components\Grid::make(3)
                                                                                    ->schema([
                                                                                        Forms\Components\Placeholder::make('pengisian_isi_display')
                                                                                            ->label('Status')
                                                                                            ->content(
                                                                                                fn(Forms\Get $get) =>
                                                                                                ucfirst(str_replace('_', ' ', $get('pengisian_isi') ?? '-'))
                                                                                            ),

                                                                                        Forms\Components\Placeholder::make('pengisian_bukti_display')
                                                                                            ->label('Bukti')
                                                                                            ->content(function (Forms\Get $get) {
                                                                                                $bukti = trim($get('pengisian_bukti') ?? '');
                                                                                                if ($bukti === '') return '-';

                                                                                                $url = str_starts_with($bukti, 'http://') || str_starts_with($bukti, 'https://')
                                                                                                    ? $bukti : 'http://' . $bukti;

                                                                                                return new \Illuminate\Support\HtmlString(
                                                                                                    '<a href="' . e($url) . '" target="_blank" rel="noopener noreferrer" class="text-primary-600 hover:text-primary-800 dark:text-primary-400 dark:hover:text-primary-300 underline">'
                                                                                                        . e($bukti) . ' ↗</a>'
                                                                                                );
                                                                                            }),

                                                                                        Forms\Components\Placeholder::make('pengisian_answered_at_display')
                                                                                            ->label('Diisi Pada')
                                                                                            ->content(
                                                                                                fn(Forms\Get $get) =>
                                                                                                $get('pengisian_answered_at') ?
                                                                                                    \Carbon\Carbon::parse($get('pengisian_answered_at'))->format('d/m/Y H:i') : '-'
                                                                                            ),
                                                                                    ]),

                                                                                Forms\Components\Placeholder::make('pengisian_faktor_penghambat_display')
                                                                                    ->label('Faktor Penghambat / Komentar')
                                                                                    ->content(fn(Forms\Get $get) => $get('pengisian_faktor_penghambat') ?: '-')
                                                                                    ->columnSpanFull(),
                                                                            ])
                                                                            ->compact(),

                                                                        Forms\Components\Section::make('Review Auditor 1')
                                                                            ->schema([
                                                                                Forms\Components\Grid::make(2)
                                                                                    ->schema([
                                                                                        Forms\Components\Placeholder::make('review_auditor1_status_temuan_display')
                                                                                            ->label('Temuan Auditor 1')
                                                                                            ->content(function (Forms\Get $get) {
                                                                                                $temuan = $get('review_auditor1_status_temuan');
                                                                                                $status = $get('review_auditor1_status');

                                                                                                if (!$temuan || $status !== 'reviewed') {
                                                                                                    return 'Belum direview';
                                                                                                }

                                                                                                $color = $temuan === 'sesuai' ? 'text-success-600' : 'text-danger-600';
                                                                                                $text = ucfirst(str_replace('_', ' ', $temuan));

                                                                                                return new \Illuminate\Support\HtmlString(
                                                                                                    "<span class='{$color} font-medium'>{$text}</span>"
                                                                                                );
                                                                                            }),

                                                                                        Forms\Components\Placeholder::make('review_auditor2_reviewed_at_display')
                                                                                            ->label('Direview Pada')
                                                                                            ->content(
                                                                                                fn(Forms\Get $get) =>
                                                                                                $get('review_auditor1_reviewed_at') ?
                                                                                                    \Carbon\Carbon::parse($get('review_auditor1_reviewed_at'))->format('d/m/Y H:i') :
                                                                                                    'Belum direview'
                                                                                            ),
                                                                                    ]),

                                                                                Forms\Components\Placeholder::make('review_auditor2_hasil_pengamatan_display')
                                                                                    ->label('Hasil Pengamatan Auditor 1')
                                                                                    ->content(function (Forms\Get $get) {
                                                                                        $pengamatan = $get('review_auditor1_hasil_pengamatan');
                                                                                        $status = $get('review_auditor1_status');

                                                                                        if (!$pengamatan || $status !== 'reviewed') {
                                                                                            return 'Belum ada pengamatan';
                                                                                        }

                                                                                        return new \Illuminate\Support\HtmlString(
                                                                                            '<div class="text-sm text-gray-700 dark:text-gray-300 bg-info-50 dark:bg-info-950 p-3 rounded-lg border border-info-200 dark:border-info-800">' .
                                                                                                nl2br(e($pengamatan)) .
                                                                                                '</div>'
                                                                                        );
                                                                                    })
                                                                                    ->columnSpanFull(),

                                                                                Forms\Components\Placeholder::make('conflict_indicator')
                                                                                    ->label('Status Konflik')
                                                                                    ->content(function (Forms\Get $get) {
                                                                                        $auditor1Temuan = $get('review_auditor1_status_temuan');
                                                                                        $auditor2Temuan = $get('review_auditor2_status_temuan');
                                                                                        $auditor1Status = $get('review_auditor1_status');
                                                                                        $auditor2Status = $get('review_auditor2_status');

                                                                                        if ($auditor2Status === 'reviewed' && $auditor1Status === 'reviewed') {
                                                                                            if ($auditor2Temuan !== $auditor1Temuan) {
                                                                                                return new \Illuminate\Support\HtmlString(
                                                                                                    '<span class="inline-flex items-center gap-1 px-2 py-1 text-xs font-medium bg-danger-100 text-danger-800 dark:bg-danger-800 dark:text-danger-100 rounded-full">' .
                                                                                                        '<svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">' .
                                                                                                        '<path fill-rule="evenodd" d="M8.257 3.099c.765-1.36 2.722-1.36 3.486 0l5.58 9.92c.75 1.334-.213 2.98-1.742 2.98H4.42c-1.53 0-2.493-1.646-1.743-2.98l5.58-9.92zM11 13a1 1 0 11-2 0 1 1 0 012 0zm-1-8a1 1 0 00-1 1v3a1 1 0 002 0V6a1 1 0 00-1-1z" clip-rule="evenodd"></path>' .
                                                                                                        '</svg>' .
                                                                                                        'KONFLIK TERDETEKSI' .
                                                                                                        '</span>'
                                                                                                );
                                                                                            } else {
                                                                                                return new \Illuminate\Support\HtmlString(
                                                                                                    '<span class="inline-flex items-center gap-1 px-2 py-1 text-xs font-medium bg-success-100 text-success-800 dark:bg-success-800 dark:text-success-100 rounded-full">' .
                                                                                                        '<svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">' .
                                                                                                        '<path fill-rule="evenodd" d="M16.707 5.293a1 1 0 010 1.414l-8 8a1 1 0 01-1.414 0l-4-4a1 1 0 011.414-1.414L8 12.586l7.293-7.293a1 1 0 011.414 0z" clip-rule="evenodd"></path>' .
                                                                                                        '</svg>' .
                                                                                                        'KONSISTEN' .
                                                                                                        '</span>'
                                                                                                );
                                                                                            }
                                                                                        }

                                                                                        return 'Menunggu kedua auditor selesai review';
                                                                                    })
                                                                                    ->columnSpanFull()
                                                                                    ->visible(
                                                                                        fn(Forms\Get $get) =>
                                                                                        $get('review_auditor1_status') === 'reviewed' ||
                                                                                            $get('review_auditor2_status') === 'reviewed'
                                                                                    ),
                                                                            ])
                                                                            ->compact()
                                                                            ->collapsible()
                                                                            ->collapsed(fn(Forms\Get $get) => $get('review_auditor2_status') !== 'reviewed'),

                                                                        Forms\Components\Section::make('Review Auditor 2')
                                                                            ->schema([
                                                                                Forms\Components\Grid::make(2)
                                                                                    ->schema([
                                                                                        Forms\Components\Select::make('review_auditor2_status_temuan')
                                                                                            ->label('Temuan')
                                                                                            ->options([
                                                                                                'sesuai' => 'Sesuai',
                                                                                                'tidak_sesuai' => 'Tidak Sesuai',
                                                                                            ])
                                                                                            ->required()
                                                                                            ->live()
                                                                                            ->afterStateUpdated(function (Forms\Get $get, Forms\Set $set, $state) {
                                                                                                if ($state === 'tidak_sesuai') {
                                                                                                    Notification::make()
                                                                                                        ->warning()
                                                                                                        ->title('Temuan Tidak Sesuai')
                                                                                                        ->body('Pastikan untuk memberikan hasil pengamatan yang detail.')
                                                                                                        ->send();
                                                                                                }
                                                                                            }),

                                                                                        Forms\Components\Placeholder::make('review_auditor2_status_display')
                                                                                            ->label('Status Review')
                                                                                            ->content(
                                                                                                fn(Forms\Get $get) =>
                                                                                                $get('review_auditor2_status') === 'reviewed' ?
                                                                                                    '✅ Sudah direview pada ' . ($get('review_auditor2_reviewed_at') ?
                                                                                                        \Carbon\Carbon::parse($get('review_auditor2_reviewed_at'))->format('d/m/Y H:i') : '') :
                                                                                                    '⏳ Belum direview'
                                                                                            ),
                                                                                    ]),

                                                                                Forms\Components\Textarea::make('review_auditor2_hasil_pengamatan')
                                                                                    ->label('Hasil Pengamatan')
                                                                                    ->placeholder('Berikan hasil pengamatan dan analisis...')
                                                                                    ->helperText('Jelaskan temuan secara detail dan berikan rekomendasi jika diperlukan.')
                                                                                    ->rows(4)
                                                                                    ->required(fn(Forms\Get $get) => $get('review_auditor2_status_temuan') === 'tidak_sesuai')
                                                                                    ->columnSpanFull(),
                                                                            ])
                                                                            ->collapsible()
                                                                            ->collapsed(false)
                                                                            ->compact(),
                                                                    ])
                                                                    ->collapsible()
                                                                    ->collapsed(false)
                                                                    ->compact(),
                                                            ])
                                                            ->addable(false)
                                                            ->deletable(false)
                                                            ->reorderable(false)
                                                            ->itemLabel(function (array $state): ?string {
                                                                $order = ($state['order'] ?? 0) + 1;
                                                                $status = $state['review_auditor2_status'] ?? 'pending';
                                                                $icon = $status === 'reviewed' ? '✅' : '⏳';
                                                                return $icon . ' Item ' . $order;
                                                            })
                                                            ->collapsed(true)
                                                            ->columnSpanFull(),
                                                    ])
                                                    ->collapsible()
                                                    ->collapsed(true)
                                                    ->headerActions([
                                                        \Filament\Forms\Components\Actions\Action::make('lihat_detail')
                                                            ->icon('heroicon-m-eye')
                                                            ->label('Lihat Detail')
                                                            ->modalHeading('Detail Indikator')
                                                            ->modalWidth('4xl')
                                                            ->modalContent(function (Forms\Get $get) {
                                                                $indikatorId = $get('indikator_id');
                                                                $indikatorData = \App\Models\Indikator::with(['subStandar.standar', 'isiIndikators'])->find($indikatorId);
                                                                $unitIndikatorIndikatorId = $get('unit_indikator_indikator_id');

                                                                $unitIndikatorIndikator = \App\Models\UnitIndikatorIndikator::find($unitIndikatorIndikatorId);
                                                                return view('livewire.components.dtail-sub-standar', [
                                                                    'indikator' => $indikatorData,
                                                                    'unitIndikatorIndikator' => $unitIndikatorIndikator,
                                                                ]);
                                                            })
                                                            ->modalSubmitAction(false)
                                                            ->modalCancelActionLabel('Tutup')
                                                            ->visible(fn(Forms\Get $get) => filled($get('indikator_id'))),
                                                    ])

                                                    ->compact(),
                                            ])
                                            ->addable(false)
                                            ->deletable(false)
                                            ->reorderable(false)

                                            ->itemLabel(function (array $state): ?string {
                                                return $state['sub_standar_name'] ?? 'Sub Standar';
                                            })
                                            ->collapsed(true)
                                            ->columnSpanFull(),
                                    ])

                                    ->collapsible()
                                    ->collapsed(false)

                                    ->headerActions([
                                        Forms\Components\Actions\Action::make('lihat_detail')
                                            ->icon('heroicon-m-eye')
                                            ->label('Lihat Detail')
                                            ->modalHeading('Detail Standar')
                                            ->modalWidth('4xl')
                                            ->modalContent(function (Forms\Get $get) {
                                                $standarId = $get('standar_id');
                                                $standar = \App\Models\Standar::with('subStandars')->find($standarId);
                                                return view('livewire.components.detail-standar', [
                                                    'standar' => $standar,
                                                ]);
                                            })
                                            ->modalSubmitAction(false)
                                            ->modalCancelActionLabel('Tutup')
                                            ->visible(fn(Forms\Get $get) => filled($get('standar_id'))),
                                    ])
                                    ->compact(),
                            ])
                            ->addable(false)
                            ->deletable(false)
                            ->reorderable(false)
                            ->itemLabel(function (array $state): ?string {
                                $code = $state['standar_code'] ? '[' . $state['standar_code'] . '] ' : '';
                                return $code . ($state['standar_name'] ?? 'Standar');
                            })
                            ->collapsed(false)
                            ->columnSpanFull()

                    ]),

                Forms\Components\Section::make('Finalisasi Review')
                    ->schema([
                        Forms\Components\DateTimePicker::make('reviewed_at')
                            ->label('Tanggal Review')
                            ->disabled()
                            ->default(now())
                            ->required()
                            ->native(false),
                    ])
                    ->collapsible(),
            ])
            ->statePath('data');
    }

    protected function getFormActions(): array
    {
        return [
            Action::make('save')
                ->label('Simpan Review')
                ->color('primary')
                ->action('save'),

            Action::make('cancel')
                ->label('Batal')
                ->color('gray')
                ->url(ReviewIndikatorResource::getUrl('index'))
                ->outlined(),
        ];
    }

    public function save(): void
    {
        $data = $this->form->getState();
        $this->form->validate();

        $this->processReviewData($data);

        Notification::make()
            ->success()
            ->title('Berhasil!')
            ->body('Review audit berhasil disimpan.')
            ->send();

        $this->redirect(ReviewIndikatorResource::getUrl('index'));
    }

    protected function processReviewData(array $data): void
    {
        if (isset($data['standar_groups']) && is_array($data['standar_groups'])) {
            foreach ($data['standar_groups'] as $standarGroup) {
                foreach ($standarGroup['sub_standars'] as $subStandar) {
                    foreach ($subStandar['isi_indikators'] as $isiIndikator) {
                        if (!empty($isiIndikator['pengisian_id'])) {
                            \App\Models\ReviewAuditor2::updateOrCreate(
                                [
                                    'pengisian_indikators_id' => $isiIndikator['pengisian_id'],
                                ],
                                [
                                    'status_temuan' => $isiIndikator['review_auditor2_status_temuan'] ?? null,
                                    'hasil_pengamatan' => $isiIndikator['review_auditor2_hasil_pengamatan'] ?? null,
                                    'status' => 'reviewed',
                                    'reviewed_at' => $data['reviewed_at'] ?? now(),
                                ]
                            );
                        }
                    }
                }
            }
        }
    }

    public function getTitle(): string
    {
        return 'Review Auditor 2 - ' . ($this->assignment->unitIndikator->unit->nama_unit ?? 'Unknown');
    }

    public function getBreadcrumbs(): array
    {
        return [
            ReviewIndikatorResource::getUrl('index') => 'Review Audit',
            '#' => 'Review Auditor 2',
        ];
    }
}
