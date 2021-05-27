import 'package:flutter/material.dart';
import 'package:geraki/constants/strings.dart';

class VerifyOtpScreen extends StatefulWidget {
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                Text(
                  vrfyPhone,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            // SizedBox(height: ,)
          ],
        ),
      ),
    );
  }
}
