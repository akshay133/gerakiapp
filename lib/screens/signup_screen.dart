import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/screens/veryfy_otp_screen.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(signup),
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
        actions: [
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(right: 16),
              child: Text(
                login,
                style: Theme.of(context).textTheme.subtitle2,
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Image.asset(
                    road,
                    width: double.infinity,
                    height: screenHeight * 0.428,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: screenHeight * 0.034,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      cntinueWithph,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.012,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.topLeft,
                    child: Text(
                      verifysixdigit,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  buildTextFiledContainer(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildTextFiledContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: shadowColor2,
                blurRadius: 10,
                offset: Offset(0, -12),
                spreadRadius: -4),
          ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: headlineColor),
              decoration: InputDecoration(
                hintText: '1234567890',
                labelText: 'Enter your Number',
                border: InputBorder.none,
                prefix: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    '+91',
                    style: TextStyle(color: headlineColor),
                  ),
                ),
              ),
              maxLength: 10,
              keyboardType: TextInputType.phone,
              controller: _phoneController,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(VerifyOtpScreen(),
                  arguments: ["+91${_phoneController.text}"]);
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.020,
                  horizontal: screenWidth * 0.028),
              decoration: BoxDecoration(
                  boxShadow: shadows,
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                cntinue,
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          )
        ],
      ),
    );
  }
}
