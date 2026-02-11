import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../services/api_service.dart';
import '../l10n.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ApiService _api = ApiService();
  bool _isHazard = false;
  String _hazardMessage = "";

  // Arabic mock data for demo
  final List<Map<String, dynamic>> _mockMeals = [
    {
      "id": 1,
      "name": "شطيرة زبدة الفول السوداني",
      "price": "18.50",
      "ingredients": ["فول سوداني", "خبز", "زبدة"],
      "image_icon": Icons.bakery_dining_rounded,
      "is_safe": false,
    },
    {
      "id": 2,
      "name": "شوربة العدس التقليدية",
      "price": "12.00",
      "ingredients": ["عدس", "ماء", "ملح", "بصل"],
      "image_icon": Icons.soup_kitchen_rounded,
      "is_safe": true,
    },
    {
      "id": 3,
      "name": "باستا مع صلصة الحليب",
      "price": "22.50",
      "ingredients": ["باستا", "حليب", "جبن", "ثوم"],
      "image_icon": Icons.dinner_dining_rounded,
      "is_safe": true,
    },
    {
      "id": 4,
      "name": "سلطة خضراء طازجة",
      "price": "15.00",
      "ingredients": ["خيار", "طماطم", "خس", "ليمون"],
      "image_icon": Icons.eco_rounded,
      "is_safe": true,
    },
  ];

  void _handleOrder(Map<String, dynamic> meal) async {
    bool containsPeanuts = (meal['ingredients'] as List).any(
      (e) => e.contains("سوداني"),
    );

    if (containsPeanuts) {
      _triggerVibeCheck("!تحذير: هذه الوجبة تحتوي على الفول السوداني");
    } else {
      setState(() {
        _isHazard = false;
        _hazardMessage = "";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Text("جاري طلب ${meal['name']}..."),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }

  void _triggerVibeCheck(String msg) async {
    setState(() {
      _isHazard = true;
      _hazardMessage = msg;
    });

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 600, amplitude: 255);
    }

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _isHazard = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: _isHazard
          ? const Color(0xFF2B0B0B)
          : theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.translate('browse_menu')),
        backgroundColor: _isHazard ? Colors.red.shade900 : Colors.transparent,
        foregroundColor: _isHazard ? Colors.white : theme.colorScheme.primary,
        elevation: 0,
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isHazard ? 80 : 0,
            width: double.infinity,
            color: Colors.red.shade800,
            child: Center(
              child: Text(
                _hazardMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _mockMeals.length,
              itemBuilder: (context, index) {
                final meal = _mockMeals[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildMealCard(meal, theme),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(Map<String, dynamic> meal, ThemeData theme) {
    return InkWell(
      onTap: () => _handleOrder(meal),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: _isHazard ? Colors.red.shade50.withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.2),
                      theme.colorScheme.secondary.withOpacity(0.2),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  meal['image_icon'],
                  size: 40,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal['name'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _isHazard
                            ? Colors.white
                            : theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${(meal['ingredients'] as List).join(' • ')}",
                      style: TextStyle(
                        fontSize: 13,
                        color: _isHazard
                            ? Colors.white70
                            : Colors.grey.shade600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "ر.س ${meal['price']}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.add_circle_outline_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
