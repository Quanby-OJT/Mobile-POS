import 'package:flutter/material.dart';
import '../models/user_model.dart'; // Import User model

class UserList extends StatelessWidget {
  final List<User> users; // Gamitin ang User model

  const UserList({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.name), // Gumamit ng User model properties
          subtitle: Text(user.email),
          leading: Icon(Icons.person),
        );
      },
    );
  }
}
