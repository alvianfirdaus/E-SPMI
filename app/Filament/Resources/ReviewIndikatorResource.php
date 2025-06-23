<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\AssignPengisian;
use Filament\Resources\Resource;
use App\Exports\AuditResultExport;
use App\Exports\ReviewAuditExport;
use Filament\Tables\Actions\Action;
use Filament\Support\Enums\MaxWidth;
use Illuminate\Support\Facades\Auth;
use Maatwebsite\Excel\Facades\Excel;
use Filament\Tables\Columns\TextColumn;
use Illuminate\Database\Eloquent\Builder;
use App\Filament\Resources\ReviewIndikatorResource\Pages;

class ReviewIndikatorResource extends Resource
{
    protected static ?string $model = AssignPengisian::class;

    protected static ?string $navigationIcon = 'heroicon-o-clipboard-document-check';
    protected static ?string $navigationGroup = 'Audit';
    protected static ?string $navigationLabel = 'Review Audit';
    public static ?string $label = 'Review Audit';
    public static ?string $pluralLabel = 'Review Audit';
    protected static ?string $slug = 'review-audit';
    protected static ?string $breadcrumb = 'Review Audit';
    protected static ?int $navigationSort = 3;

    public static function form(Form $form): Form
    {
        return $form->schema([]);
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

                Tables\Columns\TextColumn::make('unitIndikator.auditeeUser.name')
                    ->label('Auditee')
                    ->searchable(),

                Tables\Columns\TextColumn::make('assignAuditors.auditor1Relation.name')
                    ->label('Auditor 1')
                    ->searchable(),

                Tables\Columns\TextColumn::make('assignAuditors.auditor2Relation.name')
                    ->label('Auditor 2')
                    ->searchable(),

                Tables\Columns\TextColumn::make('end_date')
                    ->label('Deadline')
                    ->dateTime('d M Y')
                    ->sortable()
                    ->color(fn($record) => now()->gt($record->end_date) ? 'danger' : 'success'),

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

                Tables\Columns\TextColumn::make('review auditor 1')
                    ->label('Status Auditor 1')
                    ->getStateUsing(function ($record) {

                        $totalPengisian = $record->pengisianIndikators->count();
                        if ($totalPengisian === 0) return '0/0';

                        $auditor1review = 0;
                        foreach ($record->pengisianIndikators as $pengisian) {
                            $review = $pengisian->reviewAuditor1;
                            if ($review && $review->status === 'reviewed') {
                                $auditor1review++;
                            }
                        }

                        return "{$auditor1review}/{$totalPengisian}";
                    })
                    ->badge()
                    ->color(function ($record) {
                        $totalPengisian = $record->pengisianIndikators->count();
                        if ($totalPengisian === 0) return '0/0';

                        $auditor1review = 0;
                        foreach ($record->pengisianIndikators as $pengisian) {
                            $review = $pengisian->reviewAuditor1;
                            if ($review && $review->status === 'reviewed') {
                                $auditor1review++;
                            }
                        }

                        $percentage = ($auditor1review / $totalPengisian) * 100;

                        return match (true) {
                            $percentage == 100 => 'success',
                            $percentage >= 50 => 'warning',
                            $percentage > 0 => 'info',
                            default => 'gray',
                        };
                    }),

                Tables\Columns\TextColumn::make('other_review_status')
                    ->label('Status Auditor 2')
                    ->getStateUsing(function ($record) {
                        $totalPengisian = $record->pengisianIndikators->count();
                        if ($totalPengisian === 0) return '0/0';

                        $auditor2review = 0;
                        foreach ($record->pengisianIndikators as $pengisian) {
                            $review = $pengisian->reviewAuditor2;
                            if ($review && $review->status === 'reviewed') {
                                $auditor2review++;
                            }
                        }
                        return "{$auditor2review}/{$totalPengisian}";
                    })
                    ->badge()
                    ->color(function ($record) {
                        $totalPengisian = $record->pengisianIndikators->count();
                        if ($totalPengisian === 0) return '0/0';

                        $auditor2review = 0;
                        foreach ($record->pengisianIndikators as $pengisian) {
                            $review = $pengisian->reviewAuditor2;
                            if ($review && $review->status === 'reviewed') {
                                $auditor2review++;
                            }
                        }

                        $percentage = ($auditor2review / $totalPengisian) * 100;

                        return match (true) {
                            $percentage == 100 => 'success',
                            $percentage >= 50 => 'warning',
                            $percentage > 0 => 'info',
                            default => 'gray',
                        };
                    }),

                // Updated conflict logic
                Tables\Columns\TextColumn::make('conflicts_count')
                    ->label('Konflik')
                    ->getStateUsing(function ($record) {
                        $conflicts = 0;
                        foreach ($record->pengisianIndikators as $pengisian) {
                            $review1 = $pengisian->reviewAuditor1;
                            $review2 = $pengisian->reviewAuditor2;

                            // Check if both auditors have reviewed
                            if (
                                $review1 && $review1->status === 'reviewed' &&
                                $review2 && $review2->status === 'reviewed'
                            ) {

                                // Check if status_temuan is different
                                if ($review1->status_temuan !== $review2->status_temuan) {
                                    $conflicts++;
                                }
                            }
                        }
                        return $conflicts > 0 ? $conflicts : '0';
                    })
                    ->badge()
                    ->color(fn($state) => $state > 0 ? 'danger' : 'success'),

                // New Status column
                Tables\Columns\TextColumn::make('audit_status')
                    ->label('Status')
                    ->getStateUsing(function ($record) {
                        $hasIncomplete = false;
                        $hasNotSesuai = false;

                        foreach ($record->pengisianIndikators as $pengisian) {
                            $review1 = $pengisian->reviewAuditor1;
                            $review2 = $pengisian->reviewAuditor2;

                            // Check if any review is incomplete
                            if (
                                !$review1 || $review1->status !== 'reviewed' ||
                                !$review2 || $review2->status !== 'reviewed'
                            ) {
                                $hasIncomplete = true;
                                break;
                            }

                            // Check if any review has "tidak_sesuai"
                            if (
                                $review1->status_temuan === 'tidak_sesuai' ||
                                $review2->status_temuan === 'tidak_sesuai'
                            ) {
                                $hasNotSesuai = true;
                            }
                        }

                        // Return OPEN if incomplete reviews or any "tidak_sesuai" found
                        return ($hasIncomplete || $hasNotSesuai) ? 'OPEN' : 'CLOSE';
                    })
                    ->badge()
                    ->color(fn($state) => $state === 'OPEN' ? 'danger' : 'success'),

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
                        'selesai' => 'Selesai',
                        'menunggu_review' => 'Menunggu Review',
                        'revisi' => 'Perlu Revisi',
                    ]),

                Tables\Filters\Filter::make('my_audits')
                    ->label('Audit Saya')
                    ->query(function (Builder $query): Builder {
                        $user = Auth::user();
                        return $query->whereHas('assignAuditors', function ($q) use ($user) {
                            $q->where('auditor1', $user->id)
                                ->orWhere('auditor2', $user->id);
                        });
                    }),
                    
                Tables\Filters\Filter::make('ready_to_review')
                    ->label('Siap Review')
                    ->query(
                        fn(Builder $query): Builder =>
                        $query->where('status_pengisian', 'selesai')
                    ),

                // New status filter
                Tables\Filters\SelectFilter::make('audit_status')
                    ->label('Status Audit')
                    ->options([
                        'open' => 'Open',
                        'close' => 'Close',
                    ])
                    ->query(function (Builder $query, array $data): Builder {
                        if (!isset($data['value'])) {
                            return $query;
                        }

                        $status = $data['value'];

                        if ($status === 'open') {
                            return $query->where(function ($q) {
                                $q->whereHas('pengisianIndikators', function ($subQ) {
                                    // Has incomplete reviews
                                    $subQ->where(function ($innerQ) {
                                        $innerQ->whereDoesntHave('reviewAuditor1', function ($r1) {
                                            $r1->where('status', 'reviewed');
                                        })->orWhereDoesntHave('reviewAuditor2', function ($r2) {
                                            $r2->where('status', 'reviewed');
                                        });
                                    })->orWhere(function ($innerQ) {
                                        // Has "tidak_sesuai" status
                                        $innerQ->whereHas('reviewAuditor1', function ($r1) {
                                            $r1->where('status_temuan', 'tidak_sesuai');
                                        })->orWhereHas('reviewAuditor2', function ($r2) {
                                            $r2->where('status_temuan', 'tidak_sesuai');
                                        });
                                    });
                                });
                            });
                        } else if ($status === 'close') {
                            return $query->whereDoesntHave('pengisianIndikators', function ($subQ) {
                                $subQ->where(function ($innerQ) {
                                    // No incomplete reviews
                                    $innerQ->whereDoesntHave('reviewAuditor1', function ($r1) {
                                        $r1->where('status', 'reviewed');
                                    })->orWhereDoesntHave('reviewAuditor2', function ($r2) {
                                        $r2->where('status', 'reviewed');
                                    });
                                })->orWhere(function ($innerQ) {
                                    // No "tidak_sesuai" status
                                    $innerQ->whereHas('reviewAuditor1', function ($r1) {
                                        $r1->where('status_temuan', 'tidak_sesuai');
                                    })->orWhereHas('reviewAuditor2', function ($r2) {
                                        $r2->where('status_temuan', 'tidak_sesuai');
                                    });
                                });
                            });
                        }

                        return $query;
                    }),
            ])
            ->actions([
                Action::make('view_result')
                    ->label('Lihat Hasil')
                    ->icon('heroicon-o-eye')
                    ->color('info')
                    ->visible(function ($record) {
                        $user = Auth::user();
                        $hasAccess = false;


                        $allowedRoles = ['super_admin', 'p2mpp', 'pimpinan', 'auditor', 'auditee'];
                        if ($user->hasAnyRole($allowedRoles)) {
                            $hasAccess = true;
                        }

                        return $hasAccess && $record->status_pengisian == 'selesai';
                    })
                    ->url(fn($record) => ReviewIndikatorResource::getUrl('vieww', ['assignmentId' => $record->id])),

                Action::make('review_auditor1')
                    ->label('Review (Auditor 1)')
                    ->icon('heroicon-o-clipboard-document-check')
                    ->color('primary')
                    ->visible(function ($record) {
                        $user = Auth::user();
                        return (
                            $record->assignAuditors &&
                            (
                                $record->assignAuditors->auditor1 == $user->id ||
                                $user->hasRole('super_admin')
                            ) &&
                            $record->status_pengisian == 'selesai' &&
                            $record->is_active
                        );
                    })
                    ->url(fn($record) => ReviewIndikatorResource::getUrl('auditor1', ['assignmentId' => $record->id])),

                Action::make('review_auditor2')
                    ->label('Review (Auditor 2)')
                    ->icon('heroicon-o-clipboard-document-check')
                    ->color('success')
                    ->visible(function ($record) {
                        $user = Auth::user();
                        return (
                            $record->assignAuditors &&
                            (
                                $record->assignAuditors->auditor2 == $user->id ||
                                $user->hasRole('super_admin')
                            ) &&
                            $record->status_pengisian == 'selesai' &&
                            $record->is_active
                        );
                    })
                    ->url(fn($record) => ReviewIndikatorResource::getUrl('auditor2', ['assignmentId' => $record->id])),

                // Updated conflict modal
                Action::make('view_conflicts')
                    ->label('Lihat Konflik')
                    ->icon('heroicon-o-exclamation-triangle')
                    ->color('warning')
                    ->visible(function ($record) {
                        $conflicts = 0;
                        foreach ($record->pengisianIndikators as $pengisian) {
                            $review1 = $pengisian->reviewAuditor1;
                            $review2 = $pengisian->reviewAuditor2;

                            if (
                                $review1 && $review1->status === 'reviewed' &&
                                $review2 && $review2->status === 'reviewed'
                            ) {

                                if ($review1->status_temuan !== $review2->status_temuan) {
                                    $conflicts++;
                                }
                            }
                        }
                        return $conflicts > 0;
                    })
                    ->modalContent(function ($record) {
                        $conflictItems = [];
                        foreach ($record->pengisianIndikators as $pengisian) {
                            $review1 = $pengisian->reviewAuditor1;
                            $review2 = $pengisian->reviewAuditor2;

                            if (
                                $review1 && $review1->status === 'reviewed' &&
                                $review2 && $review2->status === 'reviewed'
                            ) {

                                if ($review1->status_temuan !== $review2->status_temuan) {
                                    $conflictItems[] = [
                                        'item' => $pengisian->unitIndikatorIsiIndikator->isiIndikator->isi_indikator ?? 'Unknown Item',
                                        'auditor1_temuan' => $review1->status_temuan ?? 'Belum review',
                                        'auditor2_temuan' => $review2->status_temuan ?? 'Belum review',
                                    ];
                                }
                            }
                        }

                        $content = '<div class="space-y-4">';
                        $content .= '<h3 class="text-lg font-semibold text-red-800 mb-4">Konflik Status Temuan</h3>';
                        foreach ($conflictItems as $item) {
                            $content .= '<div class="border border-red-200 rounded-lg p-4 bg-red-50">';
                            $content .= '<h4 class="font-medium text-red-800 mb-2">Item Konflik:</h4>';
                            $content .= '<p class="text-sm text-gray-700 mb-2">' . e($item['item']) . '</p>';
                            $content .= '<div class="grid grid-cols-2 gap-4 text-sm">';
                            $content .= '<div><strong>Auditor 1:</strong> <span class="px-2 py-1 rounded text-xs ' .
                                ($item['auditor1_temuan'] === 'sesuai' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800') . '">' .
                                ucfirst(str_replace('_', ' ', $item['auditor1_temuan'])) . '</span></div>';
                            $content .= '<div><strong>Auditor 2:</strong> <span class="px-2 py-1 rounded text-xs ' .
                                ($item['auditor2_temuan'] === 'sesuai' ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800') . '">' .
                                ucfirst(str_replace('_', ' ', $item['auditor2_temuan'])) . '</span></div>';
                            $content .= '</div></div>';
                        }
                        $content .= '</div>';

                        return new \Illuminate\Support\HtmlString($content);
                    })
                    ->modalWidth(MaxWidth::ThreeExtraLarge),
                Action::make('export')
                    ->label('Export')
                    ->icon('heroicon-o-arrow-down-tray')
                    ->action(function ($record) {
                        return Excel::download(
                            new AuditResultExport($record),
                            'isi-standar-' . $record->id . '.xlsx'
                        );
                    })

            ])
            ->bulkActions([])
            ->defaultSort('end_date', 'asc')
            ->poll('30s');
    }

    public static function getEloquentQuery(): Builder
    {
        return parent::getEloquentQuery()
            ->with([
                'unitIndikator.unit',
                'unitIndikator.auditeeUser',
                'periode',
                'assignAuditors.auditor1Relation',
                'assignAuditors.auditor2Relation',
                'pengisianIndikators.reviewAuditor1',
                'pengisianIndikators.reviewAuditor2',
                'pengisianIndikators.unitIndikatorIsiIndikator.isiIndikator',
            ])
            ->where('is_active', true)
            ->where('status', 'validated')
            ->where('status_pengisian', 'selesai');
    }

    public static function canCreate(): bool
    {
        return false;
    }
    public static function getPages(): array
    {
        return [
            'index' => Pages\ListReviewIndikators::route('/'),
            'vieww' => Pages\ViewAuditResult::route('/view/{assignmentId}'),
            'auditor1' => Pages\ReviewAudit1::route('/auditor1/{assignmentId}'),
            'auditor2' => Pages\ReviewAudit2::route('/auditor2/{assignmentId}'),
        ];
    }

    public static function getNavigationBadge(): ?string
    {
        $user = Auth::user();

        return static::getEloquentQuery()
            ->whereHas('assignAuditors', function ($query) use ($user) {
                $query->where('auditor1', $user->id)
                    ->orWhere('auditor2', $user->id);
            })
            ->where('status_pengisian', 'selesai')
            ->count();
    }

    public static function getNavigationBadgeColor(): ?string
    {
        return 'info';
    }
}
