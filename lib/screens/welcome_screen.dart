import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/screens/signup_screen.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Welcome(context));
  }

  Widget Welcome(BuildContext context) {
    return Container(
      width: screenWidth,
      child: Column(
        children: [
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                color: Colors.white,
                child: Image.asset(welcomeImg)
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome to',
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25
                      ),),
                      Text('Geraki',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                      ),),
                    ],
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(SignUpScreen());
                      },
                      child: Container(
                        width: screenWidth - 60,
                        decoration: BoxDecoration(
                            border: Border.all(color: primaryColor),
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Center(
                            child: Text(
                              createAcc,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: screenWidth - 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffE0E0E0),width: 1),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Center(
                            child: Text(
                              login,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          cntinueGuest,
                          style: TextStyle(color: Color(0xff9C9C9C)),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ));
  }
}

