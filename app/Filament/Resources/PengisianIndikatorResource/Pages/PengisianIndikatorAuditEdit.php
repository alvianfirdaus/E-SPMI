<?php

namespace App\Filament\Resources\PengisianIndikatorResource\Pages;

use Filament\Forms;
use Filament\Forms\Form;
use Filament\Actions\Action;
use App\Models\AssignPengisian;
use App\Models\PengisianIndikator;
use Filament\Resources\Pages\Page;
use Illuminate\Support\Facades\Auth;
use Filament\Forms\Contracts\HasForms;
use Filament\Notifications\Notification;
use Filament\Actions\Contracts\HasActions;
use Filament\Forms\Concerns\InteractsWithForms;
use Filament\Actions\Concerns\InteractsWithActions;
use App\Filament\Resources\PengisianIndikatorResource;

class PengisianIndikatorAuditEdit extends Page implements HasForms, HasActions
{
    use InteractsWithForms, InteractsWithActions;

    protected static string $resource = PengisianIndikatorResource::class;

    protected static string $view = 'filament.resources.pengisian-indikator-resource.pages.pengisian-indikator-audit';

    protected static ?string $navigationIcon = 'heroicon-o-pencil-square';
    protected static bool $shouldRegisterNavigation = false;

    public ?array $data = [];
    public ?AssignPengisian $assignment = null;
    public ?string $assignmentId = null;

    public function mount(): void
    {
        // Get assignment parameter from route
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
                'pengisianIndikators'
            ])->findOrFail($this->assignmentId);

            $this->validateUserAccess();

            $formData = [
                'assign_pengisian_id' => $this->assignment->id,
                'answered_at' => $this->assignment->pengisianIndikators->first()?->answered_at ?? now(),
                'standar_groups' => $this->prepareAuditItems(),
            ];

            $this->form->fill($formData);
        } else {
            abort(404, 'Assignment not found');
        }
    }

    protected function validateUserAccess(): void
    {
        $user = Auth::user();
        $isAdmin = $user?->hasRole('super_admin');

        if (!$isAdmin) {
            abort(403, 'Anda tidak memiliki akses untuk mengedit audit ini.');
        }

        // Allow editing even if status is 'selesai' for edit mode
        if ($this->assignment->status_pengisian == 'selesai' && !$isAdmin) {
            // Only auditors can edit completed audits
            abort(403, 'Audit ini sudah selesai. Hanya Admin yang dapat mengedit.');
        }

        if (!$this->assignment->is_active) {
            abort(403, 'Assignment ini tidak aktif.');
        }
    }

    protected function prepareAuditItems(): array
    {
        $standarGroups = [];

        foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
            $standar = $unitStandar->standar;

            // Check if this standar already exists in our groups
            $standarIndex = null;
            foreach ($standarGroups as $index => $group) {
                if ($group['standar_id'] === $standar->id) {
                    $standarIndex = $index;
                    break;
                }
            }

            // If standar doesn't exist, create it
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

            // Add sub standars (indikators) to this standar
            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                $indikator = $unitIndikator->indikator;
                $subStandar = $indikator->subStandar;

                // Prepare isi indikators for this sub standar
                $isiIndikators = [];
                foreach ($unitIndikator->unitIndikatorIsiIndikators as $index => $unitIsiIndikator) {
                    $isiIndikator = $unitIsiIndikator->isiIndikator;

                    // Get existing pengisian data
                    $existingPengisian = $this->assignment->pengisianIndikators
                        ->where('ui_isi_indikator_id', $unitIsiIndikator->id)
                        ->first();

                    $isiIndikators[] = [
                        'isi_indikator_id' => $isiIndikator->id,
                        'ui_isi_indikator_id' => $unitIsiIndikator->id,
                        'order' => $index,
                        'isi_indikator' => $isiIndikator->isi_indikator,
                        'target' => $isiIndikator->target,

                        // Existing data from unit_indikator_isi_indikators
                        'pertanyaan_existing' => $unitIsiIndikator->pertanyaan,
                        'target_existing' => $unitIsiIndikator->target,
                        'bukti_existing' => $unitIsiIndikator->bukti,

                        // Form fields for audit (from existing pengisian)
                        'status_skor' => $existingPengisian?->isi ?? null,
                        'bukti_dokumen' => $existingPengisian?->bukti ?? '',
                        'faktor_penghambat' => $existingPengisian?->faktor_penghambat ?? '',
                    ];
                }

                $standarGroups[$standarIndex]['sub_standars'][] = [
                    'indikator_id' => $indikator->id,
                    'unit_indikator_indikator_id' => $unitIndikator->id,
                    'sub_standar_name' => $subStandar?->nama_sub_standar ?? 'Sub Standar',
                    'isi_indikators' => $isiIndikators,
                ];
            }
        }

        return $standarGroups;
    }

    public function form(Form $form): Form
    {
        return $form
            ->schema([
                // Assignment Information Section
                Forms\Components\Section::make('Informasi Assignment')
                    ->description('Detail assignment yang sedang diedit')
                    ->schema([
                        Forms\Components\Hidden::make('assign_pengisian_id'),

                        Forms\Components\Grid::make(4)
                            ->schema([
                                Forms\Components\Placeholder::make('unit_info')
                                    ->label('Unit')
                                    ->content($this->assignment->unitIndikator->unit->nama_unit ?? '-'),

                                Forms\Components\Placeholder::make('periode_info')
                                    ->label('Periode')
                                    ->content($this->assignment->periode->periode_name ?? '-'),

                                Forms\Components\Placeholder::make('status_info')
                                    ->label('Status')
                                    ->content(function () {
                                        $status = $this->assignment->status_pengisian;
                                        $badges = [
                                            'pending' => '<span class="fi-badge fi-color-warning bg-warning-50 text-warning-600 ring-warning-600/10 dark:bg-warning-400/10 dark:text-warning-400 dark:ring-warning-400/30 inline-flex items-center justify-center gap-x-1 rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset">Pending</span>',
                                            'dalam_proses' => '<span class="fi-badge fi-color-info bg-info-50 text-info-600 ring-info-600/10 dark:bg-info-400/10 dark:text-info-400 dark:ring-info-400/30 inline-flex items-center justify-center gap-x-1 rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset">Dalam Proses</span>',
                                            'menunggu_review' => '<span class="fi-badge fi-color-warning bg-warning-50 text-warning-600 ring-warning-600/10 dark:bg-warning-400/10 dark:text-warning-400 dark:ring-warning-400/30 inline-flex items-center justify-center gap-x-1 rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset">Menunggu Review</span>',
                                            'selesai' => '<span class="fi-badge fi-color-success bg-success-50 text-success-600 ring-success-600/10 dark:bg-success-400/10 dark:text-success-400 dark:ring-success-400/30 inline-flex items-center justify-center gap-x-1 rounded-md px-2 py-1 text-xs font-medium ring-1 ring-inset">Selesai</span>',
                                        ];
                                        return new \Illuminate\Support\HtmlString($badges[$status] ?? $status);
                                    }),

                                Forms\Components\Placeholder::make('deadline_info')
                                    ->label('Deadline')
                                    ->content(function () {
                                        $deadline = $this->assignment->end_date;
                                        $isOverdue = now()->gt($this->assignment->end_date);
                                        $status = $isOverdue ? ' (OVERDUE)' : '';
                                        $color = $isOverdue ? 'text-danger-600 dark:text-danger-400 font-semibold' : 'text-success-600 dark:text-success-400';
                                        return new \Illuminate\Support\HtmlString(
                                            "<span class='{$color}'>{$deadline}{$status}</span>"
                                        );
                                    }),
                            ]),

                        // Progress Information
                        Forms\Components\Placeholder::make('progress_info')
                            ->label('Progress Pengisian')
                            ->content(function () {
                                $totalItems = 0;
                                foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
                                    foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                                        $totalItems += $unitIndikator->unitIndikatorIsiIndikators->count();
                                    }
                                }
                                $filledItems = $this->assignment->pengisianIndikators->count();
                                $percentage = $totalItems > 0 ? round(($filledItems / $totalItems) * 100, 1) : 0;

                                $progressColor = $percentage == 100 ? 'bg-success-600' : ($percentage >= 50 ? 'bg-primary-600' : 'bg-warning-500');

                                return new \Illuminate\Support\HtmlString("
                                    <div class='space-y-2'>
                                        <div class='flex justify-between text-sm'>
                                            <span>{$filledItems}/{$totalItems} item terisi</span>
                                            <span>{$percentage}%</span>
                                        </div>
                                        <div class='w-full bg-gray-200 dark:bg-gray-700 rounded-full h-2'>
                                            <div class='{$progressColor} h-2 rounded-full transition-all duration-300' style='width: {$percentage}%'></div>
                                        </div>
                                    </div>
                                ");
                            })
                            ->columnSpanFull(),
                    ])
                    ->collapsible()
                    ->collapsed(false),

                // Data Audit Section with grouped structure
                Forms\Components\Section::make('Data Audit')
                    ->description('Edit form untuk setiap item audit')
                    ->schema([
                        Forms\Components\Repeater::make('standar_groups')
                            ->label('Standar Audit')
                            ->schema([
                                // Hidden fields for standar
                                Forms\Components\Hidden::make('standar_id'),
                                Forms\Components\Hidden::make('unit_indikator_standar_id'),

                                // Standar Header Section
                                Forms\Components\Section::make(fn(Forms\Get $get) => ($get('standar_code') ? '[' . $get('standar_code') . '] ' : '') .
                                    ($get('standar_name') ?: 'Standar'))
                                    ->description(fn(Forms\Get $get) => $get('standar_description') ?: '')
                                    ->schema([
                                        // Display standar info
                                        Forms\Components\Grid::make(2)
                                            ->schema([
                                                Forms\Components\Placeholder::make('standar_info')
                                                    ->label('Nama Standar')
                                                    ->content(fn(Forms\Get $get) => $get('standar_name') ?: '-'),

                                                Forms\Components\Placeholder::make('standar_code_info')
                                                    ->label('Kode Standar')
                                                    ->content(fn(Forms\Get $get) => $get('standar_code') ?: '-'),
                                            ]),

                                        // Sub Standar (Indikator) Repeater
                                        Forms\Components\Repeater::make('sub_standars')
                                            ->label('Sub Standar')
                                            ->schema([
                                                // Hidden fields for sub standar
                                                Forms\Components\Hidden::make('indikator_id'),
                                                Forms\Components\Hidden::make('unit_indikator_indikator_id'),

                                                // Sub Standar Header
                                                Forms\Components\Section::make(fn(Forms\Get $get) =>
                                                'Sub Standar: ' . ($get('sub_standar_name') ?: '-'))
                                                    ->schema([
                                                        // Isi Indikator Repeater
                                                        Forms\Components\Repeater::make('isi_indikators')
                                                            ->label('Isi Indikator')
                                                            ->schema([
                                                                // Hidden field for isi indikator
                                                                Forms\Components\Hidden::make('isi_indikator_id'),
                                                                Forms\Components\Hidden::make('ui_isi_indikator_id'),

                                                                // Isi Indikator Content
                                                                Forms\Components\Section::make('Isi Indikator')
                                                                    ->description('Detail isi indikator dan form pengisian')
                                                                    ->schema([
                                                                        // Display isi indikator content
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
                                                                        Forms\Components\Placeholder::make('target')
                                                                            ->label('Target Indikator')
                                                                            ->content(fn(Forms\Get $get) => $get('target') ?: '-'),
                                                                        // Display existing data
                                                                        Forms\Components\Grid::make(3)
                                                                            ->schema([
                                                                                Forms\Components\Placeholder::make('pertanyaan_existing')
                                                                                    ->label('Pertanyaan')
                                                                                    ->content(fn(Forms\Get $get) => $get('pertanyaan_existing') ?: '-'),

                                                                                Forms\Components\Placeholder::make('target_existing')
                                                                                    ->label('Target')
                                                                                    ->content(fn(Forms\Get $get) => $get('target_existing') ?: '-'),

                                                                                Forms\Components\Placeholder::make('bukti_existing')
                                                                                    ->label('Bukti Referensi')
                                                                                    ->content(function (Forms\Get $get) {
                                                                                        $bukti = trim($get('bukti_existing') ?? '');

                                                                                        if ($bukti === '' || $bukti === '-') {
                                                                                            return '-';
                                                                                        }
                                                                                        return new \Illuminate\Support\HtmlString(
                                                                                            '<a href="' . e($bukti) . '" target="_blank" rel="noopener noreferrer" class="text-primary-600 hover:text-primary-800 dark:text-primary-400 dark:hover:text-primary-300 underline">'
                                                                                                . e($bukti) . ' ↗</a>'
                                                                                        );
                                                                                    }),
                                                                            ]),

                                                                        // Form Pengisian Section
                                                                        Forms\Components\Section::make('Form Pengisian')
                                                                            ->schema([
                                                                                Forms\Components\Grid::make(3)
                                                                                    ->schema([
                                                                                        Forms\Components\Select::make('status_skor')
                                                                                            ->label('Status Pencapaian')
                                                                                            ->options([
                                                                                                'tercapai' => 'Tercapai',
                                                                                                'tidak_tercapai' => 'Tidak Tercapai',
                                                                                            ])
                                                                                            ->required()
                                                                                            ->live()
                                                                                            ->afterStateUpdated(function (Forms\Get $get, Forms\Set $set, $state) {
                                                                                                if ($state === 'tidak_tercapai') {
                                                                                                    Notification::make()
                                                                                                        ->warning()
                                                                                                        ->title('Status Tidak Tercapai')
                                                                                                        ->body('Status "Tidak Tercapai" memerlukan penjelasan faktor penghambat.')
                                                                                                        ->send();
                                                                                                }
                                                                                            }),

                                                                                        Forms\Components\TextInput::make('bukti_dokumen')
                                                                                            ->label('Bukti Dokumen')
                                                                                            ->helperText('Link atau nomor dokumen yang mendukung')
                                                                                            ->placeholder('https://... atau No. Dok: 123/ABC/2024')
                                                                                            ->suffixIcon('heroicon-o-document-text'),

                                                                                        Forms\Components\Textarea::make('faktor_penghambat')
                                                                                            ->label('Faktor Penghambat')
                                                                                            ->placeholder('Jelaskan faktor penghambat jika tidak tercapai...')
                                                                                            ->rows(4)
                                                                                            ->required(fn(Forms\Get $get) => $get('status_skor') === 'tidak_tercapai')
                                                                                            ->helperText(
                                                                                                fn(Forms\Get $get) =>
                                                                                                $get('status_skor') === 'tidak_tercapai'
                                                                                                    ? 'Faktor penghambat wajib diisi untuk status "Tidak Tercapai"'
                                                                                                    : 'Opsional: jelaskan kendala yang ditemui'
                                                                                            ),
                                                                                    ]),
                                                                            ])
                                                                            ->collapsible()
                                                                            ->collapsed(false)

                                                                            ->compact(),
                                                                    ])
                                                                    ->collapsible()
                                                                    ->collapsed(true)

                                                                    ->compact(),
                                                            ])
                                                            ->addable(false)
                                                            ->deletable(false)
                                                            ->reorderable(false)
                                                            ->itemLabel(function (array $state): ?string {
                                                                $order = ($state['order'] ?? 0) + 1;
                                                                $status = '';
                                                                if (!empty($state['status_skor'])) {
                                                                    $statusIcon = $state['status_skor'] === 'tercapai' ? '✅' : '❌';
                                                                    $status = " {$statusIcon}";
                                                                }
                                                                return "Isi Indikator - {$order}{$status}";
                                                            })
                                                            ->collapsed(true)
                                                            ->columnSpanFull(),
                                                    ])
                                                    ->collapsible()
                                                    ->collapsed(true)
                                                    ->headerActions([

                                                        Forms\Components\Actions\Action::make('lihat_detail')
                                                            ->icon('heroicon-m-eye')
                                                            ->label('Lihat Detail')
                                                            ->modalHeading('Detail Indikator')
                                                            ->modalWidth('4xl')
                                                            ->modalContent(function (Forms\Get $get) {
                                                                $indikatorId = $get('indikator_id');
                                                                $indikator = \App\Models\Indikator::with(['subStandar.standar', 'isiIndikators'])->find($indikatorId);
                                                                $unitIndikatorIndikatorId = $get('unit_indikator_indikator_id');

                                                                $unitIndikatorIndikator = \App\Models\UnitIndikatorIndikator::find($unitIndikatorIndikatorId);

                                                                return view('livewire.components.dtail-sub-standar', [
                                                                    'indikator' => $indikator,
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
                            ->columnSpanFull(),
                    ]),

                // Global Actions Section
                Forms\Components\Section::make('Finalisasi Edit')
                    ->schema([
                        Forms\Components\DateTimePicker::make('answered_at')
                            ->label('Tanggal Terakhir Diubah')
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
            Action::make('update')
                ->label('Update Audit')
                ->color('primary')
                ->action('update'),

            Action::make('saveAsDraft')
                ->label('Simpan sebagai Draft')
                ->color('gray')
                ->action('saveAsDraft'),

            Action::make('cancel')
                ->label('Batal')
                ->color('gray')
                ->url(PengisianIndikatorResource::getUrl('index'))
                ->outlined(),
        ];
    }

    public function update(): void
    {
        $data = $this->form->getState();
        $this->form->validate();

        $this->processAuditData($data);

        Notification::make()
            ->success()
            ->title('Berhasil!')
            ->body('Data audit berhasil diperbarui.')
            ->send();

        $this->redirect(PengisianIndikatorResource::getUrl('index'));
    }
    public function save(): void
    {
        $this->update();
    }

    public function saveAsDraft(): void
    {
        $data = $this->form->getState();

        $this->processAuditData($data);

        Notification::make()
            ->success()
            ->title('Draft Disimpan!')
            ->body('Data audit berhasil disimpan sebagai draft.')
            ->send();
    }

    protected function processAuditData(array $data): void
    {
        // Process standar_groups data
        if (isset($data['standar_groups']) && is_array($data['standar_groups'])) {
            foreach ($data['standar_groups'] as $standarGroup) {
                foreach ($standarGroup['sub_standars'] as $subStandar) {
                    foreach ($subStandar['isi_indikators'] as $isiIndikator) {
                        if (!empty($isiIndikator['ui_isi_indikator_id'])) {
                            // Save if there's meaningful data
                            if (
                                !empty($isiIndikator['status_skor']) ||
                                !empty($isiIndikator['bukti_dokumen']) ||
                                !empty($isiIndikator['faktor_penghambat'])
                            ) {

                                PengisianIndikator::updateOrCreate(
                                    [
                                        'assign_pengisian_id' => $this->assignment->id,
                                        'ui_isi_indikator_id' => $isiIndikator['ui_isi_indikator_id'],
                                    ],
                                    [
                                        'isi' => $isiIndikator['status_skor'] ?? null,
                                        'bukti' => $isiIndikator['bukti_dokumen'] ?? null,
                                        'faktor_penghambat' => $isiIndikator['faktor_penghambat'] ?? null,
                                        'answered_at' => $data['answered_at'] ?? now(),
                                    ]
                                );
                            }
                        }
                    }
                }
            }
        }

        $this->updateAssignmentStatus();
    }

    protected function updateAssignmentStatus(): void
    {
        $totalIsiIndikators = 0;
        foreach ($this->assignment->unitIndikator->unitIndikatorStandars as $unitStandar) {
            foreach ($unitStandar->unitIndikatorIndikators as $unitIndikator) {
                $totalIsiIndikators += $unitIndikator->unitIndikatorIsiIndikators->count();
            }
        }

        $filledPengisians = $this->assignment->pengisianIndikators()->count();

        if ($filledPengisians >= $totalIsiIndikators) {
            $this->assignment->update(['status_pengisian' => 'selesai']);
        } else {
            $this->assignment->update(['status_pengisian' => 'dalam_proses']);
        }
    }

    public function getTitle(): string
    {
        return 'Edit Audit - ' . ($this->assignment->unitIndikator->unit->nama_unit ?? 'Unknown');
    }

    public function getBreadcrumbs(): array
    {
        return [
            PengisianIndikatorResource::getUrl('index') => 'Pengisian Indikator',
            '#' => 'Edit Audit',
        ];
    }
}
