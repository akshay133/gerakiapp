import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/screens/signup_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late SharedPreferences prefs;
  clearLocalData() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    clearLocalData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: screenHeight * 0.2,
                decoration: BoxDecoration(color: primaryColor),
              ),
            ],
          ),
          Positioned(
              bottom: screenHeight * 0.60,
              left: 50,
              right: 50,
              child: Container(
                height: screenHeight * 0.20,
                decoration: BoxDecoration(color: whiteColor, boxShadow: [
                  BoxShadow(
                      color: lightGrey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 5)
                ]),
              )),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: whiteColor,
                      ),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: CachedNetworkImageProvider(profileUrl!),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Text(
                  name!,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                SmallButton("Logout", context, () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    prefs.clear();
                    Get.offAll(SignUpScreen());
                  });
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
