import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:geraki/screens/signup_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  AuthController controller = Get.find();
  var auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: TextButton(
              child: Text('Logout'),
              onPressed: () {
                auth.signOut();
                if (auth.currentUser == null) {
                  Get.offAll(SignUpScreen());
                }
              },
            ),
          ),
          Text(controller.authState())
        ],
      ),
    );
  }
}
