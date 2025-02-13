import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class UserService {
  static const String baseUrl = "http://10.0.2.2:3000/api/users";
  //static const String baseUrl = "http://localhost:3000/api/users";

  static Future<Map<String, dynamic>> loginAuthentication(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-authentication'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 400) {
      // Throw an error for unsuccessful login
      throw Exception(data['message']);
    } else if (response.statusCode == 200) {
      // Return user_id and success message as a map
      return {
        "user_id": data['user_id'],
        "message": data['message'] ?? "Login successful"
      };
    }

    // Handle unexpected cases
    throw Exception("An unknown error occurred.");
  }

  static Future<void> loginAuthentication(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/login-authentication'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}));

    if (response.statusCode == 400) {
      throw Exception(response.body);
    }
    return "An Error Occured.";
  }
}
