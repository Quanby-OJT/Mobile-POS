import 'package:http/http.dart' as http;
import 'dart:convert';

class UserService {
  ///
  ///NOTE: 
  static const String baseUrl = "http://10.0.2.2:3000/connection/";
  //static const String baseUrl = "http://localhost:3000/connection/";

  static Future<Map<String, dynamic>> loginAuthentication(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login-authentication'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      // Log response details for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Check if the response is JSON
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        final data = jsonDecode(response.body);

        if (response.statusCode == 400) {
          // Handle error message from the server
          return {"error": (data['message'])};
        } else if (response.statusCode == 200) {
          // Handle success and return user_id with message
          return {
            "user_id": data['user_id'],
            "message": data['message'] ?? "Login successful",
          };
        }
      } else {
        // Handle unexpected non-JSON responses
        throw Exception("Unexpected response format: ${response.body}");
      }
    } catch (e) {
      // Handle errors gracefully
      print("Error occurred: $e");
      throw Exception("Failed to authenticate. Please try again.");
    }

    // Fallback for unknown errors
    throw Exception("An unknown error occurred.");
  }

  static Future<dynamic> otpAuthentication(String otp, String userId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/otp-authentication'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"otp": otp, "user_id": userId}),
      );

      // Log response details for debugging
      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // Check if the response is JSON
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        final data = jsonDecode(response.body);
        print("Retrieved Data ${ data.toString()}" );

        if (response.statusCode == 400 || response.statusCode == 500) {
          return {"error": data['error']};
        } else if (response.statusCode == 200) {
          return data;
        }
      } else {
        throw Exception("Unexpected response format: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
      throw Exception("Failed to authenticate OTP. Please try again.");
    }

    return "An unknown error occurred.";
  }

  static Future<Map<String, dynamic>> userSession(String userId, String token) async {
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/user-session'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({ "user_id": userId}),
      );


      if (response.headers['content-type']?.contains('application/json') ?? false) {
        final data = jsonDecode(response.body);
        print(data.toString());

        if (response.statusCode == 400 || response.statusCode == 500) {
          return {"error": data['message']};
        } else if (response.statusCode == 200) {
          return {"message": data['message']};
        }
      } else {
        throw Exception("Unexpected response format: ${response.body}");
      }

      return {
        "error": "An Unexpected Error Occurred. Please contact the Administrator for more info."
      };

    }catch(e){
      print("Error: ${e}");
      throw Exception("Failed to generate session. Please try again.");
    }
  }
}
