import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOtpScreen extends StatefulWidget {
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  AuthController controller = Get.find();
  final phone = Get.arguments;
  String _verificationCode = '';
  final TextEditingController _pinPutController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  Timer? _timer;
  int _start = 60;
  var onTapRecognizer;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    onTapRecognizer = TapGestureRecognizer()..onTap = () {};
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer!.cancel();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            vrfyPhone,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.055,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "$codeSent ${phone[0]}",
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.021,
              ),
              Form(
                  key: formKey,
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '*',
                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v!.length < 3) {
                        return "all fields required!";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: screenHeight * 0.05,
                      activeColor: primaryColor,
                      inactiveColor: Color(0xffE0E0E0),
                      selectedColor: primaryColor,
                      fieldWidth: 40,
                      activeFillColor: hasError ? Colors.yellow : Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: false,
                    errorAnimationController: errorController,
                    controller: _pinPutController,
                    keyboardType: TextInputType.number,
                    onCompleted: (value) {
                      print("Completed");
                      setState(() {
                        _verificationCode = value;
                      });
                    },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        _verificationCode = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "*Please fill up all the cells properly" : "",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.026,
              ),
              button(verify, context, () {
                formKey.currentState!.validate();
                // conditions for validating
                if (_verificationCode.length != 6) {
                  print("otp$_verificationCode");
                  errorController!.add(ErrorAnimationType
                      .shake); // Triggering error shake animation
                  setState(() {
                    hasError = true;
                  });
                } else {
                  setState(() {
                    hasError = false;
                    print("otp$_verificationCode");
                    controller.verifyOTP(_verificationCode);
                  });
                }
              }),
              SizedBox(
                height: screenHeight * 0.038,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Didn't receive the code? ",
                  style: Theme.of(context).textTheme.subtitle1,
                  children: [
                    TextSpan(
                        text: " Resend",
                        recognizer: onTapRecognizer,
                        style: Theme.of(context).textTheme.headline5)
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Text(
                getcodCall,
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        ));
  }
}
