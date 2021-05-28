import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/dimestions.dart';

List<BoxShadow> shadows = [
  BoxShadow(
    color: shadowColor1,
    offset: Offset(0, 16),
    blurRadius: 32,
    spreadRadius: -4,
  ),
  BoxShadow(
    color: shadowColor1,
    offset: Offset(0, 0),
    blurRadius: 2,
    spreadRadius: 0,
  )
];

Widget button(String btnText, BuildContext context, onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        primary: primaryColor,
        minimumSize: Size(
          double.infinity,
          screenHeight * 0.065,
        )),
    child: Text(
      btnText,
      style: Theme.of(context).textTheme.subtitle2,
    ),
  );
}

Widget SmallButton(String btnText, BuildContext context, onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    child: Text(
      btnText,
      style: Theme.of(context).textTheme.subtitle2,
    ),
    style: ElevatedButton.styleFrom(
        primary: primaryColor,
        minimumSize: Size(
          screenWidth / 4,
          screenHeight * 0.065,
        )),
  );
}
