import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpaswordController = TextEditingController();
  AuthController _authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change password"),
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
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "New Password",
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
                controller: _confirmpaswordController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: "Confirm New Password",
                  labelStyle: Theme.of(context).textTheme.subtitle1,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            button("Update", context, () async {
              if (_passwordController.text.trim() ==
                  _confirmpaswordController.text.trim()) {
                _authController
                    .changePassword(_confirmpaswordController.text.trim());
              } else {
                Get.snackbar("Passwords do not match", "",
                    snackPosition: SnackPosition.BOTTOM);
              }
            })
          ],
        ),
      ),
    );
  }
}
