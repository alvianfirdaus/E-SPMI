<?php

namespace App\Providers;

use Filament\Facades\Filament;
use Filament\View\PanelsRenderHook;
use Filament\Actions\MountableAction;
use Filament\Support\Enums\Alignment;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\ServiceProvider;
use Filament\Support\Facades\FilamentView;
use Filament\Pages\Page;
use pxlrbt\FilamentExcel\FilamentExcelServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->register(FilamentExcelServiceProvider::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        // Register hook to inject Livewire component 'periode-switcher' before user menu
        FilamentView::registerRenderHook(
            PanelsRenderHook::USER_MENU_BEFORE,
            fn(): string => Blade::render('@livewire("periode-switcher")')
        );

        // Register hook to inject your navbar date-time Livewire component after global search
        Filament::serving(function () {
            Filament::registerRenderHook(
                PanelsRenderHook::TOPBAR_START,
                fn(): string => Blade::render('<div class="hidden md:block">@livewire("navbar-date-time")</div>')
            );
        });
        Page::formActionsAlignment(Alignment::Right);

        MountableAction::configureUsing(function (MountableAction $action) {
            $action->modalFooterActionsAlignment(Alignment::Right);
        });
    }
}
