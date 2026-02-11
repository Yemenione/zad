<?php

namespace App\Filament\Widgets;

use App\Models\Order;
use App\Models\Meal;
use App\Models\Child;
use Filament\Widgets\StatsOverviewWidget as BaseWidget;
use Filament\Widgets\StatsOverviewWidget\Stat;

class StatsOverview extends BaseWidget
{
    protected function getStats(): array
    {
        return [
            Stat::make('Total Revenue', '$' . Order::where('status', '!=', 'pending')->with('meal')->get()->sum(function($order) {
                return $order->meal->price;
            }))
                ->description('Total sales from paid/served meals')
                ->descriptionIcon('heroicon-m-banknotes')
                ->color('success'),
            Stat::make('Pending Orders', Order::where('status', 'pending')->count())
                ->description('Orders awaiting payment or service')
                ->descriptionIcon('heroicon-m-clock')
                ->color('warning'),
            Stat::make('Active Meals', Meal::where('is_active', true)->count())
                ->description('Meals available in the canteen')
                ->descriptionIcon('heroicon-m-shopping-bag')
                ->color('info'),
        ];
    }
}
