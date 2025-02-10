class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
    };
  }
}
