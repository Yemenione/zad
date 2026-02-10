<?php

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
            ], 422);
        }

        // Create the order if safe
        $order = Order::create([
            'child_id' => $child->id,
            'meal_id' => $meal->id,
            'status' => 'pending',
            'qr_hash' => Str::random(32),
        ]);

        return response()->json([
            'message' => 'Order placed successfully',
            'order' => $order
        ], 201);
    }
}
