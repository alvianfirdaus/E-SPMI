<?php

namespace App\Filament\Resources;

use Filament\Forms;
use App\Models\Unit;
use App\Models\User;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use Illuminate\Support\Facades\Auth;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Enums\FiltersLayout;
use Filament\Tables\Columns\Layout\Panel;
use Filament\Tables\Columns\Layout\Split;
use Filament\Tables\Filters\SelectFilter;
use App\Filament\Resources\UnitResource\Pages;
use Malzariey\FilamentDaterangepickerFilter\Filters\DateRangeFilter;

class UnitResource extends Resource
{
    protected static ?string $model = Unit::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Manajemen Pengguna';
    protected static ?string $navigationLabel = 'Unit';
    protected static ?int $navigationSort = 3;
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Isi Standar')
                    ->schema([
                        Forms\Components\TextInput::make('kode_unit')
                            ->required()
                            ->maxLength(255)
                            ->unique(table: 'units', column: 'kode_unit', ignoreRecord: true),
                        Forms\Components\TextInput::make('nama_unit')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\Select::make('user_ids')
                            ->label('Assign Users')
                            ->multiple()
                            ->searchable()
                            ->preload()
                            ->options(fn() => User::query()
                                ->whereNull('unit_id')
                                ->orWhere('unit_id', request()->route('record'))
                                ->pluck('name', 'id')),
                    ])
                    ->columns(1),
                Forms\Components\Section::make('Validator')
                    ->description('Pilih role validator lalu user yang akan melakukan validasi.')
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
            ->columns([
                TextColumn::make('kode_unit')
                    ->label('Kode Unit')
                    ->searchable(isIndividual: true)
                    ->sortable(),

                TextColumn::make('nama_unit')
                    ->label('Nama Unit')
                    ->searchable(isIndividual: true)
                    ->wrap()
                    ->sortable(),

                TextColumn::make('users.name')
                    ->label('Pengguna')
                    ->badge()
                    ->wrap()
                    ->listWithLineBreaks(),
            ])

            ->filters([
                SelectFilter::make('status')
                    ->label('Status')
                    ->options([
                        'validated' => 'Validated',
                        'pending' => 'Pending',
                    ]),
                SelectFilter::make('created_by')
                    ->label('Dibuat Oleh')
                    ->options(
                        fn() =>
                        \App\Models\User::all()->mapWithKeys(function ($user) {
                            return [$user->id => "{$user->nip} - {$user->name}"];
                        })
                    )
                    ->searchable(),
                DateRangeFilter::make('created_at')
                    ->label('Created Date'),
                SelectFilter::make('validated_by')
                    ->label('Nama Validator')
                    ->options(
                        fn() =>
                        \App\Models\User::all()->mapWithKeys(function ($user) {
                            return [$user->id => "{$user->nip} - {$user->name}"];
                        })
                    )
                    ->searchable(),
                DateRangeFilter::make('validated_time')
                    ->label('Validated Date'),
            ], layout: FiltersLayout::AboveContentCollapsible)
            ->persistFiltersInSession() 
        ->defaultSort('created_at', 'DESC')
            ->actions([
                Tables\Actions\Action::make('toggleValidation')
                    ->visible(function (Unit $record): bool {
                        return in_array($record->status, ['pending', 'validated']) &&
                            (
                                $record->validated_by === Auth::id() ||
                                Auth::user()?->hasRole('super_admin')
                            );
                    })
                    ->icon(
                        fn(Unit $record) => $record->status === 'pending'
                            ? 'heroicon-m-check-circle'
                            : 'heroicon-m-arrow-uturn-left'
                    )
                    ->label(function (Unit $record) {
                        return $record->status === 'pending' ? 'Validate?' : 'Mark as Pending?';
                    })
                    ->form([
                        Forms\Components\DateTimePicker::make('validated_time')
                            ->default(now())
                            ->required()
                            ->visible(fn(Unit $record) => $record->status === 'pending'),
                    ])
                    ->color(fn(Unit $record) => $record->status === 'pending' ? 'success' : 'warning')
                    ->requiresConfirmation()
                    ->modalHeading(
                        fn(Unit $record) =>
                        $record->status === 'pending' ? 'Are you sure you want to validate this?' : 'Are you sure you want to mark it back as Pending?'
                    )
                    ->modalDescription(
                        fn(Unit $record) =>
                        $record->status === 'pending'
                            ? 'Once validated, this point will be marked as verified.'
                            : 'The validated point will be returned to Pending status.'
                    )
                    ->action(function (Unit $record, array $data) {
                        if ($record->status === 'pending') {
                            $record->update([
                                'validated_time' => $data['validated_time'],
                                'status' => 'validated',
                            ]);
                        } else {
                            $record->update([
                                'status' => 'pending',
                                'validated_time' => null,
                            ]);
                        }
                    }),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                    Tables\Actions\ForceDeleteBulkAction::make(),
                ]),
            ]);
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
            'index'  => Pages\ListUnits::route('/'),
            'create' => Pages\CreateUnit::route('/create'),
            // 'view' => Pages\ViewUnit::route('/{record}'),
            'edit'   => Pages\EditUnit::route('/{record}/edit'),
        ];
    }
}
