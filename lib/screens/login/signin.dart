import 'package:flutter/material.dart';
import 'package:mobile_pos/screens/manager/main.dart';
import 'package:mobile_pos/services/user_service.dart';
import '../auth/otp.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = "";

  Future<dynamic> loginAuth() async {
    try {
      final response = await UserService.loginAuthentication(
        emailController.text,
        passwordController.text,
      );

      // If the login is successful, extract user_id
      final userId = response['user_id'];

      setState(() {
        message = response['message']; // Display the success message
      });

      return userId.toString(); // Return user_id for successful login
    } catch (e) {
      setState(() {
        message = e.toString().replaceAll('Exception: ', ''); // Clean up error message
      });

      return null; // Indicate login failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 4,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/cesarsResto.jpg'),
                        fit: BoxFit.cover)),
              )),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome back! Please login to your \nCesar's account.",
                          style: TextStyle(color: Colors.black26),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value){
                          if(value == null || value.isEmpty) return 'Please Enter Your Email First';
                          return null;
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            label: Text('Email'),
                            floatingLabelStyle: TextStyle(color: Colors.black),
                            hintText: 'Enter Email',
                            hintStyle: TextStyle(color: Colors.black26),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Text(message, style: TextStyle(color: Colors.red)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 20),
                      child: TextFormField(
                        controller: passwordController,
                        validator: (value){
                          if(value == null || value.isEmpty) return 'Password Field Cannot be Empty';
                          return null;
                        },
                        cursorColor: Colors.black,
                        obscureText: true,
                        obscuringCharacter: '*',
                        decoration: InputDecoration(
                            label: Text('Password'),
                            floatingLabelStyle: TextStyle(color: Colors.black),
                            hintText: 'Enter Password',
                            hintStyle: TextStyle(color: Colors.black12),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50),
                      child: Text(message, style: TextStyle(color: Colors.red)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 50, top: 20),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              backgroundColor: Color(0xFFEAAE16),
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPage()));
                              },
                          //onPressed: () async {
                          //  setState(() {
                          //    message = ""; // Clear any previous message
                          //  });
//
                          //  String userId = await loginAuth();
                          //  print(userId);
//
                          //  if (userId != 0) {
                          //    // Successful login, navigate to OTP page
                          //    Navigator.push(
                          //      context,
                          //      MaterialPageRoute(
                          //        builder: (context) => OtpPage(user_id: userId.toString()),
                          //      ),
                          //    );
                          //  } else {
                          //    // Display the error message (already set by loginAuth)
                          //    ScaffoldMessenger.of(context).showSnackBar(
                          //      SnackBar(content: Text(message)), // Show the error as a snack bar
                          //    );
                          //  }
                          //},
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
