import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String firstHalf;
  late VideoPlayerController _controller;
  late String secondHalf;
  late String description;
  bool flag = true;
  late SharedPreferences prefs;

  AuthController authController = Get.find();
  getUserData() async {
    // prefs = await SharedPreferences.getInstance();
    // profileUrl = prefs.getString("profileUrl");
    // uid = prefs.getString("uid");
    // name = prefs.getString("username");
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      setState(() {
        profileUrl = value.get("photourl");
        name = value.get("name");
        phone = value.get("phoneNumber");
        print(profileUrl);
        print(name);
      });
    });
  }

  inputData() {
    User user = authController.auth.currentUser!;
    uid = user.uid;
    print("uid:$uid");
  }

  @override
  void initState() {
    inputData();
    getUserData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(appname, profileUrl!, () async {}, () {}),
        body: Container(
            padding: EdgeInsets.only(
              top: 12,
            ),
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('tickets')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SpinKitCircle(
                      color: primaryColor,
                      size: 50,
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        Timestamp timestamp = ds['time'];
                        return Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Container(
                                      height: screenHeight * 0.035,
                                      width: screenWidth * 0.09,
                                      // height: 30,
                                      // width: 30,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: whiteColor,
                                          ),
                                          shape: BoxShape.circle),
                                      child: CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  ds["profileUrl"])),
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.02,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          ds["tickettitle"],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4,
                                        ),
                                        Text(
                                          ds["addressFromLatLong"].toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {},
                                )
                              ]),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4)),
                              child: CachedNetworkImage(
                                imageUrl: ds["ticketImgUrl"],
                                fit: BoxFit.cover,
                                height: screenHeight * 0.245,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.thumb_up_alt_outlined,
                                        )),
                                    Text('7'),
                                    IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(comment)),
                                    Text('7'),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: SvgPicture.asset(share)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ReadMoreText(ds["ticketDesc"],
                                    trimLines: 2,
                                    textAlign: TextAlign.start,
                                    colorClickableText: Colors.pink,
                                    trimMode: TrimMode.Line,
                                    trimCollapsedText: '...Read more',
                                    moreStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontSize: 12),
                                    lessStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontSize: 12),
                                    trimExpandedText: ' Less',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: headline3Color)),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        'created by:${ds["username"]}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(fontSize: 13),
                                      ),
                                    ),
                                    Text(
                                      timeago
                                          .format(DateTime.tryParse(
                                              timestamp.toDate().toString())!)
                                          .toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]);
                      });
                })));
  }
}
