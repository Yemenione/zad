import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      'title': 'Zaad - School Meal Guard',
      'setup_profile': 'Setup Child Profile',
      'browse_menu': 'Browse School Menu',
      'demo_login': 'Demo Login',
      'auto_fill': 'Auto-filled: parent@zaad.com',
      'health_hazard': 'Health Hazard Detected!',
      'order_success': 'Order placed successfully!',
      'back': 'Back',
      'save': 'Save',
    },
    'ar': {
      'title': 'زاد - حارس وجبات المدرسة',
      'setup_profile': 'إعداد ملف الطفل',
      'browse_menu': 'تصفح قائمة الطعام',
      'demo_login': 'تسجيل دخول تجريبي',
      'auto_fill': 'تعبئة تلقائية: parent@zaad.com',
      'health_hazard': 'تم اكتشاف خطر صحي!',
      'order_success': 'تم تقديم الطلب بنجاح!',
      'back': 'رجوع',
      'save': 'حفظ',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]![key] ?? key;
  }

  bool get isRtl => locale.languageCode == 'ar';
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      Future.value(AppLocalizations(locale));

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
