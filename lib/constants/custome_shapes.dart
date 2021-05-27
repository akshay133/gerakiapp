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

Widget button(String btnText, BuildContext context, onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: screenHeight * 0.065,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
          child: Text(
        btnText,
        style: Theme.of(context).textTheme.subtitle2,
      )),
    ),
  );
}
