import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/screens/profile_screen.dart';
import 'package:get/get.dart';

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

Widget whiteButton(String btnText, BuildContext context, onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
        primary: whiteColor,
        minimumSize: Size(
          double.infinity,
          screenHeight * 0.065,
        )),
    child: Text(
      btnText,
      style:
          Theme.of(context).textTheme.subtitle2!.copyWith(color: headlineColor),
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

Widget buildCircleAvatar(ImageProvider image) {
  return CircleAvatar(
    radius: screenWidth / 5,
    backgroundColor: textFieldColor,
    backgroundImage: image,
    foregroundColor: subtitleColor,
  );
}

Widget buildCemaraElips(onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: screenWidth * 0.15,
      height: screenHeight * 0.10,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: whiteColor,
          border: Border.all(color: primaryColor)),
    ),
  );
}

Widget buildRecording(
  onTap,
) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: screenWidth * 0.15,
      height: screenHeight * 0.10,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: whiteColor,
          border: Border.all(color: primaryColor)),
      child: Center(
        child: Container(
          width: screenWidth * 0.05,
          height: screenHeight * 0.05,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xffF61304)),
        ),
      ),
    ),
  );
}

PreferredSizeWidget appbar(
    String title, String imgUrl, onPressed1, onPressed2) {
  return AppBar(
    elevation: 5,
    centerTitle: true,
    title: Text(
      title,
    ),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Get.to(ProfileScreen());
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: whiteColor,
              ),
              shape: BoxShape.circle),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(imgUrl),
          ),
        ),
      ),
    ),
    actions: [
      // IconButton(onPressed: onPressed1, icon: Icon(Icons.search)),
      //  IconButton(onPressed: onPressed2, icon: Icon(Icons.notifications_none))
    ],
  );
}

Widget CircleImg(imgUrl) {
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
          color: whiteColor,
        ),
        shape: BoxShape.circle),
    child: CircleAvatar(
      backgroundImage: CachedNetworkImageProvider(imgUrl),
    ),
  );
}
