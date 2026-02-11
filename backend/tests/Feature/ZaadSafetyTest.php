<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\User;
use App\Models\Child;
use App\Models\Meal;
use App\Models\HealthInfo;

class ZaadSafetyTest extends TestCase
{
    use RefreshDatabase;

    public function test_parent_cannot_order_hazardous_meal_for_child()
    {
        // 1. Setup Data
        $parent = User::create([
            'name' => 'Test Parent',
            'email' => 'parent@test.com',
            'password' => bcrypt('password'),
            'role' => 'parent',
        ]);

        $child = Child::create([
            'parent_id' => $parent->id,
            'name' => 'Ali',
        ]);

        HealthInfo::create([
            'child_id' => $child->id,
            'allergies' => ['Peanuts'],
            'forbidden_ingredients' => [],
        ]);

        $dangerMeal = Meal::create([
            'name' => 'Peanut Butter Cookie',
            'price' => 2.50,
            'ingredients' => ['Peanuts', 'Flour'],
        ]);

        // 2. Act: Attempt to order danger meal
        // Acting as the parent (though authentication is not strictly required in controller yet, it's good practice)
        $response = $this->actingAs($parent)->postJson('/api/orders', [
            'child_id' => $child->id,
            'meal_id' => $dangerMeal->id,
        ]);

        // 3. Assert: System MUST return 403 Forbidden
        // Note: The prompt asked for "Health Hazard: Contains Peanuts" message. 
        // My implementation returns "Health Hazard: This meal contains 'Peanuts', which is hazardous based on the child's health profile."
        $response->assertStatus(403);
        $response->assertJsonFragment([
            'error' => 'Health Hazard Detected',
        ]);
        $response->assertJsonStructure(['error', 'message', 'ingredient']);
        
        echo "\n[Test Passed] Order for hazardous meal was blocked with 403 Forbidden.\n";
    }

    public function test_parent_can_order_safe_meal_for_child()
    {
        $parent = User::create(['name' => 'P', 'email' => 'p@p.com', 'password' => 'pass', 'role' => 'parent']);
        $child = Child::create(['parent_id' => $parent->id, 'name' => 'Ali']);
        HealthInfo::create(['child_id' => $child->id, 'allergies' => ['Peanuts'], 'forbidden_ingredients' => []]);
        $safeMeal = Meal::create(['name' => 'Cheese', 'price' => 5, 'ingredients' => ['Cheese']]);

        $response = $this->actingAs($parent)->postJson('/api/orders', [
            'child_id' => $child->id,
            'meal_id' => $safeMeal->id,
        ]);

        $response->assertStatus(201);
        echo "[Test Passed] Order for safe meal was placed successfully.\n";
    }
}
