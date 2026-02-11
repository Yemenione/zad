<?php

/**
 * Zaad System - Graduation Project
 * Developed by: Mariam Akram & Iman Fouad
 * Supervised by: Dr. Mohanad Al-Mashreqi
 * University of Saba - 2025/2026
 */

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Child;
use App\Models\Meal;
use App\Services\HealthSafetyService;
use App\Exceptions\HealthHazardException;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class OrderController extends Controller
{
    protected $healthSafetyService;

    public function __construct(HealthSafetyService $healthSafetyService)
    {
        $this->healthSafetyService = $healthSafetyService;
    }

    /**
     * Store a new meal order for a child.
     */
    public function store(Request $request)
    {
        $request->validate([
            'child_id' => 'required|exists:children,id',
            'meal_id' => 'required|exists:meals,id',
        ]);

        $child = Child::with('healthInfo')->findOrFail($request->child_id);
        $meal = Meal::findOrFail($request->meal_id);

        try {
            // Step 2: Health Guard Logic
            $this->healthSafetyService->validateMeal($child, $meal);
        } catch (HealthHazardException $e) {
            return response()->json([
                'error' => 'Health Hazard Detected',
                'message' => $e->getMessage(),
                'ingredient' => $e->getIngredient()
            ], 403);
        }

        // Step 3: Payment Simulation
        $paymentToken = $request->input('payment_token', 'demo_token');
        $paymentService = new \App\Services\PaymentService();
        
        $isPaid = $paymentService->simulatePayment($paymentToken, $meal->price);

        // Create the order if safe
        $order = Order::create([
            'child_id' => $child->id,
            'meal_id' => $meal->id,
            'status' => $isPaid ? 'paid' : 'pending',
            'qr_token' => Str::upper(Str::random(10)),
            'payment_token' => $paymentToken,
        ]);

        return response()->json([
            'message' => $isPaid ? 'Order placed and paid successfully' : 'Order placed, awaiting payment',
            'order' => $order,
            'payment_status' => $isPaid ? 'success' : 'pending'
        ], 201);
    }
}
