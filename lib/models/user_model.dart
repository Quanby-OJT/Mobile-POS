import 'dart:ui';

class AuthenticatedUser {
  final String email;
  final String roles;
  final Image image;

  AuthenticatedUser({required this.email, required this.roles, required this.image});

  // Convert JSON to User object
  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    return AuthenticatedUser(
      roles: json['role'],
      email: json['email'],
      image: json['image_link']
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      "role": roles,
      "email": email,
      "image_link": image
    };
  }
}
