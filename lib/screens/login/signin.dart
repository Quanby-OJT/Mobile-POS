import 'package:flutter/material.dart';
import '../auth/otp.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isTablet = constraints.maxWidth > 600;
          return Row(
            children: [
              if (isTablet)
                Expanded(
                  flex: 4,
                  child: Container(
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/cesarsResto.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 50, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Welcome back! Please login to your \nCesar's account.",
                              style: TextStyle(color: Colors.black26),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                              cursorColor: Colors.black,
                              decoration: InputDecoration(
                                label: const Text('Email'),
                                floatingLabelStyle:
                                    const TextStyle(color: Colors.black),
                                hintText: 'Enter Email',
                                hintStyle: const TextStyle(color: Colors.black26),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              cursorColor: Colors.black,
                              obscureText: true,
                              obscuringCharacter: '*',
                              decoration: InputDecoration(
                                label: const Text('Password'),
                                floatingLabelStyle:
                                    const TextStyle(color: Colors.black),
                                hintText: 'Enter Password',
                                hintStyle: const TextStyle(color: Colors.black12),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child: const Text(
                                  'Forget Password?',
                                  style: TextStyle(color: Colors.blueAccent),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 50),
                                  backgroundColor: const Color(0xFFEAAE16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OtpPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
