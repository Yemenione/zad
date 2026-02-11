<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Child;
use App\Models\HealthInfo;
use App\Models\Meal;
use Illuminate\Support\Facades\Hash;

class ZaadDemoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // 1. User: Parent
        $parent = User::create([
            'name' => 'Demo Parent',
            'email' => 'parent@zaad.com',
            'password' => Hash::make('password123'),
            'role' => 'parent',
        ]);

        // 1.1 User: Admin
        User::create([
            'name' => 'School Admin',
            'email' => 'admin@zaad.com',
            'password' => Hash::make('admin123'),
            'role' => 'admin',
        ]);

        // 2. Child: Ali
        $child = Child::create([
            'parent_id' => $parent->id,
            'name' => 'Ali',
        ]);

        // 3. Health Info: Peanut Allergy
        HealthInfo::create([
            'child_id' => $child->id,
            'allergies' => ['Peanuts'],
            'forbidden_ingredients' => [],
            'chronic_diseases' => 'None',
        ]);

        // 3.1 Child: Youssef (No allergies)
        $child2 = Child::create([
            'parent_id' => $parent->id,
            'name' => 'Youssef',
        ]);

        HealthInfo::create([
            'child_id' => $child2->id,
            'allergies' => [],
            'forbidden_ingredients' => [],
            'chronic_diseases' => 'None',
        ]);

        // 4. Meals
        // Meal A (Safe)
        Meal::create([
            'name' => 'Cheese Sandwich',
            'price' => 5.00,
            'ingredients' => ['Cheese', 'Bread'],
            'is_active' => true,
        ]);

        // Meal B (Danger)
        Meal::create([
            'name' => 'Peanut Butter Cookie',
            'price' => 2.50,
            'ingredients' => ['Peanuts', 'Flour'],
            'is_active' => true,
        ]);
    }
}
