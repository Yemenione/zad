<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\AuthController;
use App\Models\Meal;
use App\Http\Controllers\CanteenController;

// Public Auth Route
Route::post('/login', [AuthController::class, 'login']);

// Protected Routes
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::get('/meals', function () {
        return Meal::all();
    });

    Route::post('/orders', [OrderController::class, 'store']);
    
    // Canteen Staff Routes
    Route::post('/canteen/serve/{order}', [CanteenController::class, 'serve']);
});
