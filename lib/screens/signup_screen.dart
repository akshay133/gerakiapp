import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/shadows.dart';
import 'package:geraki/constants/strings.dart';

class SignUpScreen extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              Image.asset(
                road,
              ),
              SizedBox(
                height: size.height * 0.034,
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
                height: size.height * 0.012,
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
                height: size.height * 0.05,
              ),
              buildTextFiledContainer(context),
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
                blurRadius: 32,
                offset: Offset(0, -5),
                spreadRadius: -4),
            BoxShadow(
                color: shadowColor1,
                blurRadius: 2,
                offset: Offset(0, 0),
                spreadRadius: 0),
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
              controller: _controller,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 28),
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
