<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AuthTest extends TestCase
{
    use RefreshDatabase;

    public function test_user_can_login_with_valid_credentials()
    {
        $user = User::create([
            'name' => 'Demo Parent',
            'email' => 'parent@zaad.com',
            'password' => Hash::make('password123'),
        ]);

        $response = $this->postJson('/api/login', [
            'email' => 'parent@zaad.com',
            'password' => 'password123',
            'device_name' => 'test_device',
        ]);

        $response->assertStatus(200)
                 ->assertJsonStructure(['token', 'user']);
    }

    public function test_user_cannot_login_with_invalid_credentials()
    {
        User::create([
            'name' => 'Demo Parent',
            'email' => 'parent@zaad.com',
            'password' => Hash::make('password123'),
        ]);

        $response = $this->postJson('/api/login', [
            'email' => 'parent@zaad.com',
            'password' => 'wrong_password',
            'device_name' => 'test_device',
        ]);

        $response->assertStatus(422);
    }
}
