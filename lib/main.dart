import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        accentColor: primaryColor,
        fontFamily: 'Quicksand',
        scaffoldBackgroundColor: whiteColor,
        textTheme: ThemeData.light().textTheme.copyWith(
            headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
        primaryTextTheme: TextTheme(headline6: TextStyle(color: whiteColor)),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          iconTheme: IconThemeData(color: whiteColor),
        ),
      ),
      home: SignUpScreen(),
      routes: {
        SignUpScreen.id: (context) => SignUpScreen(),
      },
    );
  }
}
