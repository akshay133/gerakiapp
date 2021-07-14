import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import "package:file_picker/file_picker.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:geraki/screens/home_screen_main.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

TextEditingController name = TextEditingController();
TextEditingController email = TextEditingController();
TextEditingController date = TextEditingController();
TextEditingController month = TextEditingController();
TextEditingController year = TextEditingController();
TextEditingController address = TextEditingController();
var radioValue;
File? photo;
bool loading = false;
late String uid;
late String userphoneNo;
String photourl = defaultUserImg;

AuthController authController = Get.find();

class ProfileSetup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Profile(),
    );
  }
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late SharedPreferences _prefs;
  getInstances() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    inputData();
    getInstances();
    super.initState();
  }

  inputData() {
    User user = authController.auth.currentUser!;
    uid = user.uid;
    userphoneNo = user.phoneNumber!;
    print("uid:$uid");
    print("phoneNumber:$userphoneNo");
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: SpinKitCircle(
              color: primaryColor,
              size: 50.0,
            ),
          )
        : Container(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: screenHeight, minWidth: screenWidth),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight / 25,
                    ),
                    Avatar(),
                    MyTextField(
                      title: 'Full Name',
                      keyBoardType: TextInputType.name,
                      Width: screenWidth,
                      controller: name,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        width: screenWidth,
                        decoration: BoxDecoration(
                            color: textFieldColor,
                            border: Border.all(color: buttonBorder, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          validator: (input) =>
                              isValidEmail(input!) ? null : "Check your email",
                          controller: email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Email',
                            labelStyle: Theme.of(context).textTheme.subtitle1,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                          ),
                        ),
                      ),
                    ),
                    GenderRadio(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, top: 10),
                          child: Align(
                            alignment: AlignmentDirectional.topStart,
                            child: Text(
                              'Year of Birth',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ),
                        MyTextField(
                          title: 'YYYY',
                          keyBoardType: TextInputType.number,
                          Width: screenWidth * 0.30,
                          controller: year,
                        ),
                      ],
                    ),
                    MyTextField(
                      title: 'Address',
                      keyBoardType: TextInputType.streetAddress,
                      Width: screenWidth,
                      controller: address,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: button('Submit', context, () {
                        submitDetails();
                      }),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  bool isValidEmail(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  Row GenderRadio(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text('Gender', style: Theme.of(context).textTheme.subtitle1),
        ),
        Row(
          children: [
            Radio(
              value: 'M',
              onChanged: (val) {
                radioValue = val;
                setState(() {
                  print(radioValue);
                });
              },
              groupValue: radioValue,
            ),
            Text(
              'Male',
              style:
                  Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 14),
            ),
            Radio(
              value: 'F',
              groupValue: radioValue,
              onChanged: (val) {
                radioValue = val;
                setState(() {
                  print(radioValue);
                });
              },
            ),
            Text(
              'Female',
              style:
                  Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 14),
            ),
            Radio(
              value: 'O',
              groupValue: radioValue,
              onChanged: (val) {
                radioValue = val;
                setState(() {
                  print(radioValue);
                });
              },
            ),
            Text(
              'Other',
              style:
                  Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 14),
            )
          ],
        ),
      ],
    );
  }

  var firebase = FirebaseFirestore.instance;
  submitDetails() async {
    if (name.text == '' ||
        email.text == '' ||
        year.text == '' ||
        address.text == '' ||
        radioValue == null) {
      Get.snackbar(
        "Please fill all details",
        "",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    if (photo != null) {
      UploadTask photopath = uploadPhoto();
      setState(() {
        loading = true;
      });

      final snapshot = await photopath.whenComplete(() {});
      photourl = await snapshot.ref.getDownloadURL();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("profileUrl", photourl);
    prefs.setString("uid", uid);
    prefs.setString("username", name.text);
    firebase.collection('users').doc(uid).set({
      'photourl': photourl,
      'name': name.text,
      'email': email.text,
      'gender': radioValue.toString(),
      'dob': '${date.text}/${month.text}/${year.text}',
      'address': address.text,
      'phoneNumber': userphoneNo,
      'uid': uid
    }).then((value) {
      _prefs.setBool('profileSetup', true);
      Get.snackbar(
        "Profile Details Submitted!!",
        "",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    });

    setState(() {
      loading = false;
    });

    Get.offAll(() => HomeScreenMain());
  }

  uploadPhoto() {
    DateTime time = DateTime.now();
    String filename = 'files/userImages/${uid + time.toString()}';
    try {
      final ref = FirebaseStorage.instance.ref(filename);

      UploadTask task = ref.putFile(photo!);

      return task;
    } catch (e) {
      print(e);
    }
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.title,
    required this.keyBoardType,
    required this.Width,
    required this.controller,
  }) : super(key: key);

  final String title;
  final TextInputType keyBoardType;
  final double Width;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: Width,
        decoration: BoxDecoration(
            color: textFieldColor,
            border: Border.all(color: buttonBorder, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: TextField(
          controller: controller,
          keyboardType: keyBoardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: title,
            labelStyle: Theme.of(context).textTheme.subtitle1,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          ),
        ),
      ),
    );
  }
}

class Avatar extends StatefulWidget {
  const Avatar({
    Key? key,
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                setState(() {
                  File file = File(result.files.single.path!);
                  photo = file;
                });
              }
            },
            child: (photo == null)
                ? buildCircleAvatar(AssetImage(profileImg))
                : buildCircleAvatar(FileImage(photo!))));
  }
}
