<?php

namespace App\Filament\Resources\UnitIndikatorResource\Pages;

use Filament\Forms\Form;
use Illuminate\Support\Str;
use App\Models\UnitIndikator;
use Filament\Resources\Pages\Page;
use Illuminate\Support\HtmlString;
use Filament\Forms\Components\Card;
use Filament\Forms\Components\Grid;
use Filament\Forms\Components\Tabs;
use Illuminate\Support\Facades\Auth;
use Filament\Forms\Components\Section;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Components\Checkbox;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Notifications\Notification;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Concerns\InteractsWithForms;
use App\Filament\Resources\UnitIndikatorResource;
use App\Models\UnitIndikatorIsiIndikator;

class ValidasiPengisianBobot extends Page implements HasForms
{
    use InteractsWithForms;

    public static string $resource = UnitIndikatorResource::class;

    protected static ?string $navigationIcon = 'heroicon-o-check-circle';
    protected static string $view = 'filament.resources.unit-indikator-resource.pages.validasi-unit-indikator';
    protected static bool $shouldRegisterNavigation = false;

    public $record;

    public array $standarData = [];
    public array $indikatorData = [];


    public array $bobotIsiIndikator = [];


    public function mount(int | string $record): void
    {
        $unitIndikator = UnitIndikator::with([
            'unitIndikatorStandars.standar',
            'unitIndikatorStandars.unitIndikatorIndikators.indikator.subStandar',
            'unitIndikatorStandars.unitIndikatorIndikators.indikator.isiIndikators',
            'unitIndikatorStandars.unitIndikatorIndikators.unitIndikatorIsiIndikators',
            'unit',
            'periode'
        ])->find($record);

        if (!$unitIndikator) {
            Notification::make()
                ->title('Unit Indikator tidak ditemukan')
                ->danger()
                ->send();

            $this->redirect(UnitIndikatorResource::getUrl('index'));
            return;
        }

        $user = Auth::user();
        $isValidator2 = $unitIndikator->validator_2_id === $user->id;
        $isSuperAdmin = $user->hasRole('super_admin');

        $isValidated = $unitIndikator->status_validasi_1 === 'validated';

        if (!($isValidator2 || $isSuperAdmin) || !$isValidated) {
            Notification::make()
                ->title('Akses Ditolak')
                ->body('Hanya validator 2 atau super admin yang dapat mengakses halaman ini ketika status validasi 1 telah tervalidasi.')
                ->danger()
                ->persistent()
                ->send();

            $this->redirect(UnitIndikatorResource::getUrl('index'));
            return;
        }

        $this->record = $unitIndikator;

        // Initialize the data arrays
        $this->standarData = [];
        $this->indikatorData = [];
        $this->bobotIsiIndikator = [];

        // Populate standar data
        foreach ($unitIndikator->unitIndikatorStandars as $standar) {
            $this->standarData[$standar->id] = [
                'is_rejected' => (bool)$standar->is_rejected,
                'komentar' => $standar->komentar ?? '',
            ];

            // Populate indikator data
            foreach ($standar->unitIndikatorIndikators as $indikator) {
                $this->indikatorData[$indikator->id] = [
                    'is_rejected' => (bool)$indikator->is_rejected,
                    'komentar' => $indikator->komentar ?? '',
                ];

                // Populate isi indikator data
                foreach ($indikator->unitIndikatorIsiIndikators as $isiIndikator) {
                    $this->bobotIsiIndikator[$isiIndikator->isi_indikator_id] = [
                        'is_rejected' => (bool)$isiIndikator->is_rejected,
                        'komentar' => $isiIndikator->komentar ?? '',
                    ];
                }
            }
        }
    }
    public function form(Form $form): Form
{
    $tabs = [];

    foreach ($this->record->unitIndikatorStandars as $standarItem) {
        if (!\App\Models\UnitIndikatorStandar::find($standarItem->id)) {
            continue;
        }

        $unitIndikatorStandarId = $standarItem->id;
        $standarName = $standarItem->standar ? $standarItem->standar->nama_standar : 'Standar';
        $totalIsiIndikators = 0;
        foreach ($standarItem->unitIndikatorIndikators as $indikatorItem) {
            $totalIsiIndikators += $indikatorItem->indikator->isiIndikators->count();
        }
        $schema = [];

        $schema[] = Section::make($standarName)
            ->schema([
                Placeholder::make("placeholder_total_isi_{$unitIndikatorStandarId}")
                    ->label('Total Isi Indikators')
                    ->content($totalIsiIndikators)
                    ->columnSpan(2),
            ])
            ->headerActions([
                \Filament\Forms\Components\Actions\Action::make('lihat_detail')
                    ->icon('heroicon-m-eye')
                    ->label('Lihat Detail')
                    ->modalHeading('Detail Standar')
                    ->modalWidth('4xl')
                    ->modalContent(function () use ($standarItem) {
                        $standarId = $standarItem->standar_id;
                        $standar = \App\Models\Standar::with('subStandars')->find($standarId);
                        return view('livewire.components.detail-standar', [
                            'standar' => $standar,
                        ]);
                    })
                    ->modalSubmitAction(false)
                    ->modalCancelActionLabel('Tutup'),
            ])
            ->collapsible(false);

        $relatedIndikators = $standarItem->unitIndikatorIndikators()->get();

        foreach ($relatedIndikators as $indikatorItem) {
            if (!$indikatorItem->relationLoaded('indikator')) {
                $indikatorItem->load('indikator.subStandar', 'indikator.isiIndikators');
            }

            $indikator = $indikatorItem->indikator;

            if (!$indikator || !$indikator->subStandar) {
                continue;
            }

            if ($indikator->subStandar->standar_id !== $standarItem->standar_id) {
                continue;
            }

            $indikatorId = $indikatorItem->id;
            $indikatorTitle = $indikator->subStandar->nama_sub_standar ?? 'Indikator';
            $isiIndikators = $indikator->isiIndikators;
            
            // Reset the indikator schema for each indikator
            $indikatorSchema = [];

            if ($isiIndikators && $isiIndikators->count() > 0) {
                $indikatorSchema[] = Section::make('Isi Indikator')
                    ->schema(function () use ($isiIndikators, $indikatorItem) {
                        $components = [];

                        foreach ($isiIndikators as $index => $isiIndikator) {
                            // Find the specific UnitIndikatorIsiIndikator for this combination
                            $unitIndikatorIsiIndikator = $indikatorItem->unitIndikatorIsiIndikators
                                ->where('isi_indikator_id', $isiIndikator->id)
                                ->first();

                            $components[] = Card::make()
                                ->schema([
                                    Grid::make(2)
                                        ->schema([
                                            Placeholder::make('isi_indikator_title_' . $isiIndikator->id)
                                                ->label(false)
                                                ->content(function () use ($isiIndikator, $index) {
                                                    $content = $isiIndikator->isi_indikator ?? 'Tidak ada deskripsi';
                                                    $content = str_replace('<ul>', '<ul style="list-style-type: disc; padding-left: 1rem;">', $content);
                                                    $content = str_replace('<ol>', '<ol style="list-style-type: decimal; padding-left: 1rem;">', $content);
                                                    $content = str_replace('<li>', '<li style="margin-bottom: 4px;">', $content);

                                                    $plain = strip_tags($content);
                                                    $limited = Str::limit($plain, 250);

                                                    return new HtmlString('<strong>' . ($index + 1) . '.</strong> ' . nl2br(e($plain)));
                                                }),
                                            Placeholder::make("bobot_" . $isiIndikator->id)
                                                ->label('Bobot')
                                                ->content(function () use ($unitIndikatorIsiIndikator) {
                                                    return ($unitIndikatorIsiIndikator ? $unitIndikatorIsiIndikator->bobot : 0) . '%';
                                                })
                                        ]),
                                    Grid::make(2)
                                        ->schema([
                                            Checkbox::make("bobotIsiIndikator.{$isiIndikator->id}.is_rejected")
                                                ->label('Tandai sebagai tidak valid')
                                                ->helperText('Centang jika isi indikator ini tidak valid'),

                                            Textarea::make("bobotIsiIndikator.{$isiIndikator->id}.komentar")
                                                ->label('Komentar Isi Indikator')
                                                ->placeholder('Tambahkan komentar validasi di sini...')
                                                ->rows(3),
                                        ])
                                ]);
                        }

                        return $components;
                    })
                    ->collapsible(true)
                    ->collapsed(false);
            }

            $schema[] = Section::make($indikatorTitle)
                ->schema($indikatorSchema)
                ->collapsible()
                ->headerActions([
                    \Filament\Forms\Components\Actions\Action::make('lihat_detail')
                        ->icon('heroicon-m-eye')
                        ->label('Lihat Detail')
                        ->modalHeading('Detail Indikator')
                        ->modalWidth('4xl')
                        ->modalContent(function () use ($indikator, $indikatorItem) {
                            $indikatorId = $indikator->id;
                            $indikatorData = \App\Models\Indikator::with(['subStandar.standar', 'isiIndikators'])->find($indikatorId);
                            return view('livewire.components.dtail-sub-standar', [
                                'indikator' => $indikatorData,
                                'unitIndikatorIndikator' => $indikatorItem, // Pass the current unit indikator indikator context
                            ]);
                        })
                        ->modalSubmitAction(false)
                        ->modalCancelActionLabel('Tutup'),
                ]);
        }
        $tabs[] = Tabs\Tab::make($standarName)
            ->schema($schema);
    }

    return $form
        ->schema([
            Tabs::make('Validasi')
                ->tabs($tabs)
                ->activeTab(isset($tabs[0]) ? 0 : null)
        ]);
}

    public function toggleIsiIndikatorRejection($indikatorId, $isRejected): void
    {
        // Find the indikator
        $indikator = null;
        foreach ($this->record->unitIndikatorStandars as $standar) {
            $foundIndikator = $standar->unitIndikatorIndikators->firstWhere('id', $indikatorId);
            if ($foundIndikator) {
                $indikator = $foundIndikator;
                break;
            }
        }

        if (!$indikator) {
            return;
        }

        // Get all isiIndikators belonging to this indikator
        $relatedIsiIndikators = $indikator->unitIndikatorIsiIndikators()->get();

        // Update them all with the same rejection status
        foreach ($relatedIsiIndikators as $isiIndikatorItem) {
            $isiIndikatorId = $isiIndikatorItem->isi_indikator_id;

            // Update data
            $this->bobotIsiIndikator[$isiIndikatorId]['is_rejected'] = $isRejected;
        }
    }

    public function submit(): void
    {
        $hasRejectedItems = false;

        foreach ($this->record->unitIndikatorStandars as $standarItem) {
            $unitIndikatorStandarId = $standarItem->id;

            if (isset($this->standarData[$unitIndikatorStandarId])) {
                $standarData = $this->standarData[$unitIndikatorStandarId];
                $isRejected = $standarData['is_rejected'] ? 1 : 0;
                $standarItem->update([
                    'is_rejected' => $isRejected,
                    'komentar' => !empty($standarData['komentar']) ? $standarData['komentar'] : null,
                ]);
                if ($isRejected) {
                    $hasRejectedItems = true;
                }

                $indikatorItems = $standarItem->unitIndikatorIndikators()->get();

                foreach ($indikatorItems as $indikatorItem) {
                    $indikatorId = $indikatorItem->id;

                    if (isset($this->indikatorData[$indikatorId])) {
                        $indikatorData = $this->indikatorData[$indikatorId];
                        $isRejected = $indikatorData['is_rejected'] ? 1 : 0;
                        $indikatorItem->update([
                            'is_rejected' => $isRejected,
                            'komentar' => !empty($indikatorData['komentar']) ? $indikatorData['komentar'] : null,
                        ]);
                        if ($isRejected) {
                            $hasRejectedItems = true;
                        }

                        // Process isiIndikator items
                        $isiIndikatorItems = $indikatorItem->unitIndikatorIsiIndikators()->get();

                        foreach ($isiIndikatorItems as $isiItem) {
                            $isiIndikatorId = $isiItem->isi_indikator_id;

                            if (isset($this->bobotIsiIndikator[$isiIndikatorId])) {
                                $isiData = $this->bobotIsiIndikator[$isiIndikatorId];
                                $isRejected = $isiData['is_rejected'] ? 1 : 0;
                                $isiItem->update([
                                    'is_rejected' => $isRejected,
                                    'komentar' => !empty($isiData['komentar']) ? $isiData['komentar'] : null,
                                ]);
                                if ($isRejected) {
                                    $hasRejectedItems = true;
                                }
                            }
                        }
                    }
                }
            }
        }

        $userIsValidator2 = Auth::id() == $this->record->validator_2_id;
        if ($userIsValidator2 || Auth::user()->hasRole('super_admin')) {
            $this->record->validated_time_2 = now();
            $this->record->status_validasi_2 = $hasRejectedItems ? 'rejected' : 'validated';
            if ($this->record->status_validasi_2 === 'validated' && $this->record->status_validasi_1 === 'validated') {
                $this->record->status = 'validated';
            }
            $this->record->save();
        }

        Notification::make()
            ->title('Validasi berhasil disimpan')
            ->success()
            ->send();

        $this->redirect(UnitIndikatorResource::getUrl('index'));
    }
}
