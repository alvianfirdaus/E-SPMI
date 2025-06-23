<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\AssignPengisian;
use Filament\Resources\Resource;
use App\Models\PengisianIndikator;
use Filament\Forms\Components\Grid;
use Filament\Tables\Actions\Action;
use Illuminate\Support\Facades\Auth;
use Filament\Forms\Components\Toggle;
use Filament\Forms\Components\Textarea;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\TextInput;
use Illuminate\Database\Eloquent\Builder;
use Filament\Forms\Components\DateTimePicker;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\PengisianIndikatorResource\Pages;
use App\Filament\Resources\PengisianIndikatorResource\RelationManagers;
use Filament\Support\Enums\MaxWidth;

class PengisianIndikatorResource extends Resource
{
    protected static ?string $model = AssignPengisian::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Audit';
    protected static ?string $navigationLabel = 'Pengisian Audit';
    public static ?string $label = 'Pengisian Audit';
    public static ?string $pluralLabel = 'Pengisian Audit';
    protected static ?string $slug = 'pengisian-audit';
    protected static ?string $breadcrumb = 'Pengisian Audit';
    protected static ?int $navigationSort = 2;

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Assignment')
                    ->schema([
                        Forms\Components\Hidden::make('assign_pengisian_id')
                            ->default(fn() => request()->get('assign_pengisian_id')),

                        Forms\Components\Placeholder::make('assignment_info')
                            ->label('Detail Assignment')
                            ->content(function (callable $get) {
                                $assignId = $get('assign_pengisian_id') ?? request()->get('assign_pengisian_id');
                                if (!$assignId) return 'Pilih assignment terlebih dahulu';

                                $assignment = \App\Models\AssignPengisian::with([
                                    'unitIndikator.unit',
                                    'periode',
                                    'assignAuditors.auditor1Relation',
                                    'assignAuditors.auditor2Relation'
                                ])->find($assignId);

                                if (!$assignment) return 'Assignment tidak ditemukan';

                                $auditor1 = $assignment->assignAuditors?->auditor1Relation?->name ?? '-';
                                $auditor2 = $assignment->assignAuditors?->auditor2Relation?->name ?? '-';

                                return "
                                <div class='space-y-2'>
                                    <div><strong>Unit:</strong> {$assignment->unitIndikator->unit->nama_unit}</div>
                                    <div><strong>Indikator:</strong> {$assignment->unitIndikator->nama_indikator}</div>
                                    <div><strong>Periode:</strong> {$assignment->periode->periode_name}</div>
                                    <div><strong>Auditor 1:</strong> {$auditor1}</div>
                                    <div><strong>Auditor 2:</strong> {$auditor2}</div>
                                </div>
                            ";
                            })
                            ->columnSpanFull(),
                    ])
                    ->collapsible()
                    ->collapsed(false),

                Forms\Components\Section::make('Pengisian Indikator')
                    ->schema([
                        Forms\Components\Select::make('standar_id')
                            ->label('Pilih Standar')
                            ->options(function (callable $get) {
                                $assignId = $get('assign_pengisian_id') ?? request()->get('assign_pengisian_id');
                                if (!$assignId) return [];

                                $assignment = \App\Models\AssignPengisian::with([
                                    'unitIndikator.unitIndikatorStandars.standar'
                                ])->find($assignId);

                                if (!$assignment) return [];

                                return $assignment->unitIndikator->unitIndikatorStandars
                                    ->pluck('standar.nama_standar', 'standar.id')
                                    ->toArray();
                            })
                            ->reactive()
                            ->required()
                            ->searchable(),

                        Forms\Components\TextInput::make('skor')
                            ->label('Skor')
                            ->numeric()
                            ->min(0)
                            ->max(100)
                            ->required()
                            ->suffix('%'),

                        Forms\Components\TextInput::make('link')
                            ->label('Link Bukti')
                            ->url()
                            ->placeholder('https://example.com/bukti')
                            ->columnSpanFull(),

                        Forms\Components\Textarea::make('komentar')
                            ->label('Komentar/Catatan')
                            ->rows(4)
                            ->placeholder('Tambahkan komentar atau catatan...')
                            ->columnSpanFull(),

                        Forms\Components\FileUpload::make('attachments')
                            ->label('Lampiran')
                            ->multiple()
                            ->acceptedFileTypes(['pdf', 'doc', 'docx', 'xls', 'xlsx', 'jpg', 'jpeg', 'png'])
                            ->maxSize(10240) // 10MB
                            ->directory('audit-attachments')
                            ->columnSpanFull(),

                        Forms\Components\DateTimePicker::make('answered_at')
                            ->label('Tanggal Pengisian')
                            ->default(now())
                            ->required()
                            ->native(false),
                    ])
                    ->columns(2),

                Forms\Components\Section::make('Status & Approval')
                    ->schema([
                        Forms\Components\Select::make('status')
                            ->label('Status')
                            ->options([
                                'draft' => 'Draft',
                                'submitted' => 'Submitted',
                                'reviewed' => 'Reviewed',
                                'approved' => 'Approved',
                                'rejected' => 'Rejected',
                            ])
                            ->default('draft')
                            ->required(),

                        Forms\Components\Textarea::make('review_notes')
                            ->label('Catatan Review')
                            ->rows(3)
                            ->visible(fn(callable $get) => in_array($get('status'), ['reviewed', 'rejected']))
                            ->columnSpanFull(),
                    ])
                    ->columns(2)
                    ->visible(fn() => Auth::user()->hasAnyRole(['admin', 'auditor'])),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')
                    ->label('ID Assignment')
                    ->sortable(),

                Tables\Columns\TextColumn::make('unitIndikator.unit.nama_unit')
                    ->label('Unit')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('periode.periode_name')
                    ->label('Periode')
                    ->searchable()
                    ->sortable(),

                Tables\Columns\TextColumn::make('start_date')
                    ->label('Tanggal Mulai')
                    ->dateTime('d M Y')
                    ->sortable(),

                Tables\Columns\TextColumn::make('end_date')
                    ->label('Deadline')
                    ->dateTime('d M Y')
                    ->sortable()
                    ->color(fn($record) => now()->gt($record->end_date) ? 'danger' : 'success'),

                Tables\Columns\TextColumn::make('unitIndikator.auditeeUser.name')
                    ->label('Auditee')
                    ->searchable(),

                Tables\Columns\TextColumn::make('assignAuditors.auditor1Relation.name')
                    ->label('Auditor 1')
                    ->searchable(),

                Tables\Columns\TextColumn::make('assignAuditors.auditor2Relation.name')
                    ->label('Auditor 2')
                    ->searchable(),

                Tables\Columns\TextColumn::make('status_pengisian')
                    ->label('Status Pengisian')
                    ->badge()
                    ->color(fn(string $state): string => match ($state) {
                        'belum_mulai' => 'gray',
                        'dalam_proses' => 'warning',
                        'menunggu_review' => 'info',
                        'selesai' => 'success',
                        'revisi' => 'danger',
                        default => 'gray',
                    }),
                Tables\Columns\IconColumn::make('is_active')
                    ->label('Aktif')
                    ->boolean(),
            ])
            ->filters([
                Tables\Filters\SelectFilter::make('periode')
                    ->relationship('periode', 'periode_name')
                    ->searchable(),

                Tables\Filters\SelectFilter::make('unit')
                    ->relationship('unitIndikator.unit', 'nama_unit')
                    ->searchable(),

                Tables\Filters\SelectFilter::make('status_pengisian')
                    ->options([
                        'belum_mulai' => 'Belum Mulai',
                        'dalam_proses' => 'Dalam Proses',
                        'menunggu_review' => 'Menunggu Review',
                        'selesai' => 'Selesai',
                        'revisi' => 'Perlu Revisi',
                    ]),

                Tables\Filters\Filter::make('my_assignments')
                    ->label('Tugas Saya')
                    ->query(function (Builder $query): Builder {
                        $user = Auth::user();
                        return $query->whereHas('unitIndikator', function ($q) use ($user) {
                            $q->where('auditee', $user->id);
                        });
                    })
                    ->default(),

                Tables\Filters\Filter::make('deadline_soon')
                    ->label('Deadline Dekat (3 hari)')
                    ->query(
                        fn(Builder $query): Builder =>
                        $query->where('end_date', '<=', now()->addDays(3))
                            ->where('end_date', '>=', now())
                    ),
            ])
            ->actions([
                Action::make('view_result')
                    ->label('Lihat Hasil')
                    ->icon('heroicon-o-eye')
                    ->color('info')
                    ->visible(function ($record) {
                        $user = Auth::user();
                        $hasAccess = false;

                        $allowedRoles = ['super_admin', 'pimpinan', 'p2mpp', 'auditee', 'auditor'];
                        if ($user->hasAnyRole($allowedRoles)) {
                            $hasAccess = true;
                        }

                        return $hasAccess && $record->status_pengisian == 'selesai' && $record->is_active;
                    })
                    ->url(fn($record) => ReviewIndikatorResource::getUrl('vieww', ['assignmentId' => $record->id])),
                Action::make('fill')
                    ->label('Isi Audit')
                    ->icon('heroicon-o-pencil-square')
                    ->color('primary')
                    ->visible(function ($record) {
                        $user = Auth::user();
                        $isAuditee = $record->unitIndikator->auditeeUser->id == $user->id;

                        return ($isAuditee) &&
                            $record->status_pengisian != 'selesai' &&
                            $record->is_active;
                    })
                    ->url(fn($record) => PengisianIndikatorResource::getUrl('audit', ['assignmentId' => $record->id])),
                Tables\Actions\Action::make('edit_audit')
                    ->label('Edit Audit')
                    ->icon('heroicon-o-pencil-square')
                    ->url(
                        fn($record): string =>
                        static::getUrl('edit-audit', ['assignmentId' => $record->id])
                    )
                    ->color('warning')
                    ->visible(function ($record) {
                        $user = Auth::user();
                        $isAdmin = $user?->hasRole('super_admin');
                        return $isAdmin && $record->is_active;
                    }),

                Action::make('download_report')
                    ->label('Download')
                    ->icon('heroicon-o-arrow-down-tray')
                    ->color('success')
                    ->visible(fn($record) => $record->status_pengisian == 'selesai')
                    ->action(function ($record) {
                        // Logic untuk download report
                        return response()->download(
                            storage_path("app/reports/audit-{$record->id}.pdf")
                        );
                    }),
            ])
            ->bulkActions([])
            ->defaultSort('end_date', 'asc')
            ->poll('30s'); // Auto refresh setiap 30 detik

    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with([
                'unitIndikator.unit',
                'unitIndikator.unitIndikatorStandars',
                'periode',
                'assignAuditors.auditor1Relation',
                'assignAuditors.auditor2Relation',
                'pengisianIndikators',
            ])
            ->where('is_active', true)
            ->where('status', 'validated'); // Hanya tampilkan yang sudah validated
    }

    public static function canCreate(): bool
    {
        return false; // Tidak bisa create dari sini
    }

    public static function getPages(): array
    {
        return [

            'index' => Pages\ListPengisianIndikators::route('/'),
            'edit' => Pages\EditPengisianIndikator::route('/{record}/edit'),
            'audit' => Pages\PengisianIndikatorAudit::route('/audit/{assignmentId}'),
            'edit-audit' => Pages\PengisianIndikatorAuditEdit::route('/audit/{assignmentId}/edit'), // Add this line

        ];
    }
}
