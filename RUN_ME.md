# Zaad Demo - Run Guide 🚀

Follow these steps to run the "Zaad" demo and verify the Health Guard logic.

## 1. Backend Setup (Laravel)

Navigate to the `backend` folder and run these commands:

```bash
cd backend

# Initialize environment (if not done)
cp .env.example .env
php artisan key:generate

# Refresh database & run the Demo Seeder
# This creates Ali (Peanut allergy) and the demo parent user.
php artisan migrate:fresh --seed --seeder=ZaadDemoSeeder

# Start the Laravel Development Server
php artisan serve
```

## 2. Frontend Setup (Flutter)

Navigate to the `mobile` folder and run the app:

```bash
cd mobile

# Install Flutter dependencies
flutter pub get

# Run the app (ensure an emulator or device is connected)
flutter run
```

## 3. كيفية التحقق من "حارس الصحة" (Health Guard)

1. افتح التطبيق وانقر على **"Demo Login"** (سيدخل تلقائياً ببريد `parent@zaad.com`).
2. انقر على **"عرض منيو المدرسة"**.
3. اختر وجبة **"Peanut Butter Cookie"**.
4. **النتيجة:** سيهتز التطبيق، وتتحول الشاشة للون **الأحمر الداكن**، مع ظهور تحذير صحي!
5. اختر وجبة **"Cheese Sandwich"**.
6. **النتيجة:** سيتم الطلب بشكل طبيعي لأنها آمنة.

---
*تم التطوير بواسطة: مريم أكرم علي الأنسي & إيمان فؤاد محمد الجلال*
*مشروع تخرج - جامعة سبأ*
