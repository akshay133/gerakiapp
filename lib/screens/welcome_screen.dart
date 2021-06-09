import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/screens/authority_login_screen.dart';
import 'package:geraki/screens/signup_screen.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var radioValue;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(body: Welcome(context));
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
                    color: whiteColor, child: Image.asset(welcomeImg)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text('Role',
                      style: Theme.of(context).textTheme.subtitle1),
                ),
                Row(
                  children: [
                    // Radio(
                    //   value: 'admin',
                    //   onChanged: (val) {
                    //     radioValue = val;
                    //     setState(() {
                    //       print(radioValue);
                    //     });
                    //   },
                    //   groupValue: radioValue,
                    // ),
                    // Text(
                    //   'Admin',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .subtitle1!
                    //       .copyWith(fontSize: 14),
                    // ),
                    Radio(
                      value: 'authority',
                      groupValue: radioValue,
                      onChanged: (val) {
                        radioValue = val;
                        setState(() {
                          print(radioValue);
                        });
                        Get.to(AuthLoginScreen());
                      },
                    ),
                    Text(
                      'Authority',
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                color: whiteColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(welcome1,
                              style: Theme.of(context).textTheme.headline6),
                          Text(welcome2,
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        button(createAcc, context, () {
                          Get.to(SignUpScreen());
                        }),
                        SizedBox(
                          height: 18,
                        ),
                        whiteButton(login, context, () {
                          Get.to(LoginScreen());
                        }),
                        TextButton(
                          onPressed: () {},
                          child: Text(cntinueGuest,
                              style: Theme.of(context).textTheme.subtitle1),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
