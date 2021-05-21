import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: primaryColor,
        primaryTextTheme: TextTheme(headline6: TextStyle(color: whiteColor)),
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: whiteColor),
          )),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
