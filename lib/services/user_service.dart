import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos/views/otp_page.dart';
import 'package:mobile_pos/views/login_page.dart';

class UserService {
  static const String baseUrl = "http://localhost:3000/api/users";

  // Fetch all users
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


  static Future<void> loginAuthentication(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-authentication'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password})
    );

    if(response.statusCode == 400){
      throw Exception(response.body);
    }
  }

  // Add user account with full details
  static Future<void> addAccount(
      String firstname, String lastname, String email, String password, String role) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-account'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "role": role
      }),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add account: ${response.body}");
    }
  }
  
}
