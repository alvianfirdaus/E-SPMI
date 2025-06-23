<?php

namespace App\Filament\Resources;

use Filament\Forms;
use App\Models\Unit;
use App\Models\User;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Resources\Resource;
use Filament\Tables\Actions\Action;
use Filament\Forms\Components\Select;
use Illuminate\Support\Facades\Storage;
use Filament\Forms\Components\FileUpload;
use Filament\Tables\Filters\SelectFilter;
use App\Filament\Resources\UserResource\Pages;
use STS\FilamentImpersonate\Tables\Actions\Impersonate;

class UserResource extends Resource
{
    protected static ?string $model = User::class;

    protected static ?string $navigationIcon = 'heroicon-o-users';
    protected static ?string $navigationGroup = 'Manajemen Pengguna';
    protected static ?string $navigationLabel = 'Pengguna';
    protected static ?int $navigationSort = 2;
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('nip')
                    ->required()
                    ->maxLength(255)
                    ->extraAttributes([
                        'inputmode' => 'numeric',
                        'pattern' => '[0-9]*',
                    ])
                    ->rule('regex:/^[0-9]+$/')
                    ->unique(table: 'users', column: 'nip', ignoreRecord: true)
                    ->label('NIP'),
                Forms\Components\TextInput::make('name')
                    ->required()
                    ->maxLength(255),
                Forms\Components\TextInput::make('email')
                    ->email()
                    ->required()
                    ->maxLength(255),
                Forms\Components\Select::make('unit_id')
                    ->label('Pilih Unit')
                    ->options(
                        Unit::all()->mapWithKeys(fn($unit) => [
                            $unit->id => "{$unit->kode_unit} - {$unit->nama_unit}"
                        ])
                    )
                    ->searchable()
                    ->preload()
                    ->required(),
                Forms\Components\DateTimePicker::make('email_verified_at'),
                Forms\Components\TextInput::make('password')
                    ->password()
                    ->maxLength(255)
                    ->dehydrateStateUsing(fn($state) => filled($state) ? bcrypt($state) : null)
                    ->nullable()
                    ->required(fn($record) => $record === null)
                    ->dehydrated(fn($state) => filled($state)),

                FileUpload::make('avatar_url')
                    ->image()
                    ->avatar()
                    ->disk('profile-photos')
                    ->maxSize(2024)
                    ->columnSpanFull()
                    ->dehydrated(fn($state) => filled($state))
                    ->deleteUploadedFileUsing(
                        fn($record) => $record->avatar_url
                            ? Storage::disk('profile-photos')->delete($record->avatar_url)
                            : null
                    )
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([

                Tables\Columns\TextColumn::make('nip')->label('NIP')
                    ->searchable(),
                Tables\Columns\TextColumn::make('name')
                    ->searchable(),
                Tables\Columns\TextColumn::make('email')
                    ->searchable(),
                Tables\Columns\TextColumn::make('unit.kode_unit')
                    ->label('Unit')
                    ->searchable(),
                Tables\Columns\TextColumn::make('roles.name')
                    ->searchable()
                    ->icon('heroicon-o-shield-check')
                    ->grow(false),
                Tables\Columns\ImageColumn::make('avatar_url')
                    ->searchable()
                    ->circular()
                    ->grow(false)
                    ->getStateUsing(fn($record) => $record->avatar_url && Storage::disk('profile-photos')->exists($record->avatar_url)
                        ? asset("storage/profile-photos/{$record->avatar_url}")
                        : "https://ui-avatars.com/api/?name=" . urlencode($record->name)),
                Tables\Columns\TextColumn::make('email_verified_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('created_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),
                Tables\Columns\TextColumn::make('updated_at')
                    ->dateTime()
                    ->sortable()
                    ->toggleable(isToggledHiddenByDefault: true),

            ])
            ->filters([
                SelectFilter::make('roles')
                    ->relationship('roles', 'name')
                    ->multiple()
                    ->preload(),
            ])
            ->actions([
                Impersonate::make(),
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Action::make('Set Role')
                    ->icon('heroicon-m-adjustments-vertical')
                    ->form([
                        Select::make('role')
                            ->relationship('roles', 'name')
                            ->preload()->multiple()
                            ->required(),
                    ]),
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
            'index' => Pages\ListUsers::route('/'),
            'create' => Pages\CreateUser::route('/create'),
            'edit' => Pages\EditUser::route('/{record}/edit'),
        ];
    }
}
