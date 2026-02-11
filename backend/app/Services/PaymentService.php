<?php

namespace App\Services;

class PaymentService
{
    /**
     * Simulate a payment transaction.
     *
     * @param string $token
     * @param float $amount
     * @return bool
     */
    public function simulatePayment(string $token, float $amount): bool
    {
        // For the demo/graduation project, any token ending in 'VALID' is successful
        // Real-world would integrate with Stripe/PayPal API
        return str_ends_with($token, 'VALID') || $token === 'demo_token';
    }
}
