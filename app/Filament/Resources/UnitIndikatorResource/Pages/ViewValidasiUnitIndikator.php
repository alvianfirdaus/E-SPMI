<?php

namespace App\Filament\Resources\UnitIndikatorResource\Pages;

use Filament\Actions;
use App\Models\UnitIndikator;
use Filament\Infolists\Infolist;
use Filament\Resources\Pages\Page;
use Illuminate\Support\Facades\Auth;
use Filament\Infolists\Components\Grid;
use Filament\Infolists\Components\Tabs;
use Filament\Infolists\Components\Section;
use Filament\Infolists\Components\TextEntry;
use Filament\Notifications\Notification;
use App\Filament\Resources\UnitIndikatorResource;

class ViewValidasiUnitIndikator extends Page
{
    protected static string $resource = UnitIndikatorResource::class;

    protected static ?string $navigationIcon = 'heroicon-o-eye';
    protected static string $view = 'filament.resources.unit-indikator-resource.pages.view-validasi-unit-indikator-1';
    protected static bool $shouldRegisterNavigation = false;

    public $record;

    public function mount($record): void
    {
        $unitIndikator = UnitIndikator::with([
            'unitIndikatorStandars.standar',
            'unitIndikatorStandars.unitIndikatorIndikators.indikator.subStandar',
            'unitIndikatorStandars.unitIndikatorIndikators.indikator.isiIndikators',
            'unit',
            'periode',
            'validator1',
        ])->find($record);

        if (!$unitIndikator) {
            abort(404, 'Unit Indikator tidak ditemukan');
        }
        $user = Auth::user();

        $isCreator = $unitIndikator->created_by === $user->id;
        $isValidator1 = $unitIndikator->validator_1_id === $user->id;
        $isSuperAdmin = $user->hasRole('super_admin');

        if (!($isCreator || $isSuperAdmin || $isValidator1)) {
            Notification::make()
                ->title('Akses Ditolak')
                ->body('Hanya pembuat, validator atau super admin yang dapat mengakses halaman ini.')
                ->danger()
                ->persistent()
                ->send();

            $this->redirect(UnitIndikatorResource::getUrl('index'));
            return;
        }
        $this->record = $unitIndikator;
    }

    public function infolist(Infolist $infolist): Infolist
    {
        $tabs = [];

        foreach ($this->record->unitIndikatorStandars as $standarItem) {
            if (!\App\Models\UnitIndikatorStandar::find($standarItem->id)) {
                continue;
            }

            $standarName = $standarItem->standar ? $standarItem->standar->nama_standar : 'Standar';
            $schema = [];
            $standarStatus = ($standarItem->is_rejected === 1) ? 'Ditolak' : ($standarItem->is_rejected === 0 ? 'Diterima' : '');  // Handle 0 and 1, else empty
            $standarKomentar = $standarItem->komentar ?? 'Tidak ada komentar';

            // Add the schema for this standar
            $schema[] = Section::make($standarName)
                ->schema([
                    TextEntry::make("unitIndikatorStandars.{$standarItem->id}.is_rejected")
                        ->label('Komentar untuk Standar')
                        ->formatStateUsing(function () use ($standarStatus) {
                            return $standarStatus; // Display based on rejection status
                        })
                        ->default($standarStatus)  // Default value based on $standarStatus
                        ->badge()  // Adds the badge style
                        ->color(function () use ($standarStatus) {
                            return $standarStatus === 'Ditolak' ? 'danger' : 'success';
                        }),
                    TextEntry::make("unitIndikatorStandars.{$standarItem->id}.komentar")
                        ->label('Komentar untuk Standar')
                        ->placeholder('Tidak ada komentar')
                        ->formatStateUsing(function () use ($standarKomentar) {
                            return $standarKomentar;  // Use the dynamic komentar value
                        })
                ])
                ->headerActions([
                    \Filament\Infolists\Components\Actions\Action::make('lihat_detail')
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
                ]);

            // Get related indikator for this standar
            $relatedIndikators = $standarItem->unitIndikatorIndikators;

            foreach ($relatedIndikators as $indikatorItem) {
                $indikatorId = $indikatorItem->id;
                $indikator = $indikatorItem->indikator;
                $indikatorTitle = $indikator->subStandar->nama_sub_standar ?? 'Indikator';
                $isiIndikators = $indikator->isiIndikators;

                $indikatorStatus = $indikatorItem->is_rejected ? 'Ditolak' : 'Diterima';
                $indikatorKomentar = $indikatorItem->komentar ?? 'Tidak ada komentar';

                $indikatorSchema = [
                    TextEntry::make("unitIndikatorIndikators.{$indikatorId}.is_rejected")
                        ->label('Status Validasi')
                        ->formatStateUsing(function () use ($indikatorStatus) {
                            return $indikatorStatus;
                        })
                        ->default($indikatorStatus)  // Default value based on $standarStatus

                        ->badge()
                        ->color(function () use ($indikatorStatus) {
                            return $indikatorStatus === 'Ditolak' ? 'danger' : 'success';
                        }),
                    TextEntry::make("unitIndikatorIndikators.{$indikatorId}.komentar")
                        ->label('Komentar Indikator')
                        ->placeholder('Tidak ada komentar')
                        ->formatStateUsing(function () use ($indikatorKomentar) {
                            return $indikatorKomentar;  // Ensure default comment is shown
                        }),
                ];

                // If there are isiIndikators, add them to the schema
                if ($isiIndikators && $isiIndikators->count() > 0) {
    $indikatorSchema[] = Section::make('Isi Indikator')
        ->schema(function () use ($isiIndikators, $indikatorItem) {
            $components = [];
            
            foreach ($isiIndikators as $index => $isiIndikator) {
                $content = $isiIndikator->isi_indikator ?? 'Tidak ada deskripsi';
                $plainContent = strip_tags($content);
                
                // Find the corresponding unit_indikator_isi_indikator record
                $unitIsiIndikator = $indikatorItem->unitIndikatorIsiIndikators
                    ->where('isi_indikator_id', $isiIndikator->id)
                    ->first();
                
                $sectionSchema = [
                    // Display the isi indikator content
                    \Filament\Infolists\Components\TextEntry::make("isi_content_{$isiIndikator->id}")
                        ->label('Deskripsi')
                        ->state($plainContent)
                        ->columnSpan('full'),
                ];
                
                // If we have the unit isi indikator data, display it
                if ($unitIsiIndikator) {
                    $sectionSchema[] = \Filament\Infolists\Components\Grid::make(1)
                        ->schema([
                            \Filament\Infolists\Components\TextEntry::make("pertanyaan_{$isiIndikator->id}")
                                ->label('Pertanyaan')
                                ->state($unitIsiIndikator->pertanyaan ?? 'Tidak ada pertanyaan')
                                ->columnSpan('full'),
                            
                            \Filament\Infolists\Components\Grid::make(2)
                                ->schema([
                                    \Filament\Infolists\Components\TextEntry::make("target_{$isiIndikator->id}")
                                        ->label('Target')
                                        ->state($unitIsiIndikator->target ?? 'Tidak ada target')
                                        ->badge()
                                        ->color('info'),
                                    
                                    \Filament\Infolists\Components\TextEntry::make("bukti_{$isiIndikator->id}")
                                        ->label('Bukti')
                                        ->state($unitIsiIndikator->bukti ?? 'Tidak ada bukti')
                                        ->url(fn ($state) => $state && $state !== 'Tidak ada bukti' ? $state : null)
                                        ->openUrlInNewTab()
                                        ->badge()
                                        ->color(fn ($state) => $state && $state !== 'Tidak ada bukti' ? 'success' : 'gray'),
                                ]),
                        ]);
                }
                
                $components[] = \Filament\Infolists\Components\Section::make(($index + 1) . ". " . \Illuminate\Support\Str::limit($plainContent, 100))
                    ->schema($sectionSchema)
                    ->collapsible()
                    ->collapsed(false);
            }
            
            return $components;
        })
        ->collapsible()
        ->collapsed(false);
}

                $schema[] = Section::make($indikatorTitle)
                    ->schema($indikatorSchema)
                    ->collapsible()
                    ->headerActions([
                        \Filament\Infolists\Components\Actions\Action::make('lihat_detail')
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


        return $infolist
            ->record($this->record)
            ->schema([
                Section::make('Informasi Validasi')
                    ->schema([
                        Section::make('Deskripsi')
                            ->schema([
                                TextEntry::make('status')
                                    ->label('Status Utama')
                                    ->badge()
                                    ->icon(fn(string $state): string => match ($state) {
                                        'pending' => 'heroicon-o-clock',
                                        'validated' => 'heroicon-o-check-circle',
                                        'rejected' => 'heroicon-o-x-circle',
                                        default => 'heroicon-o-question-mark-circle',
                                    })
                                    ->color(fn(string $state): string => match ($state) {
                                        'pending' => 'warning',
                                        'validated' => 'success',
                                        'rejected' => 'danger',
                                        default => 'gray',
                                    }),
                                TextEntry::make('unit.nama_unit')
                                    ->label('Unit'),
                                TextEntry::make('periode.periode_name')
                                    ->label('Periode'),
                            ])
                            ->columns(3)
                            ->compact(),

                        Grid::make(2)
                            ->schema([
                                Section::make()
                                    ->heading('Status Validasi')
                                    ->schema([
                                        TextEntry::make('status_validasi_1')
                                            ->label('Status Validasi')
                                            ->badge()
                                            ->icon(fn(string $state): string => match ($state) {
                                                'pending' => 'heroicon-o-clock',
                                                'validated' => 'heroicon-o-check-circle',
                                                'rejected' => 'heroicon-o-x-circle',
                                                default => 'heroicon-o-question-mark-circle',
                                            })
                                            ->color(fn(string $state): string => match ($state) {
                                                'pending' => 'warning',
                                                'validated' => 'success',
                                                'rejected' => 'danger',
                                                default => 'gray',
                                            }),
                                        TextEntry::make('validated_time_1')
                                            ->label('Tanggal Validasi')
                                            ->dateTime('d M Y H:i')
                                            ->placeholder('Belum divalidasi')
                                            ->badge()
                                            ->icon('heroicon-o-calendar')
                                            ->color('success'),

                                    ])->columnSpan(1),
                                Section::make()
                                    ->heading('User')
                                    ->schema([
                                        TextEntry::make('validator1.name')
                                            ->label('Validator')
                                            ->placeholder('Belum ditentukan')
                                            ->badge()
                                            ->color('info')
                                            ->icon('heroicon-o-user'),
                                        TextEntry::make('auditeeUser.name')
                                            ->label('Auditee')
                                            ->placeholder('Belum ditentukan')
                                            ->badge()
                                            ->color('info')
                                            ->icon('heroicon-o-user'),
                                    ])->columnSpan(1),
                            ]),
                    ])
                    ->collapsible()
                    ->columnSpan('full'),

                Tabs::make('Hasil Validasi')
                    ->tabs($tabs)
                    ->activeTab(isset($tabs[0]) ? 0 : null)
            ]);
    }

    protected function getActions(): array
    {
        return [
            Actions\Action::make('kembali')
                ->label('Kembali')
                ->url(UnitIndikatorResource::getUrl('index'))
                ->color('secondary'),
        ];
    }
}
