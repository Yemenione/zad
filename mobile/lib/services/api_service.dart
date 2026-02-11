import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://127.0.0.1:8000/api";
  static String? _token;

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: json.encode({
          "email": email,
          "password": password,
          "device_name": "mobile_app",
        }),
      );

      final data = json.decode(response.body);
      if (response.statusCode == 200) {
        _token = data['token'];
      }
      return {"success": response.statusCode == 200, "data": data};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  Future<List<dynamic>> getMeals() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/meals"),
        headers: {
          "Authorization": "Bearer $_token",
          "Accept": "application/json",
        },
      );
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
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $_token",
        "Accept": "application/json",
      },
      body: json.encode({"child_id": childId, "meal_id": mealId}),
    );

    return {
      "statusCode": response.statusCode,
      "data": json.decode(response.body),
    };
  }
}
