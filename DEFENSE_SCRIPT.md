# Zaad Graduation Project - Defense Script 🎓

Use this script to demonstrate the core value of the **Zaad** system during your presentation.

## Scene 1: The School Manager (Admin Panel)

**Objective:** Show how the school manages meals and safety data.

1. **Login** to the Admin Panel at `/admin` as `admin@zaad.com`.
2. **Navigate** to "Meals".
3. **Show** the ingredients list for "Peanut Butter Cookie". Point out that it contains **"Peanuts"** (the trigger).
4. **Create** a new meal: "Apple Slices". Show how easy it is to add ingredients.

## Scene 2: The Parent & The "Health Guard" (Mobile App)

**Objective:** Proof that the system prevents dangerous orders.

1. **Open** the Mobile App and login as `parent@zaad.com`.
2. **Select** the child "Youssef".
3. **Navigate** to "Browse Menu".
4. **Try to order** the "Peanut Butter Cookie".
5. **EXPECTED RESULT:** The screen turns deep red, a vibration occurs, and a message appears saying: **"يحتوي هذا الطعام على الفول السوداني - ممنوع!"** (Hazard Detected!).
6. **Explain:** "The system automatically matches the child's allergy profile with the meal's ingredients in real-time."

## Scene 3: Secure Ordering (The Success Flow)

**Objective:** Show a safe transaction.

1. **Select** "Lentil Soup" or "Apple Slices".
2. **Click** "Place Order".
3. **EXPECTED RESULT:** Success message and a **QR Code** is generated.
4. **Explain:** "This QR code contains the secure token for the canteen to verify the meal was paid and is safe."

## Scene 4: The Canteen Staff (The Final Step)

**Objective:** Closing the loop.

1. **Explain** (or simulate) the scanning: "The canteen staff scans this QR code at the counter."
2. **Trigger** the 'Served' status (can be shown in the Admin Panel or via an API call).
3. **Show Notification:** The parent receives a mobile alert: **"تم استلام وجبة يوسف الآن!"** (Youssef received his meal!).

---
**Summary for Jury:** "We have successfully combined real-time safety logic, secure QR authentication, and a complete management dashboard to solve the problem of canteen food safety."
