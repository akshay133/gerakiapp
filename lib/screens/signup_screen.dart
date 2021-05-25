import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/images.dart';
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
                style: TextStyle(
                    color: whiteColor, fontSize: 16, fontFamily: 'OpenSans'),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                gerakiImg,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 54),
                child: Text(
                  verifysixdigit,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline6,
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: Color(0xff000000).withOpacity(0.15),
                blurRadius: 5,
                offset: Offset(0, -5),
                spreadRadius: -2)
          ]),
      child: TextField(
        decoration: InputDecoration(
            hintText: '1234567890',
            labelText: 'Enter your phone',
            border: InputBorder.none,
            prefix: Padding(
              padding: EdgeInsets.all(4),
              child: Text('+91'),
            ),
            suffix: Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 26),
              decoration: BoxDecoration(
                  color: btnColor, borderRadius: BorderRadius.circular(5)),
              child: Text(
                cntinue,
                style: Theme.of(context).textTheme.headline6,
              ),
            )),
        maxLength: 10,
        keyboardType: TextInputType.phone,
        controller: _controller,
      ),
    );
  }
}
