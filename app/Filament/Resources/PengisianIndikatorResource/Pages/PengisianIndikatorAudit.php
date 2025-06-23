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

class PengisianIndikatorAudit extends Page implements HasForms, HasActions
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
                'answered_at' => now(),
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
        $isAuditor = $this->assignment->assignAuditors &&
            ($this->assignment->assignAuditors->auditor1 == $user->id ||
                $this->assignment->assignAuditors->auditor2 == $user->id);
        $isAuditee = $this->assignment->unitIndikator->auditeeUser &&
            $this->assignment->unitIndikator->auditeeUser->id == $user->id;

        if (!($isAuditor || $isAuditee)) {
            abort(403, 'Anda tidak memiliki akses untuk mengisi audit ini.');
        }

        if ($this->assignment->status_pengisian == 'selesai') {
            abort(403, 'Audit ini sudah selesai dan tidak dapat diubah.');
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

                        'pertanyaan_existing' => $unitIsiIndikator->pertanyaan,
                        'target_existing' => $unitIsiIndikator->target,
                        'bukti_existing' => $unitIsiIndikator->bukti,

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
                    ->description('Detail assignment yang akan diisi')
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

                                Forms\Components\Placeholder::make('deadline_info')
                                    ->label('Deadline')
                                    ->content(function () {
                                        $deadline = $this->assignment->end_date;
                                        $isOverdue = now()->gt($this->assignment->end_date);
                                        $status = $isOverdue ? ' (OVERDUE)' : '';
                                        $color = $isOverdue ? 'text-red-600 font-semibold' : 'text-green-600';
                                        return new \Illuminate\Support\HtmlString(
                                            "<span class='{$color}'>{$deadline}{$status}</span>"
                                        );
                                    }),
                            ]),
                    ])
                    ->collapsible()
                    ->collapsed(true),

                // Data Audit Section
                Forms\Components\Section::make('Data Audit')
                    ->description('Isi form untuk setiap item audit')
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


                                                            ]),

                                                        Forms\Components\Repeater::make('isi_indikators')
                                                            ->label('Isi Indikator')
                                                            ->schema([
                                                                Forms\Components\Hidden::make('isi_indikator_id'),
                                                                Forms\Components\Hidden::make('ui_isi_indikator_id'),

                                                                Forms\Components\Section::make('Isi Indikator')
                                                                    ->description('Detail isi indikator dan form pengisian')
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

                                                                        // Display existing data
                                                                        Forms\Components\Placeholder::make('target')
                                                                            ->label('Target Indikator')
                                                                            ->content(fn(Forms\Get $get) => $get('target') ?: '-'),
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

                                                                        // Form Pengisian Section
                                                                        Forms\Components\Section::make('Form Pengisian')
                                                                            ->schema([
                                                                                Forms\Components\Grid::make(3)
                                                                                    ->schema([
                                                                                        Forms\Components\Select::make('status_skor')
                                                                                            ->label('Status Skor')
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
                                                                                                        ->body('Status "Tidak Tercapai" memerlukan komentar yang jelas.')
                                                                                                        ->send();
                                                                                                }
                                                                                            }),

                                                                                        Forms\Components\TextInput::make('bukti_dokumen')
                                                                                            ->label('Bukti Dokumen')
                                                                                            ->helperText('(dapat di-isikan dengan link / bukti nomor dokumen / penjelasan yang mendukung)')
                                                                                            ->placeholder('https://...')
                                                                                            ->suffixIcon('heroicon-o-link')
                                                                                            ->columnSpan(2),
                                                                                    ]),

                                                                                Forms\Components\Textarea::make('faktor_penghambat')
                                                                                    ->label('Faktor Penghambat / Komentar')
                                                                                    ->placeholder('Komentar atau catatan...')
                                                                                    ->helperText('(wajib di-isi jika standar tidak tercapai)')
                                                                                    ->rows(3)
                                                                                    ->required(fn(Forms\Get $get) => $get('status_skor') === 'tidak_tercapai')
                                                                                    ->columnSpanFull(),
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
                                                                // Use the order from state if available, otherwise just use generic label
                                                                $order = ($state['order'] ?? 0) + 1;
                                                                return 'Isi Indikator - ' . $order;
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
                Forms\Components\Section::make('Finalisasi Audit')
                    ->schema([
                        Forms\Components\DateTimePicker::make('answered_at')
                            ->label('Tanggal Pengisian')
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
                ->label('Simpan Audit')
                ->color('primary')
                ->action('save'),

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

    public function save(): void
    {
        $data = $this->form->getState();
        $this->form->validate();

        // Process the repeater data
        $this->processAuditData($data);

        Notification::make()
            ->success()
            ->title('Berhasil!')
            ->body('Data audit berhasil disimpan.')
            ->send();

        $this->redirect(PengisianIndikatorResource::getUrl('index'));
    }

    public function saveAsDraft(): void
    {
        $data = $this->form->getState();

        // Process the repeater data as draft
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
                            // Only save if there's meaningful data
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

        // Update assignment status
        $this->updateAssignmentStatus();
    }

    protected function updateAssignmentStatus(): void
    {
        // Count total isi indikators vs filled pengisians
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
            $this->assignment->update(['status_pengisian' => 'selesai']);
        }
    }

    public function getTitle(): string
    {
        return 'Isi Audit - ' . ($this->assignment->unitIndikator->unit->nama_unit ?? 'Unknown');
    }

    public function getBreadcrumbs(): array
    {
        return [
            PengisianIndikatorResource::getUrl('index') => 'Pengisian Indikator',
            '#' => 'Isi Audit',
        ];
    }
}
