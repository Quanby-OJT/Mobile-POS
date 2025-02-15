import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pos/services/sessionmanager.dart';
import '../manager/main.dart';
import 'package:mobile_pos/services/user_service.dart';
import 'package:mobile_pos/screens/manager/dashboard.dart';
import 'package:mobile_pos/screens/manager/inventory_page.dart';

class OtpPage extends StatefulWidget {
  final String userId;
  const OtpPage({super.key, required this.userId});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController otpController = TextEditingController();
  String message = "";

  Future<dynamic> otpAuth() async {
    try {
      final otp = await UserService.otpAuthentication(
        otpController.text,
        widget.userId,
      );

      final int userId = int.parse(otp['user']);
      final String role = otp['role'];

      // If no error is thrown, the login is successful
      setState(() {
        message = "OTP Verified Successfully!";
      });
      return {'userId': userId, 'role': role}; // Successful login
    } catch (e) {
      setState(() {
        message = e.toString(); // Display the error message
      });
      return false; // Login failed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        forceMaterialTransparency: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/verification_badge.png',
                width: 150,
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Verification',
                  style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              const Text(
                "We've sent you an OTP via Email",
                style: TextStyle(color: Colors.black26, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 30),
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: otpController,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly // Allow only digits
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter OTP...',
                      hintStyle: const TextStyle(color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Text(message, style: const TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 60),
                  backgroundColor: const Color(0xFFEAAE16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () async {
                  setState(() {
                    message = "";
                  });

                  final hasOTPVerified = await otpAuth();
                  print(hasOTPVerified);

                  if (hasOTPVerified != false && hasOTPVerified['userId'] > 0) {
                    // Save session data securely
                    final userId = hasOTPVerified['userId'].toString();
                    final role = hasOTPVerified['role'];

                    await SecureStorageManager.saveSession(userId, role, '');

                    // Navigate based on user role
                    if (role == 'Manager') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManagerDashboard()),
                      );
                    } else if(role == 'Cashier') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InventoryPage()),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(message),
                      ),
                    );
                  }
                },
                child: const Text(
                  'VERIFY',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the OTP?",
                    style: TextStyle(color: Colors.black26),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    },
                    child: const Text(
                      'Resend again',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
