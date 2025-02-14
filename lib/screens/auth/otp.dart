import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../manager/main.dart';
import 'package:mobile_pos/services/user_service.dart';
import 'package:mobile_pos/screens/manager/dashboard.dart';

class OtpPage extends StatefulWidget {
  final String user_id;
  const OtpPage({super.key, required this.user_id});

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
        widget.user_id
      );

      final int userId = otp['user_id'];
      final String role = otp['roles.user_role'];

      // If no error is thrown, the login is successful
      setState(() {
        this.message = otp; // Success message
      });
      return {userId, role}; // Successful login
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
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Verification',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
            ),
            Text(
              "We've sent you an OTP via Email",
              style: TextStyle(color: Colors.black26, fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.only(top: 80, bottom: 30),
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
                      hintStyle: TextStyle(color: Colors.black26),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26),
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: Text(message, style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(300, 60),
                  backgroundColor: Color(0xFFEAAE16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                setState(() {
                  message = "";
                });

                final hasOTPVerified = await otpAuth();
                print (hasOTPVerified);

                if(hasOTPVerified['user_id'] > 0){
                  //Implementation of Role-Based Access Role.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("I logged in to the system.")), // Display the error message
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)), // Display the error message
                  );
                }
              },
              child: Text(
                'VERIFY',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
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
                  child: Text(
                    'Resend again',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }
}
