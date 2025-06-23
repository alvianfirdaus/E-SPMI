<?php

namespace App\Filament\Resources;

use Carbon\Carbon;
use Filament\Forms;
use App\Models\Unit;
use App\Models\User;
use Filament\Tables;
use App\Models\Jadwal;
use App\Models\Periode;
use Filament\Forms\Get;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use Filament\Tables\Filters\Filter;
use Illuminate\Support\Facades\Auth;
use Filament\Tables\Enums\FiltersLayout;
use Filament\Tables\Actions\ExportAction;
use Filament\Tables\Filters\SelectFilter;
use Illuminate\Database\Eloquent\Builder;
use Filament\Tables\Actions\ExportBulkAction;
use pxlrbt\FilamentExcel\Exports\ExcelExport;
use App\Filament\Resources\JadwalResource\Pages;
use pxlrbt\FilamentExcel\Actions\Tables\ExportAction as ExcelExportAction;

class JadwalResource extends Resource
{
    protected static ?string $model = Jadwal::class;
    protected static ?string $navigationIcon = 'heroicon-o-calendar-days';
    protected static ?string $navigationLabel = 'Jadwal';
    protected static ?string $modelLabel = 'Jadwal';
    protected static ?string $pluralModelLabel = 'Jadwal';
    protected static ?int $navigationSort = 2;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Dasar')
                    ->schema([
                        Forms\Components\Select::make('periode_id')
                            ->label('Periode')
                            ->relationship('periode', 'periode_name')
                            ->required()
                            ->default(fn() => Periode::where('status_periode', 'active')->first()?->id),

                        Forms\Components\TextInput::make('judul')
                            ->label('Judul')
                            ->required()
                            ->maxLength(255)
                            ->columnSpanFull(),

                        Forms\Components\Textarea::make('deskripsi')
                            ->label('Deskripsi Singkat')
                            ->rows(3)
                            ->columnSpanFull(),
                    ])->columns(2),

                Forms\Components\Section::make('Waktu & Lokasi')
                    ->schema([
                        Forms\Components\DatePicker::make('start_date')
                            ->label('Tanggal Mulai')
                            ->required()
                            ->default(now()),

                        Forms\Components\TimePicker::make('start_time')
                            ->label('Jam Mulai')
                            ->hidden(fn(Forms\Get $get) => $get('is_all_day')),

                        Forms\Components\DatePicker::make('end_date')
                            ->label('Tanggal Selesai')
                            ->required()
                            ->afterOrEqual('start_date'),

                        Forms\Components\TimePicker::make('end_time')
                            ->label('Jam Selesai')
                            ->hidden(fn(Forms\Get $get) => $get('is_all_day')),

                        Forms\Components\Toggle::make('is_all_day')
                            ->label('Sepanjang Hari')
                            ->columnSpanFull(),

                        Forms\Components\TextInput::make('location')
                            ->helperText('Lokasi dilaksakannya jadwal')
                            ->label('Lokasi')
                            ->maxLength(255),

                        Forms\Components\TextInput::make('meeting_link')
                            ->helperText('Apabila dilaksanakan secara daring')
                            ->label('Link Meeting')
                            ->maxLength(255),
                    ])->columns(2),

                Forms\Components\Section::make('Pengaturan')
                    ->schema([
                        Forms\Components\Select::make('type')
                            ->label('Tipe')
                            ->options([
                                'rapat' => 'Rapat',
                                'audit' => 'Audit',
                                'pelatihan' => 'Pelatihan',
                                'lainnya' => 'Lainnya',
                            ])
                            ->required(),

                        Forms\Components\Select::make('priority')
                            ->label('Prioritas')
                            ->helperText('Prioritas Jadwal')
                            ->options([
                                'rendah' => 'Rendah',
                                'sedang' => 'Sedang',
                                'tinggi' => 'Tinggi',
                                'mendesak' => 'Mendesak',
                            ])
                            ->required(),

                        Forms\Components\Toggle::make('is_active')
                            ->label('Aktif')
                            ->default(true),
                    ])->columns(2),

                Forms\Components\Section::make('Penugasan')
                    ->schema([
                        Forms\Components\Repeater::make('jadwalAssignments')
                            ->label('Penugasan Peserta')
                            ->helperText('Tambahkan peserta dan tentukan peran masing-masing')
                            ->relationship('jadwalAssignments')
                            ->schema([
                                Forms\Components\Grid::make(3)
                                    ->schema([
                                        Forms\Components\Select::make('role_filter')
                                            ->label('Filter by Role (Optional)')
                                            ->helperText('Pilih role untuk memfilter user yang ditampilkan')
                                            ->options(\Spatie\Permission\Models\Role::pluck('name', 'name'))
                                            ->reactive()
                                            ->placeholder('All Users')
                                            ->dehydrated(false),

                                        Forms\Components\Select::make('user_id')
                                            ->label('Peserta')
                                            ->options(function (callable $get) {
                                                $roleFilter = $get('role_filter');

                                                if ($roleFilter) {
                                                    return \App\Models\User::role($roleFilter)
                                                        ->get()
                                                        ->mapWithKeys(function ($user) {
                                                            return [$user->id => "{$user->nip} - {$user->name}"];
                                                        });
                                                }
                                                return \App\Models\User::all()->mapWithKeys(function ($user) {
                                                    return [$user->id => "{$user->nip} - {$user->name}"];
                                                });
                                            })
                                            ->searchable()
                                            ->required()
                                            ->distinct()
                                            ->disableOptionsWhenSelectedInSiblingRepeaterItems()
                                            ->reactive(),

                                        Forms\Components\Select::make('role_user')
                                            ->label('Peran dalam Jadwal')
                                            ->options([
                                                'auditor' => 'Auditor',
                                                'auditee' => 'Auditee',
                                                'pimpinan' => 'Pimpinan',
                                                'p2mpp' => 'P2MPP',
                                                'organizer' => 'Organizer',
                                                'attendee' => 'Attendee',
                                                'optional' => 'Opsional',
                                            ])
                                            ->required()
                                            ->default('attendee'),
                                    ])
                            ])
                            ->defaultItems(1)
                            ->addActionLabel('Tambah Peserta')
                            ->reorderableWithButtons()
                            ->collapsible()
                            ->itemLabel(
                                fn(array $state): ?string =>
                                isset($state['user_id'])
                                    ? \App\Models\User::find($state['user_id'])?->name . ' (' . ($state['role_user'] ?? 'No Role') . ')'
                                    : 'Penugasan Baru'
                            ),
                        Forms\Components\Select::make('units')
                            ->label('Unit Terkait')
                            ->helperText('Pilih unit yang terlibat dalam jadwal')
                            ->relationship('units', 'nama_unit')
                            ->multiple()
                            ->searchable()
                            ->preload(),
                    ])->columns(1),

                Forms\Components\Section::make('Validator')
                    ->icon('heroicon-m-user')

                    ->description('Menentukan role validator lalu user yang akan melakukan validasi.')
                    ->schema([
                        Forms\Components\Select::make('role')
                            ->label('Role Validator')
                            ->options(\Spatie\Permission\Models\Role::pluck('name', 'name'))
                            ->reactive()
                            ->required(),

                        Forms\Components\Select::make('validated_by')
                            ->label('User Validator')
                            ->options(function (callable $get) {
                                $role = $get('role');

                                if (! $role) return [];

                                return \App\Models\User::role($role)
                                    ->get()
                                    ->mapWithKeys(fn($user) => [
                                        $user->id => "{$user->nip} - {$user->name}",
                                    ])
                                    ->toArray();
                            })
                            ->searchable()
                            ->required()
                            ->visible(fn(callable $get) => filled($get('role'))),
                    ])
                    ->columns(2)
                    ->collapsible(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->groups([
                'status',
                'tahun',
            ])
            ->groupingSettingsInDropdownOnDesktop()
            ->deferLoading()
            ->columns([
                Tables\Columns\TextColumn::make('index')
                    ->label('No. ')
                    ->rowIndex(),
                Tables\Columns\TextColumn::make('judul')
                    ->label('Judul')
                    ->searchable()
                    ->sortable()
                    ->weight('medium')
                    ->wrap(),

                Tables\Columns\TextColumn::make('periode.periode_name')
                    ->label('Periode')
                    ->badge()
                    ->color('gray')
                    ->sortable(),

                Tables\Columns\TextColumn::make('jadwalAssignments.user.name')
                    ->label('Peserta')
                    ->listWithLineBreaks()
                    ->limit(3)
                    ->tooltip(function ($record) {
                        return $record->jadwalAssignments
                            ->map(fn($assignment) => $assignment->user->name . ' (' . $assignment->role_user . ')')
                            ->join(', ');
                    })
                    ->toggleable(),

                Tables\Columns\TextColumn::make('units.nama_unit')
                    ->label('Unit')
                    ->listWithLineBreaks()
                    ->limit(2)
                    ->toggleable(),

                Tables\Columns\TextColumn::make('validator.name')
                    ->label('Validator')
                    ->placeholder('Belum ditentukan')
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('start_date')
                    ->label('Tanggal Mulai')
                    ->date('d M Y')
                    ->sortable(),

                Tables\Columns\TextColumn::make('start_time')
                    ->label('Jam Mulai')
                    ->time('H:i')
                    ->placeholder('-')
                    ->toggleable(),
                Tables\Columns\TextColumn::make('end_date')
                    ->label('Tanggal Selesai')
                    ->date('d M Y')
                    ->sortable(),

                Tables\Columns\TextColumn::make('end_time')
                    ->label('Jam Berakhir')
                    ->time('H:i')
                    ->placeholder('-')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('type')
                    ->label('Tipe')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'rapat' => 'info',
                        'audit' => 'warning',
                        'pelatihan' => 'success',
                        'lainnya' => 'gray',
                    })
                    ->formatStateUsing(fn(string $state): string => match ($state) {
                        'rapat' => 'Meeting',
                        'audit' => 'Audit',
                        'pelatihan' => 'Pelatihan',
                        'lainnya' => 'Lainnya',
                    }),

                Tables\Columns\TextColumn::make('priority')
                    ->label('Prioritas')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'rendah' => 'gray',
                        'sedang' => 'info',
                        'tinggi' => 'warning',
                        'mendesak' => 'danger',
                    })
                    ->formatStateUsing(fn(string $state): string => match ($state) {
                        'rendah' => 'Rendah',
                        'sedang' => 'Sedang',
                        'tinggi' => 'Tinggi',
                        'mendesak' => 'Mendesak',
                    }),

                Tables\Columns\IconColumn::make('is_active')
                    ->label('Aktif')
                    ->boolean()
                    ->trueColor('success')
                    ->falseColor('danger')
                    ->toggleable(),

                Tables\Columns\TextColumn::make('location')
                    ->label('Lokasi')
                    ->placeholder('-')
                    ->limit(30)
                    ->toggleable(isToggledHiddenByDefault: true),

                Tables\Columns\TextColumn::make('users_count')
                    ->label('Peserta')
                    ->counts('users')
                    ->badge()
                    ->color('gray'),

                Tables\Columns\TextColumn::make('created_at')
                    ->label('Dibuat')
                    ->dateTime('d M Y H:i')
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
            ])
            ->defaultSort('created_at', 'desc')
            ->filters([
                SelectFilter::make('periode_id')
                    ->label('Periode')
                    ->relationship('periode', 'periode_name')
                    ->default(function () {
                        // Priority: 1) Session value, 2) Active periode
                        return session('selected_periode_id') ??
                            Periode::where('status_periode', 'active')->first()?->id;
                    })
                    ->query(function (Builder $query, array $data): Builder {
                        if (filled($data['value'])) {
                            // Update session when filter is manually changed
                            session(['selected_periode_id' => $data['value']]);
                            return $query->where('periode_id', $data['value']);
                        }
                        return $query;
                    }),
                SelectFilter::make('type')
                    ->label('Tipe')
                    ->options([
                        'meeting' => 'Meeting',
                        'deadline' => 'Deadline',
                        'audit' => 'Audit',
                        'training' => 'Training',
                        'other' => 'Lainnya',
                    ]),

                SelectFilter::make('priority')
                    ->label('Prioritas')
                    ->options([
                        'low' => 'Rendah',
                        'medium' => 'Sedang',
                        'high' => 'Tinggi',
                        'urgent' => 'Mendesak',
                    ]),

                SelectFilter::make('status')
                    ->label('Status')
                    ->options([
                        'scheduled' => 'Terjadwal',
                        'in_progress' => 'Berlangsung',
                        'completed' => 'Selesai',
                        'cancelled' => 'Dibatalkan',
                    ]),

                Filter::make('is_active')
                    ->label('Hanya Aktif')
                    ->query(fn(Builder $query): Builder => $query->where('is_active', true))
                    ->default(),

                Filter::make('my_schedule')
                    ->label('Jadwal Saya')
                    ->query(
                        fn(Builder $query): Builder =>
                        $query->whereHas('users', fn($q) => $q->where('user_id', Auth::id()))
                    ),

                Filter::make('this_week')
                    ->label('Minggu Ini')
                    ->query(
                        fn(Builder $query): Builder =>
                        $query->whereBetween('start_date', [
                            Carbon::now()->startOfWeek(),
                            Carbon::now()->endOfWeek()
                        ])
                    ),

                Filter::make('this_month')
                    ->label('Bulan Ini')
                    ->query(
                        fn(Builder $query): Builder =>
                        $query->whereBetween('start_date', [
                            Carbon::now()->startOfMonth(),
                            Carbon::now()->endOfMonth()
                        ])
                    ),
            ], layout: FiltersLayout::AboveContentCollapsible)
            ->actions([
                Tables\Actions\Action::make('toggleValidation')
                    ->visible(function (Jadwal $record): bool {
                        return in_array($record->status, ['pending', 'validated', 'rejected']) &&
                            (
                                $record->validated_by === Auth::id() ||
                                Auth::user()?->hasRole('super_admin')
                            );
                    })
                    ->icon(function (Jadwal $record) {
                        return match ($record->status) {
                            'pending' => 'heroicon-m-clock',
                            'validated' => 'heroicon-m-check-circle',
                            'rejected' => 'heroicon-m-x-circle',
                            default => 'heroicon-m-question-mark-circle'
                        };
                    })
                    ->label(function (Jadwal $record) {
                        return match ($record->status) {
                            'pending' => 'Review Jadwal',
                            'validated' => 'Ubah Status',
                            'rejected' => 'Ubah Status',
                            default => 'Review'
                        };
                    })
                    ->form(function (Jadwal $record) {
                        $formFields = [];

                        if ($record->status === 'pending') {
                            $formFields[] = Forms\Components\Select::make('new_status')
                                ->label('Pilih Status')
                                ->options([
                                    'validated' => 'Validasi (Setujui)',
                                    'rejected' => 'Tolak (Reject)',
                                ])
                                ->required()
                                ->reactive();

                            $formFields[] = Forms\Components\DateTimePicker::make('validated_time')
                                ->label('Waktu Validasi')
                                ->default(now())
                                ->required()
                                ->visible(fn(Get $get) => $get('new_status') === 'validated');
                        } else {
                            $currentOptions = [];
                            if ($record->status !== 'pending') $currentOptions['pending'] = 'Kembalikan ke Pending';
                            if ($record->status !== 'validated') $currentOptions['validated'] = 'Validasi';
                            if ($record->status !== 'rejected') $currentOptions['rejected'] = 'Tolak';

                            $formFields[] = Forms\Components\Select::make('new_status')
                                ->label('Ubah Status Ke')
                                ->options($currentOptions)
                                ->required()
                                ->reactive();

                            $formFields[] = Forms\Components\DateTimePicker::make('validated_time')
                                ->label('Waktu Validasi')
                                ->default(now())
                                ->required()
                                ->visible(fn(Get $get) => $get('new_status') === 'validated');
                        }

                        return $formFields;
                    })
                    ->color(function (Jadwal $record) {
                        return match ($record->status) {
                            'pending' => 'warning',
                            'validated' => 'success',
                            'rejected' => 'danger',
                            default => 'gray'
                        };
                    })
                    ->requiresConfirmation()
                    ->modalHeading(function (Jadwal $record) {
                        return match ($record->status) {
                            'pending' => 'Review Jadwal',
                            'validated' => 'Ubah Status Validasi',
                            'rejected' => 'Ubah Status Penolakan',
                            default => 'Ubah Status'
                        };
                    })
                    ->modalDescription(function (Jadwal $record) {
                        return match ($record->status) {
                            'pending' => 'Pilih apakah jadwal ini akan divalidasi atau ditolak.',
                            'validated' => 'Jadwal ini sudah divalidasi. Anda dapat mengubah statusnya.',
                            'rejected' => 'Jadwal ini sudah ditolak. Anda dapat mengubah statusnya.',
                            default => 'Pilih status baru untuk jadwal ini.'
                        };
                    })
                    ->modalSubmitActionLabel('Simpan Perubahan')
                    // OPTION 1: Disable all notifications
                    ->successNotification(null)
                    // OPTION 2: Or override with dynamic notification
                    ->action(function (Jadwal $record, array $data) {
                        $newStatus = $data['new_status'];

                        $updateData = ['status' => $newStatus];

                        switch ($newStatus) {
                            case 'validated':
                                $updateData['validated_time'] = $data['validated_time'];
                                break;

                            case 'rejected':
                                $updateData['validated_time'] = null;
                                break;

                            case 'pending':
                                $updateData['validated_time'] = null;
                                break;
                        }

                        $record->update($updateData);

                        // Remove this custom notification if using successNotificationTitle above
                        // OR keep this if using successNotification(null)
                        $statusLabels = [
                            'validated' => 'divalidasi',
                            'rejected' => 'ditolak',
                            'pending' => 'dikembalikan ke status pending'
                        ];

                        \Filament\Notifications\Notification::make()
                            ->title('Status Berhasil Diubah')
                            ->body("Jadwal '{$record->judul}' telah {$statusLabels[$newStatus]}.")
                            ->success()
                            ->send();
                    }),
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                    ExcelExportAction::make()
                        ->label('Export Excel')
                        ->color('success')
                        ->exports([
                            ExcelExport::make()
                                ->fromTable()
                                ->only([
                                    'judul',
                                    'periode.nama',
                                    'start_date',
                                    'start_time',
                                    'end_date',
                                    'end_time',
                                    'type',
                                    'priority',
                                    'status',
                                    'location',
                                    'deskripsi',
                                    'is_active'
                                ])
                                ->withFilename(fn() => 'jadwal-' . date('Y-m-d-H-i-s') . '.xlsx')
                                ->withWriterType(\Maatwebsite\Excel\Excel::XLSX)
                        ]),
                ]),
            ])
            ->headerActions([
                ExcelExportAction::make()
                    ->label('Export Semua')
                    ->color('success')
                    ->exports([
                        ExcelExport::make()
                            ->fromTable()
                            ->only([
                                'judul',
                                'periode.nama',
                                'start_date',
                                'start_time',
                                'end_date',
                                'end_time',
                                'type',
                                'priority',
                                'status',
                                'location',
                                'deskripsi',
                                'is_active'
                            ])
                            ->withFilename(fn() => 'jadwal-lengkap-' . date('Y-m-d-H-i-s') . '.xlsx')
                            ->withWriterType(\Maatwebsite\Excel\Excel::XLSX)
                    ]),
            ])
            ->defaultSort('start_date', 'desc')
            ->poll('30s')
            ->striped()
            ->paginated([10, 25, 50, 100]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListJadwals::route('/'),
            'create' => Pages\CreateJadwal::route('/create'),
            'view' => Pages\ViewJadwal::route('/{record}'),        // ADD THIS LINE
            'edit' => Pages\EditJadwal::route('/{record}/edit'),
        ];
    }

    public static function getNavigationBadge(): ?string
    {
        return static::getModel()::where('is_active', true)
            ->where('status', 'validated')
            ->whereDate('start_date', '>=', today())
            ->count();
    }

    public static function getNavigationBadgeColor(): ?string
    {
        return 'info';
    }
}
