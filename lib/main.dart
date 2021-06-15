import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:geraki/screens/home_screen_main.dart';
import 'package:geraki/screens/profile_setup.dart';
import 'package:geraki/screens/veryfy_otp_screen.dart';
import 'package:geraki/screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:geraki/screens/camera_screen.dart';

late List<CameraDescription> cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //getx dependecies injection
  final authController = Get.put(AuthController());
  //end
  FirebaseAuth? _auth;
  User? _user;
  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    _user = _auth!.currentUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        primaryColor: primaryColor,
        accentColor: primaryColor,
        fontFamily: 'CARMEN SANS',
        scaffoldBackgroundColor: whiteColor,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline5: TextStyle(
                  fontSize: 16,
                  fontFamily: 'CARMEN SANS',
                  color: headlineColor,
                  fontWeight: FontWeight.w500),
              headline4: TextStyle(
                  fontSize: 14,
                  fontFamily: 'CARMEN SANS',
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              headline2: TextStyle(
                  fontSize: 11,
                  fontFamily: 'CARMEN SANS',
                  color: subtitleColor),
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
      home: //ProfileSetup()
      _user == null ? WelcomeScreen() : HomeScreenMain(),
    );
  }
}
