import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import 'package:flutter/material.dart';

class UserService {
  static const String baseUrl = "http://10.0.2.2:3000/api/users";

  // Fetch all users
  /*
  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/all-users'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception("Failed to fetch users");
    }
  }

  // Add new user
  static Future<void> addUser(String name, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-user'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"name": name, "email": email}),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add user: ${response.body}");
    }
  }
   */

  static Future<String> loginAuthentication(String email, String password) async {

    final response = await http.post(
      Uri.parse('$baseUrl/login-authentication'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password})
    );
    final data = jsonDecode(response.body);

    if(response.statusCode == 400){
      throw Exception(data['message']);
    }else if(response.statusCode == 200) {
      return data['message'];
    }
    return "An Error Occured.";
  }

  static Future<String> otpAuthentication(String otp) async {
    final response = await http.post(
        Uri.parse('$baseUrl/login-authentication'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"otp": otp})
    );
    final data = jsonDecode(response.body);

    if(response.statusCode == 400){
      throw Exception(data['message']);
    }else if(response.statusCode == 200) {
      return data['message'];
    }
    return "An Error Occured.";
  }
}
