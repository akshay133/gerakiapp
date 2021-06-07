import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/strings.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String firstHalf;

  late String secondHalf;
  late String description;

  bool flag = true;
  late SharedPreferences prefs;

  getUserDataLocally() async {
    prefs = await SharedPreferences.getInstance();
    profileUrl = prefs.getString("profileUrl");
    uid = prefs.getString("uid");
    name = prefs.getString("username");

  }

  @override
  void initState() {
    getUserDataLocally();
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
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
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
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'created by:${ds["username"]}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontSize: 13),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]);
                      });
                })));
  }
}
