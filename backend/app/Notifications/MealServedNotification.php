<?php

namespace App\Notifications;

use App\Models\Order;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class MealServedNotification extends Notification
{
    use Queueable;

    protected $order;

    public function __construct(Order $order)
    {
        $this->order = $order;
    }

    public function via($notifiable)
    {
        return ['database', 'mail'];
    }

    public function toMail($notifiable)
    {
        return (new MailMessage)
                    ->subject('Zadd - Meal Served!')
                    ->line('Your child ' . $this->order->child->name . ' has just been served their meal: ' . $this->order->meal->name)
                    ->line('Thank you for using Zaad for your child\'s nutrition safety.');
    }

    public function toArray($notifiable)
    {
        return [
            'order_id' => $this->order->id,
            'child_name' => $this->order->child->name,
            'meal_name' => $this->order->meal->name,
            'message' => 'Meal served to ' . $this->order->child->name,
        ];
    }
}
