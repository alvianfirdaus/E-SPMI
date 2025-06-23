<?php
namespace App\Filament\Resources\JadwalResource\Pages;

use App\Models\User;
use Filament\Actions;
use Filament\Infolists;
use Filament\Infolists\Infolist;
use Filament\Resources\Pages\ViewRecord;
use App\Filament\Resources\JadwalResource;

class ViewJadwal extends ViewRecord
{
    protected static string $resource = JadwalResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\EditAction::make(),
            Actions\DeleteAction::make(),
        ];
    }

    public function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                Infolists\Components\Section::make('Informasi Dasar')
                    ->schema([
                        Infolists\Components\Grid::make(2)
                            ->schema([
                                Infolists\Components\TextEntry::make('judul')
                                    ->label('Judul')
                                    ->weight('bold')
                                    ->size('lg')
                                    ->columnSpanFull(),
                                    
                                Infolists\Components\TextEntry::make('periode.periode_name')
                                    ->label('Periode')
                                    ->badge()
                                    ->color('primary'),
                                    
                                Infolists\Components\TextEntry::make('status')
                                    ->label('Status')
                                    ->badge()
                                    ->color(fn (string $state): string => match ($state) {
                                        'pending' => 'warning',
                                        'validated' => 'success',
                                        'rejected' => 'danger',
                                        default => 'gray',
                                    }),
                                    
                                Infolists\Components\TextEntry::make('deskripsi')
                                    ->label('Deskripsi')
                                    ->columnSpanFull()
                                    ->placeholder('Tidak ada deskripsi'),
                            ]),
                    ]),

                Infolists\Components\Section::make('Waktu & Lokasi')
                    ->schema([
                        Infolists\Components\Grid::make(2)
                            ->schema([
                                Infolists\Components\TextEntry::make('start_date')
                                    ->label('Tanggal Mulai')
                                    ->date('d M Y'),
                                    
                                Infolists\Components\TextEntry::make('end_date')
                                    ->label('Tanggal Selesai')
                                    ->date('d M Y'),
                                    
                                Infolists\Components\TextEntry::make('start_time')
                                    ->label('Jam Mulai')
                                    ->time('H:i')
                                    ->placeholder('Sepanjang hari'),
                                    
                                Infolists\Components\TextEntry::make('end_time')
                                    ->label('Jam Selesai')
                                    ->time('H:i')
                                    ->placeholder('Sepanjang hari'),
                                    
                                Infolists\Components\IconEntry::make('is_all_day')
                                    ->label('Sepanjang Hari')
                                    ->boolean()
                                    ->trueIcon('heroicon-o-check-circle')
                                    ->falseIcon('heroicon-o-x-circle')
                                    ->trueColor('success')
                                    ->falseColor('gray'),
                                    
                                Infolists\Components\IconEntry::make('is_active')
                                    ->label('Status Aktif')
                                    ->boolean()
                                    ->trueIcon('heroicon-o-check-circle')
                                    ->falseIcon('heroicon-o-x-circle')
                                    ->trueColor('success')
                                    ->falseColor('danger'),
                                    
                                Infolists\Components\TextEntry::make('location')
                                    ->label('Lokasi')
                                    ->placeholder('Tidak ditentukan'),
                                    
                                Infolists\Components\TextEntry::make('meeting_link')
                                    ->label('Link Meeting')
                                    ->placeholder('Tidak ada link')
                                    ->url(fn ($state) => $state)
                                    ->openUrlInNewTab(),
                            ]),
                    ]),

                Infolists\Components\Section::make('Pengaturan')
                    ->schema([
                        Infolists\Components\Grid::make(2)
                            ->schema([
                                Infolists\Components\TextEntry::make('type')
                                    ->label('Tipe')
                                    ->badge()
                                    ->color(fn (string $state): string => match ($state) {
                                        'rapat' => 'info',
                                        'audit' => 'warning',
                                        'pelatihan' => 'success',
                                        'lainnya' => 'gray',
                                        default => 'gray',
                                    })
                                    ->formatStateUsing(fn (string $state): string => match ($state) {
                                        'rapat' => 'Rapat',
                                        'audit' => 'Audit',
                                        'pelatihan' => 'Pelatihan',
                                        'lainnya' => 'Lainnya',
                                        default => $state,
                                    }),
                                    
                                Infolists\Components\TextEntry::make('priority')
                                    ->label('Prioritas')
                                    ->badge()
                                    ->color(fn (string $state): string => match ($state) {
                                        'rendah' => 'gray',
                                        'sedang' => 'info',
                                        'tinggi' => 'warning',
                                        'mendesak' => 'danger',
                                        default => 'gray',
                                    })
                                    ->formatStateUsing(fn (string $state): string => match ($state) {
                                        'rendah' => 'Rendah',
                                        'sedang' => 'Sedang',
                                        'tinggi' => 'Tinggi',
                                        'mendesak' => 'Mendesak',
                                        default => $state,
                                    }),
                            ]),
                    ]),

                Infolists\Components\Section::make('Penugasan')
                    ->schema([
                        Infolists\Components\RepeatableEntry::make('jadwalAssignments')
                            ->label('Peserta yang Ditugaskan')
                            ->schema([
                                Infolists\Components\Grid::make(3)
                                    ->schema([
                                        Infolists\Components\TextEntry::make('user.nip')
                                            ->label('NIP'),
                                            
                                        Infolists\Components\TextEntry::make('user.name')
                                            ->label('Nama')
                                            ->weight('bold'),
                                            
                                        Infolists\Components\TextEntry::make('role_user')
                                            ->label('Peran')
                                            ->badge()
                                            ->color('primary')
                                            ->formatStateUsing(fn (string $state): string => match ($state) {
                                                'auditor' => 'Auditor',
                                                'auditee' => 'Auditee',
                                                'pimpinan' => 'Pimpinan',
                                                'p2mpp' => 'P2MPP',
                                                'organizer' => 'Organizer',
                                                'attendee' => 'Attendee',
                                                'optional' => 'Opsional',
                                                default => $state,
                                            }),
                                    ])
                            ])
                            ->placeholder('Belum ada peserta yang ditugaskan'),
                            
                        Infolists\Components\TextEntry::make('units.nama_unit')
                            ->label('Unit Terkait')
                            ->listWithLineBreaks()
                            ->placeholder('Belum ada unit yang terkait')
                            ->badge()
                            ->color('secondary'),
                    ]),

                Infolists\Components\Section::make('Validasi')
                    ->schema([
                        Infolists\Components\Grid::make(2)
                            ->schema([
                                Infolists\Components\TextEntry::make('validator.name')
                                    ->label('Validator')
                                    ->placeholder('Belum ditentukan')
                                    ->badge()
                                    ->color('info'),
                                    
                                Infolists\Components\TextEntry::make('validated_time')
                                    ->label('Waktu Validasi')
                                    ->dateTime('d M Y H:i')
                                    ->placeholder('Belum divalidasi'),
                            ]),
                    ])
                    ->visible(fn ($record) => $record->validated_by || $record->validated_time),

                Infolists\Components\Section::make('Informasi Sistem')
                    ->schema([
                        Infolists\Components\Grid::make(2)
                            ->schema([
                                Infolists\Components\TextEntry::make('creator.name')
                                    ->label('Dibuat Oleh')
                                    ->badge()
                                    ->color('gray'),
                                    
                                Infolists\Components\TextEntry::make('created_at')
                                    ->label('Dibuat Pada')
                                    ->dateTime('d M Y H:i'),
                                    
                                Infolists\Components\TextEntry::make('updated_at')
                                    ->label('Terakhir Diubah')
                                    ->dateTime('d M Y H:i')
                                    ->since(),
                            ]),
                    ])
                    ->collapsible()
                    ->collapsed(),
            ]);
    }


    protected function mutateFormDataBeforeFill(array $data): array
    {
        if (isset($data['validated_by']) && !empty($data['validated_by'])) {
            $validator = User::find($data['validated_by']);
            if ($validator) {
                $role = $validator->roles->first() ? $validator->roles->first()->name : null;
                $data['role'] = $role;
            }
        }

        return $data;
    }
}
