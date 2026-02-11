# Zaad Project - Installation Guide 🛠️

Follow these steps to set up the Zaad system on your local machine for evaluation.

## 1. Prerequisites

- **PHP 8.2+** (XAMPP recommended)
- **Composer** (Included in the backend folder as `composer.phar`)
- **Node.js & NPM** (For frontend assets if needed, though primarily an API)
- **MySQL** (Managed via XAMPP)
- **Flutter SDK** (For the mobile application)

---

## 2. Backend Setup (Laravel)

1. **Navigate to the backend directory:**

    ```bash
    cd backend
    ```

2. **Environment Configuration:**
    - Copy `.env.example` to `.env`.
    - Configure `DB_DATABASE`, `DB_USERNAME`, and `DB_PASSWORD` to match your local MySQL setup.
3. **Install Dependencies:**

    ```bash
    php composer.phar install
    ```

4. **Application Key:**

    ```bash
    php artisan key:generate
    ```

5. **Migrations & Seeding:**
    - Create the database in MySQL first.
    - Run the specialized demo seeder:

    ```bash
    php artisan migrate:fresh --seed --seeder=ZaadDemoSeeder
    ```

6. **Run the Server:**

    ```bash
    php artisan serve --port=8000
    ```

---

## 3. Mobile App Setup (Flutter)

1. **Navigate to the mobile directory:**

    ```bash
    cd mobile
    ```

2. **Install Dependencies:**

    ```bash
    flutter pub get
    ```

3. **API Configuration:**
    - Check `lib/services/api_service.dart`.
    - Ensure `baseUrl` matches your server's IP (e.g., `http://127.0.0.1:8000/api`).
4. **Run the App:**

    ```bash
    flutter run -d chrome # For web demo
    # OR
    flutter run # For emulator/real device
    ```

---

## 4. Default Credentials (Demo)

| Role | Email | Password |
| :--- | :--- | :--- |
| **Admin (Web)** | `admin@zaad.com` | `admin123` |
| **Parent (Mobile)** | `parent@zaad.com` | `password123` |

---
**Note:** For the best experience, run the backend on port 8000 and the flutter web app on port 8080.
