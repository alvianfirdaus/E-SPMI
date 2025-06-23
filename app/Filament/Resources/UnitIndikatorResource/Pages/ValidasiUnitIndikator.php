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
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Section;
use Filament\Forms\Contracts\HasForms;
use Filament\Forms\Components\Checkbox;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Notifications\Notification;
use App\Models\UnitIndikatorIsiIndikator;
use Filament\Forms\Components\Placeholder;
use Filament\Forms\Concerns\InteractsWithForms;
use App\Filament\Resources\UnitIndikatorResource;

class ValidasiUnitIndikator extends Page implements HasForms
{
    use InteractsWithForms;

    public static string $resource = UnitIndikatorResource::class;

    protected static ?string $navigationIcon = 'heroicon-o-check-circle';
    protected static string $view = 'filament.resources.unit-indikator-resource.pages.validasi-unit-indikator';
    protected static bool $shouldRegisterNavigation = false;

    public $record;

    public array $standarData = [];
    public array $indikatorData = [];

    public function mount($record): void
    {
        $unitIndikator = UnitIndikator::with([
            'unitIndikatorStandars.standar',
            'unitIndikatorStandars.unitIndikatorIndikators.indikator.subStandar',
            'unitIndikatorStandars.unitIndikatorIndikators.indikator.isiIndikators',
            'unitIndikatorStandars.unitIndikatorIndikators.unitIndikatorIsiIndikators.isiIndikator',

            'unit',
            'periode'
        ])->find($record);

        if (!$unitIndikator) {
            abort(404, 'Unit Indikator tidak ditemukan');
        }
        $user = Auth::user();
        $isValidator1 = $unitIndikator->validator_1_id === $user->id;
        $isSuperAdmin = $user->hasRole('super_admin');


        if (!($isValidator1 || $isSuperAdmin)) {
            Notification::make()
                ->title('Akses Ditolak')
                ->body('Hanya validator 1 atau super admin yang dapat mengakses halaman ini ketika status validasi 1 pending atau rejected.')
                ->danger()
                ->persistent()
                ->send();

            $this->redirect(UnitIndikatorResource::getUrl('index'));
            return;
        }
        $this->record = $unitIndikator;

        foreach ($this->record->unitIndikatorStandars as $standarItem) {
            $this->standarData[$standarItem->id] = [
                'is_rejected' => (bool)$standarItem->is_rejected,
                'komentar' => $standarItem->komentar ?? '',
            ];

            // Get indikator data through the standar relationship
            foreach ($standarItem->unitIndikatorIndikators as $indikatorItem) {
                // Convert integer 1 to true for checkbox compatibility
                $this->indikatorData[$indikatorItem->id] = [
                    'is_rejected' => (bool)$indikatorItem->is_rejected,
                    'komentar' => $indikatorItem->komentar ?? '',
                ];
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
        $schema = [];

        $schema[] = Section::make($standarName)
            ->schema([
                Checkbox::make("standarData.{$unitIndikatorStandarId}.is_rejected")
                    ->label('Tandai Standar sebagai tidak valid')
                    ->reactive()
                    ->afterStateUpdated(function ($state, callable $set) use ($unitIndikatorStandarId) {
                        $this->toggleStandarRejection($unitIndikatorStandarId, $state);
                    }),

                Textarea::make("standarData.{$unitIndikatorStandarId}.komentar")
                    ->label('Komentar untuk Standar')
                    ->placeholder('Tambahkan komentar untuk standar ini...')
                    ->rows(2),
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

            $indikatorSchema = [
                Checkbox::make("indikatorData.{$indikatorId}.is_rejected")
                    ->label('Tandai sebagai tidak valid')
                    ->helperText('Centang jika indikator ini tidak valid'),

                Textarea::make("indikatorData.{$indikatorId}.komentar")
                    ->label('Komentar Indikator')
                    ->placeholder('Tambahkan komentar validasi di sini...')
                    ->rows(3),
            ];

            if ($isiIndikators && $isiIndikators->count() > 0) {
                foreach ($isiIndikators as $index => $isiIndikator) {
                    $unitIndikatorIsiIndikators = collect();
                    
                    // Find the current unit indikator indikator that matches this context
                    $currentUnitIndikatorIndikator = null;
                    foreach ($standarItem->unitIndikatorIndikators as $uii) {
                        if ($uii->indikator_id === $isiIndikator->indikator_id) {
                            $currentUnitIndikatorIndikator = $uii;
                            break;
                        }
                    }

                    if ($currentUnitIndikatorIndikator) {
                        $unitIndikatorIsiIndikators = UnitIndikatorIsiIndikator::where('unit_indikator_indikator_id', $currentUnitIndikatorIndikator->id)
                            ->where('isi_indikator_id', $isiIndikator->id)
                            ->get();
                    }

                    // Create isi indikator section with data
                    $isiIndikatorSchema = [
                        // Show the isi_indikator description
                        Placeholder::make('isi_indikator_desc_' . $isiIndikator->id)
                            ->label('Deskripsi')
                            ->content(function () use ($isiIndikator) {
                                $content = $isiIndikator->isi_indikator ?? 'Tidak ada deskripsi';
                                $content = str_replace('<ul>', '<ul style="list-style-type: disc; padding-left: 1rem;">', $content);
                                $content = str_replace('<ol>', '<ol style="list-style-type: decimal; padding-left: 1rem;">', $content);
                                $content = str_replace('<li>', '<li style="margin-bottom: 4px;">', $content);
                                return new HtmlString($content);
                            }),
                    ];

                    // Add unit data if exists
                    if ($unitIndikatorIsiIndikators->isNotEmpty()) {
                        foreach ($unitIndikatorIsiIndikators as $unitIndex => $unitData) {
                            $isiIndikatorSchema[] = Card::make()
                                ->schema([
                                    // Display pertanyaan, target, bukti using Placeholder components
                                    Placeholder::make("pertanyaan_display_{$unitData->id}")
                                        ->label('Pertanyaan')
                                        ->content($unitData->pertanyaan ?? 'Belum ada pertanyaan'),

                                    Grid::make(2)
                                        ->schema([
                                            Placeholder::make("target_display_{$unitData->id}")
                                                ->label('Target')
                                                ->content($unitData->target ?? 'Belum ada target'),

                                            Placeholder::make("bukti_display_{$unitData->id}")
                                                ->label('Bukti')
                                                ->content($unitData->bukti ?? 'Belum ada bukti'),
                                        ]),
                                ]);
                        }
                    } else {
                        // Show message if no data
                        $isiIndikatorSchema[] = Placeholder::make('no_unit_data_' . $isiIndikator->id)
                            ->content(new HtmlString('<div style="text-align: center; color: #9ca3af; padding: 20px; font-style: italic;">Belum ada data untuk isi indikator ini</div>'));
                    }

                    // Add the isi indikator section to main schema
                    $indikatorSchema[] = Section::make(($index + 1) . '. ' . strip_tags($isiIndikator->isi_indikator ?? 'Isi Indikator'))
                        ->schema($isiIndikatorSchema)
                        ->collapsible()
                        ->collapsed(false);
                }
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

    if (empty($tabs)) {
        return $form->schema([
            Section::make('Tidak Ada Data')
                ->schema([
                    Placeholder::make('no_data')
                        ->content('Tidak ada data standar untuk divalidasi.')
                ])
        ]);
    }

    return $form
        ->schema([
            Tabs::make('Validasi')
                ->tabs($tabs)
                ->activeTab(1)
        ]);
}


    public function toggleStandarRejection($unitIndikatorStandarId, $isRejected): void
    {
        $standar = $this->record->unitIndikatorStandars->firstWhere('id', $unitIndikatorStandarId);

        if (!$standar) {
            return;
        }

        $relatedIndikators = $standar->unitIndikatorIndikators()->get();

        foreach ($relatedIndikators as $indikatorItem) {
            $indikatorId = $indikatorItem->id;

            // Update data
            $this->indikatorData[$indikatorId]['is_rejected'] = $isRejected;
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
                    'komentar' => !empty($standarData['komentar']) ? $standarData['komentar'] : null,  // Check if komentar is empty, if so set to null
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
                    }
                }
            }
        }

        $userIsValidator1 = Auth::id() == $this->record->validator_1_id;
        if ($userIsValidator1) {
            $this->record->validated_time_1 = now();
            $this->record->status_validasi_1 = $hasRejectedItems ? 'rejected' : 'validated';
            $this->record->status = $hasRejectedItems ? 'rejected' : 'validated';
            $this->record->save();
        }

        Notification::make()
            ->title('Validasi berhasil disimpan')
            ->success()
            ->send();

        $this->redirect(UnitIndikatorResource::getUrl('index'));
    }
}
