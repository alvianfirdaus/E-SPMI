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

class PengisianBobot extends Page implements HasForms
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
            abort(404, 'Unit Indikator tidak ditemukan');
        }
        $user = Auth::user();
        $isCreator = $unitIndikator->created_by === $user->id;
        $isSuperAdmin = $user->hasRole('super_admin');
        
        $isValidated = $unitIndikator->status_validasi_1 === 'validated';
        
        if (!($isCreator || $isSuperAdmin) && !$isValidated) {
            Notification::make()
                ->title('Akses Ditolak')
                ->body('Hanya pembuat atau super admin yang dapat mengakses halaman ini ketika status validasi 1 telah tervalidasi.')
                ->danger()
                ->persistent()
                ->send();
                
            $this->redirect(UnitIndikatorResource::getUrl('index'));
            return;
        }
        $this->record = $unitIndikator;
        
        $this->bobotIsiIndikator = [];
        
        foreach ($unitIndikator->unitIndikatorStandars as $standar) {
            foreach ($standar->unitIndikatorIndikators as $indikator) {
                foreach ($indikator->unitIndikatorIsiIndikators as $isiIndikator) {
                    $this->bobotIsiIndikator[$isiIndikator->isi_indikator_id] = $isiIndikator->bobot;
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

                if ($isiIndikators && $isiIndikators->count() > 0) {
                    $indikatorSchema[] = Section::make('Isi Indikator')
                        ->schema(function () use ($isiIndikators) {
                            $components = [];

                            foreach ($isiIndikators as $index => $isiIndikator) {
                                $components[] = Section::make()
                                    ->schema([
                                        Grid::make(2)
                                            ->schema([
                                                Placeholder::make('isi_indikator_title_' . $isiIndikator->id)
                                                    ->label(false)
                                                    ->content(function () use ($isiIndikator, $index) {
                                                        $content = $isiIndikator->isi_indikator ?? 'Tidak ada deskripsi';

                                                        // Tambahkan styling untuk list
                                                        $content = str_replace('<ul>', '<ul style="list-style-type: disc; padding-left: 1rem;">', $content);
                                                        $content = str_replace('<ol>', '<ol style="list-style-type: decimal; padding-left: 1rem;">', $content);
                                                        $content = str_replace('<li>', '<li style="margin-bottom: 4px;">', $content);

                                                        // Opsional: limit isi & ubah line break
                                                        $plain = strip_tags($content);
                                                        $limited = Str::limit($plain, 250);

                                                        return new HtmlString('<strong>' . ($index + 1) . '.</strong> ' . nl2br(e($plain)));
                                                    }),
                                                TextInput::make("bobotIsiIndikator.{$isiIndikator->id}")
                                                    ->label('Bobot')
                                                    ->placeholder('Isikan bobot')
                                                    ->numeric()
                                                    ->step(0.01)
                                                    ->minValue(0)
                                                    ->maxValue(100)
                                                    ->suffix('%')
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
                            ->modalContent(function () use ($indikator) {
                                $indikatorId = $indikator->id;
                                $indikatorData = \App\Models\Indikator::with(['subStandar.standar', 'isiIndikators'])->find($indikatorId);
                                return view('livewire.comp
                                onents.dtail-sub-standar', [
                                    'indikator' => $indikatorData,
                                ]);
                            })
                            ->modalSubmitAction(false)
                            ->modalCancelActionLabel('Tutup'),
                    ]);
            }

            // Create a tab for this UnitIndikatorStandar
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

    public function submit(): void
{
    $hasError = false;

    foreach ($this->record->unitIndikatorStandars as $standarItem) {
        foreach ($standarItem->unitIndikatorIndikators as $indikatorItem) {
            $totalBobot = 0;
            $indikatorName = $indikatorItem->indikator->nama ?? "Indikator {$indikatorItem->id}";
            
            foreach ($indikatorItem->unitIndikatorIsiIndikators as $isiItem) {
                $isiIndikatorId = $isiItem->isi_indikator_id;
                
                if (isset($this->bobotIsiIndikator[$isiIndikatorId]) && 
                    is_numeric($this->bobotIsiIndikator[$isiIndikatorId])) {
                    $totalBobot += floatval($this->bobotIsiIndikator[$isiIndikatorId]);
                }
            }

            if ($totalBobot > 100) {
                Notification::make()
                    ->title("Total bobot untuk indikator '{$indikatorName}' melebihi 100% (saat ini: {$totalBobot})")
                    ->danger()
                    ->send();
                $hasError = true;
            }
        }
    }

    if ($hasError) return;

    $updatedCount = 0;
    
    try {
        // Get a fresh copy of the record to ensure we have the most up-to-date data
        $freshRecord = UnitIndikator::with([
            'unitIndikatorStandars.unitIndikatorIndikators.unitIndikatorIsiIndikators'
        ])->findOrFail($this->record->id);
        
        foreach ($freshRecord->unitIndikatorStandars as $standarItem) {
            foreach ($standarItem->unitIndikatorIndikators as $indikatorItem) {
                foreach ($indikatorItem->unitIndikatorIsiIndikators as $isiItem) {
                    // Get the ID directly from the record we're processing
                    $isiItemId = $isiItem->id;
                    $isiIndikatorId = $isiItem->isi_indikator_id;
                    
                    if (isset($this->bobotIsiIndikator[$isiIndikatorId]) && 
                        is_numeric($this->bobotIsiIndikator[$isiIndikatorId])) {
                        
                        $bobot = floatval($this->bobotIsiIndikator[$isiIndikatorId]);
                        
                        // Update using a direct query with the ID of this specific record
                        $affected = \Illuminate\Support\Facades\DB::table('unit_indikator_isi_indikators')
                            ->where('id', $isiItemId)
                            ->update([
                                'bobot' => $bobot,
                                'updated_at' => now()
                            ]);
                            
                        if ($affected) {
                            $updatedCount++;
                        }
                    }
                }
            }
        }
        
        if ($updatedCount > 0) {
            Notification::make()
                ->title('Bobot berhasil disimpan')
                ->body("Berhasil memperbarui {$updatedCount} data bobot")
                ->success()
                ->send();
        } else {
            Notification::make()
                ->title('Tidak ada perubahan')
                ->body("Tidak ada data yang diperbarui. Periksa kembali input Anda.")
                ->warning()
                ->send();
        }
        
        $this->redirect(UnitIndikatorResource::getUrl('index'));
    } catch (\Exception $e) {
        Notification::make()
            ->title('Terjadi kesalahan')
            ->body('Detail: ' . $e->getMessage())
            ->danger()
            ->send();
    }
}
}

