import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/screens/single_ticket_info_screen.dart';
import 'package:geraki/screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class AuthoritiesDashboard extends StatefulWidget {
  @override
  _AuthoritiesDashboardState createState() => _AuthoritiesDashboardState();
}

class _AuthoritiesDashboardState extends State<AuthoritiesDashboard> {
  late SharedPreferences _prefs;

  getInstances() async {
    _prefs = await SharedPreferences.getInstance();
  }

  late FirebaseMessaging messaging;
  @override
  void initState() {
    getInstances();
    // messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) {
    //   print(value);
    // });
    // FirebaseMessaging.onMessage.listen((event) {
    //   print("message recieved");
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('Message clicked!');
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () async {
              await FirebaseAuth.instance.signOut().then((value) {
                _prefs.clear();
                Get.offAll(WelcomeScreen());
              });
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(12),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("tickets").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return SpinKitCircle(
                color: primaryColor,
              );
            return Container(
              height: screenHeight,
              width: screenWidth,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    Timestamp timestamp = ds['time'];
                    return ListTile(
                      onTap: () {
                        Get.to(
                            SingleTicketInfoScreen(
                                title: ds['tickettitle'],
                                img: ds['ticketImgUrl'],
                                location: ds['addressFromLatLong'],
                                time: timeago
                                    .format(DateTime.tryParse(
                                        timestamp.toDate().toString())!)
                                    .toString(),
                                status: ds['resolved'],
                                descr: ds['ticketDesc'],
                                username: ds['username'],
                                phone: ds["phone"],
                                ticketId: ds['ticketId']),
                            transition: Transition.rightToLeftWithFade);
                      },
                      title: Text(
                        ds['tickettitle'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: headlineColor),
                      ),
                      leading: Container(
                        width: screenWidth / 4,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        child: CachedNetworkImage(
                          imageUrl: ds['ticketImgUrl'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (ds['resolved'])
                            Text(
                              'Resolved',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.green),
                            )
                          else
                            Text(
                              'Pending',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.red),
                            ),
                          Text(
                            timeago
                                .format(DateTime.tryParse(
                                    timestamp.toDate().toString())!)
                                .toString(),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: primaryColor,
                          ),
                          Expanded(
                            child: Text(
                              ds['addressFromLatLong'],
                            ),
                          ),
                        ],
                      ),
                      minVerticalPadding: 8,
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
