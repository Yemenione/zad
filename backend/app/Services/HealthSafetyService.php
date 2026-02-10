<?php

namespace App\Services;

use App\Models\Child;
use App\Models\Meal;
use App\Exceptions\HealthHazardException;

class HealthSafetyService
{
    /**
     * Validate if a meal is safe for a specific child.
     *
     * @param Child $child
     * @param Meal $meal
     * @throws HealthHazardException
     * @return void
     */
    public function validateMeal(Child $child, Meal $meal): void
    {
        $healthInfo = $child->healthInfo;
        
        if (!$healthInfo) {
            return;
        }

        $allergies = $healthInfo->allergies ?? [];
        $forbidden = $healthInfo->forbidden_ingredients ?? [];
        $mealIngredients = $meal->ingredients ?? [];

        // Check for allergies
        foreach ($mealIngredients as $ingredient) {
            if (in_array(strtolower($ingredient), array_map('strtolower', $allergies))) {
                throw new HealthHazardException($ingredient);
            }
        }

        // Check for forbidden ingredients
        foreach ($mealIngredients as $ingredient) {
            if (in_array(strtolower($ingredient), array_map('strtolower', $forbidden))) {
                throw new HealthHazardException($ingredient);
            }
        }
    }
}
