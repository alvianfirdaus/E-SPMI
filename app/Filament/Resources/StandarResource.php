<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use App\Models\Standar;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use App\Forms\Components\YearPicker;
use Illuminate\Support\Facades\Auth;
use Filament\Tables\Enums\FiltersLayout;
use Filament\Tables\Filters\SelectFilter;
use App\Filament\Resources\StandarResource\Pages;
use Malzariey\FilamentDaterangepickerFilter\Filters\DateRangeFilter;

class StandarResource extends Resource
{
    protected static ?string $model = Standar::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationGroup = 'Manjemen Standar';
    protected static ?string $navigationLabel = 'Standar';
    protected static ?int $navigationSort = 1;


    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Informasi Standar')
                    ->icon('heroicon-m-information-circle')
                    ->description('Informasi terkait Standar')
                    ->schema([

                        Forms\Components\TextInput::make('kode_standar')
                            ->required()
                            ->maxLength(255),
                        Forms\Components\TextInput::make('nama_standar')
                            ->required()
                            ->maxLength(255),
                        YearPicker::make('tahun')
                            ->required()
                            ->reactive()


                    ])
                    ->columns(1),
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
                Tables\Columns\TextColumn::make('kode_standar')
                    ->label('Kode Standar')
                    ->searchable(),
                Tables\Columns\TextColumn::make('nama_standar')
                    ->label('Nama Standar')
                    ->searchable()
                    ->wrap(),
                Tables\Columns\TextColumn::make('tahun')
                    ->searchable()
                    ->sortable(),
                Tables\Columns\TextColumn::make('status')
                    ->badge()
                    ->sortable()
                    ->colors([
                        'success' => 'validated',
                        'warning' => 'pending',
                    ]),

                Tables\Columns\TextColumn::make('creator.name')
                    ->label('Pembuat')
                    ->icon('heroicon-m-user')
                    ->searchable(isIndividual: true)
                    ->toggleable()
                    ->toggledHiddenByDefault(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Dibuat pada')
                    ->dateTime()
                    ->toggleable()
                    ->icon('heroicon-m-calendar')
                    ->toggledHiddenByDefault(),
                Tables\Columns\TextColumn::make('validator.name')
                    ->label('Validator')
                    ->icon('heroicon-m-user')
                    ->searchable(isIndividual: true)
                    ->toggleable()
                    ->toggledHiddenByDefault(),

                Tables\Columns\TextColumn::make('validated_time')
                    ->label('Waktu Validasi')
                    ->dateTime()
                    ->icon('heroicon-m-calendar')

                    ->toggleable()
                    ->toggledHiddenByDefault(),
                Tables\Columns\TextColumn::make('updated_at')
            ])
            ->defaultSort('created_at', 'desc')
            ->filters([
                SelectFilter::make('tahun')
                    ->label('Tahun')
                    ->searchable(),
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
                    ->label('Validation Date'),
            ], layout: FiltersLayout::AboveContentCollapsible)
            ->actions([
                Tables\Actions\Action::make('toggleValidation')
                    ->visible(function (Standar $record): bool {
                        return in_array($record->status, ['pending', 'validated']) &&
                            (
                                $record->validated_by === Auth::id() ||
                                Auth::user()?->hasRole('super_admin')
                            );
                    })
                    ->icon(
                        fn(Standar $record) => $record->status === 'pending'
                            ? 'heroicon-m-check-circle'
                            : 'heroicon-m-arrow-uturn-left'
                    )
                    ->label(function (Standar $record) {
                        return $record->status === 'pending' ? 'Validasi?' : 'Tandai sebagai Pending?';
                    })
                    ->form([
                        Forms\Components\DateTimePicker::make('validated_time')
                            ->default(now())
                            ->required()
                            ->visible(fn(Standar $record) => $record->status === 'pending'),
                    ])
                    ->color(fn(Standar $record) => $record->status === 'pending' ? 'success' : 'warning')
                    ->requiresConfirmation()
                    ->modalHeading(
                        fn(Standar $record) =>
                        $record->status === 'pending' ? 'Apakah Anda yakin akan memvalidasi ini?' : 'Apakah Anda yakin untuk mengembalikan status ke Pending?'
                    )
                    ->modalDescription(
                        fn(Standar $record) =>
                        $record->status === 'pending'
                            ? 'Once validated, this point will be marked as verified.'
                            : 'The validated point will be returned to Pending status.'
                    )
                    ->action(function (Standar $record, array $data) {
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
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
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
            'index'  => Pages\ListStandars::route('/'),
            'create' => Pages\CreateStandar::route('/create'),
            'view'   => Pages\ViewStandar::route('/{record}'),
            'edit'   => Pages\EditStandar::route('/{record}/edit'),
        ];
    }
}
