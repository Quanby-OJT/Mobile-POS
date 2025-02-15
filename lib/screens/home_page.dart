import 'package:flutter/material.dart';
import '../screens/manager/main.dart';
import '../screens/admin/main.dart';
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
  List<AuthenticatedUser> users = [];

  // Fetch users
  /*
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
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Quanby's State-of-the-Art Mobile Point-of-Sale Application")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
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
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminMainPage()));
                          },
                          child: Text(
                            'Admin Dashboard',
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0)),
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          },
                          child: Text(
                            'Manage Dashboard',
                            style: TextStyle(color: Colors.black),
                          )),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  //return ListTile(
                  //  title: Text(user.name),
                  //  subtitle: Text(user.email),
                   // leading: Icon(Icons.person),
                  //);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
