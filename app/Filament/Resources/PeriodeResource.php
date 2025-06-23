<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use App\Models\Periode;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use Illuminate\Support\Facades\Auth;
use Filament\Tables\Filters\SelectFilter;
use Illuminate\Database\Eloquent\Builder;
use App\Filament\Resources\PeriodeResource\Pages;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\PeriodeResource\RelationManagers;
use Malzariey\FilamentDaterangepickerFilter\Filters\DateRangeFilter;

class PeriodeResource extends Resource
{
    protected static ?string $model = Periode::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    protected static ?string $navigationLabel = 'Periode';

    // Add this method to control create access based on user roles
    public static function getPermissionPrefixes(): array
    {
        return [
            'view',
            'view_any',
            'create',
            'update',
            'delete',
            'delete_any'
        ];
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\Section::make('Standar')
                    ->schema([
                        Forms\Components\TextInput::make('periode_kode')
                            ->label('Kode Periode')
                            ->required()
                            ->unique(ignoreRecord: true),

                        Forms\Components\TextInput::make('periode_name')
                            ->label('Nama Periode')
                            ->required(),

                        Forms\Components\DateTimePicker::make('start_date')
                            ->label('Tanggal Mulai')
                            ->required()
                            ->native(false),

                        Forms\Components\DateTimePicker::make('end_date')
                            ->label('Tanggal Selesai')
                            ->required()
                            ->native(false)
                            ,

                        Forms\Components\Select::make('status_periode')
                            ->label('Status Periode')
                            ->options([
                                'active' => 'Aktif',
                                'inactive' => 'Tidak Aktif',
                            ])
                            ->required(),
                    ])
                    ->collapsible(),

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
            ])
            ->groupingSettingsInDropdownOnDesktop()
            ->deferLoading()
            ->columns([
                Tables\Columns\TextColumn::make('periode_kode')->label('Kode'),
                Tables\Columns\TextColumn::make('periode_name')->label('Nama'),
                Tables\Columns\TextColumn::make('start_date')->label('Mulai')->dateTime(),
                Tables\Columns\TextColumn::make('end_date')->label('Selesai')->dateTime(),
                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->color(fn($state) => $state === 'active' ? 'success' : 'warning'),
                    Tables\Columns\BadgeColumn::make('status_periode')
                ->label('Status')
                ->colors([
                    'success' => 'active',
                    'danger' => 'inactive',
                ])
                ->formatStateUsing(fn (string $state): string => ucfirst($state)),
                
                Tables\Columns\TextColumn::make('status')
                    ->label('Status')
                    ->badge()
                    ->sortable()
                    ->color(fn(string $state): string => match ($state) {
                        'validated' => 'success',
                        'pending' => 'warning',
                        default => 'gray',
                    })
                    ->icon(fn(string $state): ?string => match ($state) {
                        'validated' => 'heroicon-m-check-circle',
                        'pending' => 'heroicon-m-clock',
                        default => null,
                    }),
                Tables\Columns\TextColumn::make('creator.name')
                    ->label('Creator')
                    ->icon('heroicon-m-user')
                    ->searchable(isIndividual: true)
                    ->formatStateUsing(fn($state) => $state ? $state : '-')
                    ->toggleable()
                    ->toggledHiddenByDefault(),
                Tables\Columns\TextColumn::make('created_at')
                    ->label('Dibuat pada')
                    ->dateTime()
                    ->toggleable()
                    ->formatStateUsing(fn($state) => $state ? $state : '-')
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
                    ->label('Diperbarui pada')
                    ->dateTime()
                    ->toggleable()
                    ->icon('heroicon-m-calendar')
                    ->toggledHiddenByDefault(),
            ])
            ->defaultSort('created_at', 'desc')
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
            ])
            ->actions([
                Tables\Actions\Action::make('toggleValidation')
                    ->visible(function (Periode $record): bool {
                        return in_array($record->status, ['pending', 'validated']) &&
                            (
                                $record->validated_by === Auth::id() ||
                                Auth::user()?->hasRole('super_admin')
                            );
                    })
                    ->icon(
                        fn(Periode $record) => $record->status === 'pending'
                            ? 'heroicon-m-check-circle' // ✅ Validate
                            : 'heroicon-m-arrow-uturn-left' // 🔁 Revert to Pending
                    )->label(function (Periode $record) {
                        return $record->status === 'pending' ? 'Validate?' : 'Mark as Pending?';
                    })
                    ->form([
                        Forms\Components\DateTimePicker::make('validated_time')
                            ->default(now())
                            ->required()
                            ->visible(fn(Periode $record) => $record->status === 'pending'),
                    ])
                    ->color(fn(Periode $record) => $record->status === 'pending' ? 'success' : 'warning')
                    ->requiresConfirmation()
                    ->modalHeading(
                        fn(Periode $record) =>
                        $record->status === 'pending' ? 'Are you sure you want to validate this?' : 'Are you sure you want to mark it back as Pending?'
                    )
                    ->modalDescription(
                        fn(Periode $record) =>
                        $record->status === 'pending'
                            ? 'Once validated, this point will be marked as verified.'
                            : 'The validated point will be returned to Pending status.'
                    )
                    ->action(function (Periode $record, array $data) {
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
                    Tables\Actions\Action::make('toggle_status')
                ->label(fn ($record) => $record->status_periode === 'active' ? 'Nonaktifkan' : 'Aktifkan')
                ->icon(fn ($record) => $record->status_periode === 'active' 
                    ? 'heroicon-o-pause-circle' 
                    : 'heroicon-o-play-circle')
                ->color(fn ($record) => $record->status_periode === 'active' ? 'warning' : 'success')
                ->requiresConfirmation()
                ->modalHeading(fn ($record) => $record->status_periode === 'active' 
                    ? 'Nonaktifkan Periode' 
                    : 'Aktifkan Periode')
                ->modalDescription(fn ($record) => $record->status_periode === 'active'
                    ? "Yakin ingin menonaktifkan periode '{$record->periode_name}'?"
                    : "Mengaktifkan periode '{$record->periode_name}' akan menonaktifkan semua periode lain. Lanjutkan?")
                ->modalSubmitActionLabel(fn ($record) => $record->status_periode === 'active' ? 'Nonaktifkan' : 'Aktifkan')
                ->action(function ($record) {
                    if ($record->status_periode === 'active') {
                        $record->update(['status_periode' => 'inactive']);
                        
                        \Filament\Notifications\Notification::make()
                            ->title('Periode Dinonaktifkan')
                            ->body("Periode '{$record->periode_name}' telah dinonaktifkan.")
                            ->warning()
                            ->send();
                    } else {
                        // Deactivate all other periodes first
                        \App\Models\Periode::where('id', '!=', $record->id)
                            ->update(['status_periode' => 'inactive']);
                        
                        // Activate this periode
                        $record->update(['status_periode' => 'active']);
                        
                        \Filament\Notifications\Notification::make()
                            ->title('Periode Diaktifkan')
                            ->body("Periode '{$record->periode_name}' sekarang aktif.")
                            ->success()
                            ->send();
                    }
                }),
                Tables\Actions\ViewAction::make(),
                Tables\Actions\DeleteAction::make(),
                Tables\Actions\EditAction::make(),

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
            'index' => Pages\ListPeriodes::route('/'),
            'create' => Pages\CreatePeriode::route('/create'),
            'view'   => Pages\ViewPeriode::route('/{record}'),
            'edit' => Pages\EditPeriode::route('/{record}/edit'),
        ];
    }
}
