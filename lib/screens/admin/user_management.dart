// import 'package:flutter/material.dart';
// import 'package:mobile_pos/services/user_service.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class UserManagement extends StatefulWidget {
//   const UserManagement({super.key});

//   @override
//   State<UserManagement> createState() => _UserManagementState();
// }

// class _UserManagementState extends State<UserManagement> {
//   @override
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   String _selectedRole = 'Cashier';
//   String message = '';
//   void addAccount() async {

//     try {
//       await UserService.addAccount(_firstNameController.text, _lastNameController.text, _emailController.text, _passwordController.text, _selectedRole);
//       setState(() {
//         message = "User added successfully!";
//       });
      
//     } catch (e) {
//       setState(() {
//         message = "Error: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('User Management')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     controller: _firstNameController,
//                     decoration: InputDecoration(labelText: 'First Name'),
//                     validator: (value) => value!.isEmpty ? 'Enter first name' : null,
//                   ),
//                   TextFormField(
//                     controller: _lastNameController,
//                     decoration: InputDecoration(labelText: 'Last Name'),
//                     validator: (value) => value!.isEmpty ? 'Enter last name' : null,
//                   ),
//                   DropdownButtonFormField(
//                     value: _selectedRole,
//                     items: ['Cashier', 'Manager'].map((role) {
//                       return DropdownMenuItem(value: role, child: Text(role));
//                     }).toList(),
//                     onChanged: (value) => setState(() => _selectedRole = value.toString()),
//                     decoration: InputDecoration(labelText: 'Role'),
//                   ),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(labelText: 'Email'),
//                     validator: (value) => value!.contains('@') ? null : 'Enter valid email',
//                   ),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(labelText: 'Password'),
//                     obscureText: true,
//                     validator: (value) => value!.length >= 6 ? null : 'Password must be 6+ chars',
//                   ),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: addAccount,
//                     child: Text('Add User'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class UserManagement extends StatefulWidget {
  const UserManagement({Key? key}) : super(key: key);

  @override
  _UserManagementState createState() => _UserManagementState();
}

class _UserManagementState extends State<UserManagement> {
  List<Manager> managers = [
    Manager(
      profileImage: "https://via.placeholder.com/150",
      firstName: "John",
      lastName: "Doe",
      contact: "1234567890",
      role: "Admin",
      email: "john.doe@example.com",
      password: "******",
    ),
  ];

  List<Cashier> cashiers = [];

  void _showAddManagerDialog() {
    final _formKey = GlobalKey<FormState>();
    String profileImage = "";
    String firstName = "";
    String lastName = "";
    String contact = "";
    String role = "";
    String email = "";
    String password = "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Manager"),
        content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Profile Image URL"),
                  onSaved: (value) => profileImage = value ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "First Name"),
                  onSaved: (value) => firstName = value ?? "",
                  validator: (value) => value!.isEmpty ? "Enter first name" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Last Name"),
                  onSaved: (value) => lastName = value ?? "",
                  validator: (value) => value!.isEmpty ? "Enter last name" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Contact"),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => contact = value ?? "",
                  validator: (value) => value!.isEmpty ? "Enter contact" : null,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Role"),
                  onSaved: (value) => role = value ?? "",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => email = value ?? "",
                  validator: (value) =>
                      value!.contains("@") ? null : "Enter a valid email",
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                  onSaved: (value) => password = value ?? "",
                  validator: (value) =>
                      value!.length >= 6 ? null : "Password must be at least 6 characters",
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                setState(() {
                  managers.add(Manager(
                    profileImage: profileImage.isNotEmpty
                        ? profileImage
                        : "https://via.placeholder.com/150",
                    firstName: firstName,
                    lastName: lastName,
                    contact: contact,
                    role: role,
                    email: email,
                    password: "******",
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("User Management"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Manager"),
              Tab(text: "Cashier"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildManagerTable(),
            _buildCashierTable(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddManagerDialog,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildManagerTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text("Profile")),
          DataColumn(label: Text("First Name")),
          DataColumn(label: Text("Last Name")),
          DataColumn(label: Text("Contact")),
          DataColumn(label: Text("Role")),
          DataColumn(label: Text("Email")),
          DataColumn(label: Text("Password")),
        ],
        rows: managers
            .map(
              (manager) => DataRow(cells: [
                DataCell(CircleAvatar(
                  backgroundImage: NetworkImage(manager.profileImage),
                )),
                DataCell(Text(manager.firstName)),
                DataCell(Text(manager.lastName)),
                DataCell(Text(manager.contact)),
                DataCell(Text(manager.role)),
                DataCell(Text(manager.email)),
                DataCell(Text(manager.password)),
              ]),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCashierTable() {
    return Center(child: Text("Cashier Table (Coming Soon)"));
  }
}

class Manager {
  final String profileImage;
  final String firstName;
  final String lastName;
  final String contact;
  final String role;
  final String email;
  final String password;

  Manager({
    required this.profileImage,
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.role,
    required this.email,
    required this.password,
  });
}

class Cashier {
  final String profileImage;
  final String firstName;
  final String lastName;
  final String contact;
  final String role;
  final String email;
  final String password;

  Cashier({
    required this.profileImage,
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.role,
    required this.email,
    required this.password,
  });
}

