<?php

namespace App\Filament\Resources\ReviewIndikatorResource\Pages;

use Filament\Actions;
use Illuminate\Support\Facades\Auth;
use Filament\Resources\Components\Tab;
use Filament\Resources\Pages\ListRecords;
use Illuminate\Database\Eloquent\Builder;
use App\Filament\Resources\ReviewIndikatorResource;

class ListReviewIndikators extends ListRecords
{
    protected static string $resource = ReviewIndikatorResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\Action::make('refresh')
                ->label('Refresh')
                ->icon('heroicon-o-arrow-path')
                ->action(fn() => $this->resetTable()),

            Actions\Action::make('show_legend')
                ->label('Keterangan')
                ->icon('heroicon-o-question-mark-circle')
                ->color('info')
                ->modalContent(view('filament.pages.review-legend'))
                ->modalSubmitAction(false)
                ->modalCancelActionLabel('Tutup'),
        ];
    }

    public function getTabs(): array
    {
        $user = Auth::user();

        $tabs = [
            'all' => Tab::make('Semua Review')
                ->badge(function () {
                    return ReviewIndikatorResource::getEloquentQuery()->count();
                }),

            'my_reviews' => Tab::make('Review Saya')
                ->modifyQueryUsing(function (Builder $query) use ($user) {
                    return $query->whereHas('assignAuditors', function ($q) use ($user) {
                        $q->where('auditor1', $user->id)
                            ->orWhere('auditor2', $user->id);
                    });
                })
                ->badge(function () use ($user) {
                    return ReviewIndikatorResource::getEloquentQuery()
                        ->whereHas('assignAuditors', function ($q) use ($user) {
                            $q->where('auditor1', $user->id)
                                ->orWhere('auditor2', $user->id);
                        })->count();
                }),

            'pending_my_review' => Tab::make('Menunggu Review Saya')
                ->modifyQueryUsing(function (Builder $query) use ($user) {
                    return $query->whereHas('assignAuditors', function ($q) use ($user) {
                        $q->where('auditor1', $user->id)
                            ->orWhere('auditor2', $user->id);
                    });
                })
                ->badge(function () use ($user) {
                    $count = 0;
                    $assignments = ReviewIndikatorResource::getEloquentQuery()
                        ->whereHas('assignAuditors', function ($q) use ($user) {
                            $q->where('auditor1', $user->id)
                                ->orWhere('auditor2', $user->id);
                        })->get();

                    foreach ($assignments as $assignment) {
                        $hasIncompleteReview = false;
                        $isAuditor1 = $assignment->assignAuditors->auditor1 == $user->id;
                        $isAuditor2 = $assignment->assignAuditors->auditor2 == $user->id;

                        foreach ($assignment->pengisianIndikators as $pengisian) {
                            if ($isAuditor1) {
                                $review = $pengisian->reviewAuditor1;
                                if (!$review || $review->status !== 'reviewed') {
                                    $hasIncompleteReview = true;
                                    break;
                                }
                            } elseif ($isAuditor2) {
                                $review = $pengisian->reviewAuditor2;
                                if (!$review || $review->status !== 'reviewed') {
                                    $hasIncompleteReview = true;
                                    break;
                                }
                            }
                        }

                        if ($hasIncompleteReview) {
                            $count++;
                        }
                    }
                    return $count;
                })
                ->badgeColor('warning'),

                'both_auditors_completed' => Tab::make('Kedua Auditor Selesai')
                ->modifyQueryUsing(function (Builder $query) use ($user) {
                    return $query->whereHas('assignAuditors', function ($q) use ($user) {
                        $q->where('auditor1', $user->id)
                            ->orWhere('auditor2', $user->id);
                    });
                })
                ->badge(function () use ($user) {
                    $count = 0;
                    $assignments = ReviewIndikatorResource::getEloquentQuery()
                        ->whereHas('assignAuditors', function ($q) use ($user) {
                            $q->where('auditor1', $user->id)
                                ->orWhere('auditor2', $user->id);
                        })->get();

                    foreach ($assignments as $assignment) {
                        $auditor1Complete = true;
                        $auditor2Complete = true;

                        foreach ($assignment->pengisianIndikators as $pengisian) {
                            // Check auditor 1
                            $review1 = $pengisian->reviewAuditor1;
                            if (!$review1 || $review1->status !== 'reviewed') {
                                $auditor1Complete = false;
                            }

                            // Check auditor 2
                            $review2 = $pengisian->reviewAuditor2;
                            if (!$review2 || $review2->status !== 'reviewed') {
                                $auditor2Complete = false;
                            }
                        }

                        if ($auditor1Complete && $auditor2Complete) {
                            $count++;
                        }
                    }
                    return $count;
                })
                ->badgeColor('success'),

            'has_conflicts' => Tab::make('Ada Konflik')
                ->modifyQueryUsing(function (Builder $query) use ($user) {
                    return $query->whereHas('assignAuditors', function ($q) use ($user) {
                        $q->where('auditor1', $user->id)
                            ->orWhere('auditor2', $user->id);
                    })->whereHas('pengisianIndikators', function ($q) {
                        $q->whereHas('reviewAuditor1', function ($subQ) {
                            $subQ->where('status', 'reviewed');
                        })->whereHas('reviewAuditor2', function ($subQ) {
                            $subQ->where('status', 'reviewed');
                        });
                    });
                })
                ->badge(function () use ($user) {
                    $count = 0;
                    $assignments = ReviewIndikatorResource::getEloquentQuery()
                        ->whereHas('assignAuditors', function ($q) use ($user) {
                            $q->where('auditor1', $user->id)
                                ->orWhere('auditor2', $user->id);
                        })->get();

                    foreach ($assignments as $assignment) {
                        $hasConflict = false;

                        foreach ($assignment->pengisianIndikators as $pengisian) {
                            if ($pengisian->hasConflict()) {
                                $hasConflict = true;
                                break;
                            }
                        }

                        if ($hasConflict) {
                            $count++;
                        }
                    }
                    return $count;
                })
                ->badgeColor('danger'),

            'deadline_soon' => Tab::make('Deadline Dekat')
                ->modifyQueryUsing(function (Builder $query) use ($user) {
                    return $query->whereHas('assignAuditors', function ($q) use ($user) {
                        $q->where('auditor1', $user->id)
                            ->orWhere('auditor2', $user->id);
                    })->where('end_date', '<=', now()->addDays(3))
                        ->where('end_date', '>=', now());
                })
                ->badge(function () use ($user) {
                    return ReviewIndikatorResource::getEloquentQuery()
                        ->whereHas('assignAuditors', function ($q) use ($user) {
                            $q->where('auditor1', $user->id)
                                ->orWhere('auditor2', $user->id);
                        })
                        ->where('end_date', '<=', now()->addDays(3))
                        ->where('end_date', '>=', now())
                        ->count();
                })
                ->badgeColor('danger'),
        ];

        if ($user->unit_id !== null) {
            $tabs['by_unit'] = Tab::make('Per Unit')
                ->modifyQueryUsing(function (Builder $query) use ($user) {
                    return $query->whereHas('assignAuditors', function ($q) use ($user) {
                        $q->where('auditor1', $user->id)
                            ->orWhere('auditor2', $user->id);
                    })->whereHas('unitIndikator.unit', function ($q) use ($user) {
                        $q->where('id', $user->unit_id);
                    });
                })
                ->badge(function () use ($user) {
                    return ReviewIndikatorResource::getEloquentQuery()
                        ->whereHas('assignAuditors', function ($q) use ($user) {
                            $q->where('auditor1', $user->id)
                                ->orWhere('auditor2', $user->id);
                        })
                        ->whereHas('unitIndikator.unit', function ($q) use ($user) {
                            $q->where('id', $user->unit_id);
                        })->count();
                });
        }

        return $tabs;
    }
}
