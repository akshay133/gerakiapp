import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLoginScreen extends StatefulWidget {
  @override
  _AuthLoginScreenState createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _paswordController = TextEditingController();
  AuthController _authController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: textFieldColor,
                  border: Border.all(color: buttonBorder, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Email",
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Container(
              width: Get.width,
              decoration: BoxDecoration(
                  color: textFieldColor,
                  border: Border.all(color: buttonBorder, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              child: TextField(
                controller: _paswordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Password",
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            button("login", context, () async {
              _authController.login(_emailController.text.trim(),
                  _paswordController.text.trim());


            })
          ],
        ),
      ),
    );
  }
}
