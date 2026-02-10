import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api"; // Default local dev URL

  Future<List<dynamic>> getMeals() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/meals"));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<Map<String, dynamic>> placeOrder(int childId, int mealId) async {
    final response = await http.post(
      Uri.parse("$baseUrl/orders"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "child_id": childId,
        "meal_id": mealId,
      }),
    );

    return {
      "statusCode": response.statusCode,
      "data": json.decode(response.body)
    };
  }
}
