# Zaad Backend - School Meal Management System

This is the core API for the Zaad project, built with Laravel.

## Prerequisites

- PHP 8.2+
- Composer
- MySQL/SQLite

## Setup Instructions

1. **Clone the repository** (if you haven't already):

   ```bash
   git clone https://github.com/Yemenione/zad.git
   ```

2. **Navigate to the backend directory**:

   ```bash
   cd backend
   ```

3. **Install dependencies**:

   ```bash
   php composer.phar install
   ```

   *(Note: Use your global composer if available)*

4. **Environment Configuration**:

   ```bash
   cp .env.example .env
   php artisan key:generate
   ```

5. **Database Setup**:
   Configure your database credentials in the `.env` file.

6. **Run Migrations**:

   ```bash
   php artisan migrate
   ```

## Database Schema

- `users`: Standard users with `role` (parent, canteen, admin).
- `children`: Linked to parents.
- `health_info`: Stores allergies and chronic diseases (JSON).
- `meals`: Menu items with ingredients (JSON).
- `orders`: Tracks meal orders and QR codes.

## Relationships

- `User` has many `Child`.
- `Child` has one `HealthInfo`.
- `Child` has many `Order`.
- `Meal` has many `Order`.
