<?php

namespace App\Exceptions;

use Exception;

class HealthHazardException extends Exception
{
    protected $ingredient;

    public function __construct($ingredient)
    {
        $this->ingredient = $ingredient;
        parent::__construct("Health Hazard: This meal contains '{$ingredient}', which is hazardous based on the child's health profile.");
    }

    public function getIngredient()
    {
        return $this->ingredient;
    }
}
