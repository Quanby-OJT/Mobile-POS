import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  fit: BoxFit.cover
                )
              ),
            )
          ),
          Expanded(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white
              ),
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
                            fontSize: 50,
                            fontWeight: FontWeight.bold
                          ),
                          ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50 ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome back! Please login to your \nCesar's account.",
                          style: TextStyle(
                            color: Colors.black26
                          ),
                          ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          label: Text('Email'),
                          floatingLabelStyle: TextStyle(
                            color: Colors.black
                          ),
                          hintText: 'Enter Email',
                          hintStyle: TextStyle(
                            color: Colors.black26
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black12
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black
                            )
                          )
                        ),
                      ),
                    ),
                  ],
                )
              ),
            )
            )
        ],
      ),
    );
  }
}