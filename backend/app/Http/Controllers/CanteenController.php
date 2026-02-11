<?php

namespace App\Http\Controllers;

use App\Models\Order;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Notification;
use App\Notifications\MealServedNotification;

class CanteenController extends Controller
{
    /**
     * Mark an order as served (e.g., after scanning child's QR code).
     *
     * @param Request $request
     * @param Order $order
     * @return \Illuminate\Http\JsonResponse
     */
    public function serve(Request $request, Order $order)
    {
        // Simple QR verification simulation (expecting a token match)
        $qrToken = $request->input('qr_token');
        
        if ($order->qr_token !== $qrToken) {
            return response()->json(['message' => 'Invalid QR Token'], 403);
        }

        if ($order->status === 'served') {
            return response()->json(['message' => 'Order already served'], 400);
        }

        $order->update(['status' => 'served']);

        // Notify Parent
        $parent = $order->child->parent;
        // Mock notification for now (Academic Demo)
        // In real app: $parent->notify(new MealServedNotification($order));
        
        return response()->json([
            'message' => 'Meal served successfully!',
            'child_name' => $order->child->name,
            'meal_name' => $order->meal->name,
            'notification_sent' => true
        ]);
    }
}
