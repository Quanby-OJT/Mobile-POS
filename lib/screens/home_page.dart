import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../models/user_model.dart';
import '../screens/login/signin.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  String message = "";
  List<User> users = [];

  // Fetch users
  void loadUsers() async {
    try {
      List<User> fetchedUsers = await UserService.fetchUsers();
      setState(() {
        users = fetchedUsers;
      });
    } catch (e) {
      setState(() {
        message = "Error: $e";
      });
    }
  }

  // Add user
  void addUser() async {
    if (nameController.text.isEmpty || emailController.text.isEmpty) {
      setState(() {
        message = "Please fill in all fields!";
      });
      return;
    }

    try {
      await UserService.addUser(nameController.text, emailController.text);
      setState(() {
        message = "User added successfully!";
      });
      loadUsers();
    } catch (e) {
      setState(() {
        message = "Error: $e";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mobile Application")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name")),
            TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: addUser, child: Text("Submit")),
            SizedBox(height: 20),
            Text(message, style: TextStyle(color: Colors.red)),
            Column(
              children: [
                Text("Users"),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignInPage())),
                  child: Text("Sign In"),
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    leading: Icon(Icons.person),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
