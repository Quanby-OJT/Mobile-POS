import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
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
                    color: Colors.black87
                  ),
                  ),
              ),
              Text(
                  "We've sent you an OTP via Email",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 20
                  ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top:80, bottom: 30),
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.black,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly // Allow only digits
                        ],
                        decoration: InputDecoration(
                          hintText: 'Enter OTP...',
                          hintStyle: TextStyle(
                            color: Colors.black26
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black26
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black26
                            ),
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(300, 60),
                      backgroundColor: Color(0xFFEAAE16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    onPressed: () {}, 
                    child: Text(
                      'VERIFY',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
            ],
          )
        ),
      ),
    );
  }
}