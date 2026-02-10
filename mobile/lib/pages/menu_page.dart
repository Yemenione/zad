import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../services/api_service.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final ApiService _api = ApiService();
  bool _isHazard = false;
  String _hazardMessage = "";

  // Mock data for demo since backend might not be reachable
  final List<Map<String, dynamic>> _mockMeals = [
    {
      "id": 1,
      "name": "Peanut Butter Sandwich",
      "price": "5.00",
      "ingredients": ["Peanuts", "Bread", "Butter"],
    },
    {
      "id": 2,
      "name": "Lentil Soup",
      "price": "4.50",
      "ingredients": ["Lentils", "Water", "Salt", "Onion"],
    },
    {
      "id": 3,
      "name": "Milk Pasta",
      "price": "6.00",
      "ingredients": ["Pasta", "Milk", "Cheese", "Garlic"],
    },
  ];

  void _handleOrder(Map<String, dynamic> meal) async {
    // Simulating Health Guard Check (PR #2 logic)
    // In a real app, this calls the API. For PR #3 vibe check:
    bool containsPeanuts = (meal['ingredients'] as List).contains("Peanuts");

    if (containsPeanuts) {
      _triggerVibeCheck(
        "CONTAINS PEANUTS! This meal is hazardous to your child.",
      );
    } else {
      setState(() {
        _isHazard = false;
        _hazardMessage = "";
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Ordering ${meal['name']}...")));
    }
  }

  void _triggerVibeCheck(String msg) async {
    setState(() {
      _isHazard = true;
      _hazardMessage = msg;
    });

    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500, amplitude: 255);
    }

    // Auto-reset after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isHazard = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isHazard ? Colors.red.shade900 : Colors.white,
      appBar: AppBar(
        title: Text("School Menu"),
        backgroundColor: _isHazard ? Colors.red : Colors.blue,
      ),
      body: Column(
        children: [
          if (_isHazard)
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.red,
              width: double.infinity,
              child: Text(
                _hazardMessage,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: _mockMeals.length,
              itemBuilder: (context, index) {
                final meal = _mockMeals[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  color: _isHazard ? Colors.red.shade100 : Colors.white,
                  child: ListTile(
                    title: Text(
                      meal['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Ingredients: ${(meal['ingredients'] as List).join(', ')}",
                    ),
                    trailing: Text(
                      "\$${meal['price']}",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () => _handleOrder(meal),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
