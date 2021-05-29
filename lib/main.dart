import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:geraki/screens/profile_setup.dart';
import 'package:geraki/screens/welcome_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        accentColor: primaryColor,
        fontFamily: 'CARMEN SANS',
        scaffoldBackgroundColor: whiteColor,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                fontSize: 16,
                fontFamily: 'CARMEN SANS',
                color: headlineColor,
              ),
              headline6: TextStyle(
                  fontSize: 22,
                  fontFamily: 'CARMEN SANS',
                  color: headlineColor,
                  fontWeight: FontWeight.bold),
              subtitle2:
                  TextStyle(fontFamily: 'CARMEN SANS', color: whiteColor),
              subtitle1: TextStyle(
                  fontSize: 16,
                  fontFamily: 'CARMEN SANS',
                  color: subtitleColor),
            ),
        textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'CARMEN SANS',
                  fontSize: 20,
                  color: whiteColor,
                  fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: whiteColor),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
