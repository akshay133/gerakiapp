import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  String? selectedValue;

  getInstances() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getInstances();
    FirebaseMessaging.onBackgroundMessage(_firebasePushHandle);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none)),
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
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("offenseCategories")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return SpinKitCircle(
                      color: primaryColor,
                      size: 50,
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItem: true,
                          items: [
                            ds["driveWithoutHelmet"],
                            ds["boulder"],
                            ds["parking"],
                            ds["potHole"],
                            ds["roadissues"],
                            ds["roadviolance"],
                            ds["trafficissues"],
                          ],
                          label: "Select category",
                          hint: "",
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: (value) {
                            setState(() {
                              selectedValue = value!;
                              print(selectedValue);
                            });
                          },
                          // selectedItem: ds["potHole"]
                        );
                      });
                }),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("tickets")
                      .where('category', isEqualTo: selectedValue)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return SpinKitCircle(
                        color: primaryColor,
                      );
                    return GridView.builder(
                      itemCount: snapshot.data!.size,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? 2
                              : 3),
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data!.docs[index];
                        Timestamp timestamp = data['time'];
                        return InkWell(
                          onTap: () {
                            Get.to(
                                SingleTicketInfoScreen(
                                    title: data['tickettitle'],
                                    img: data['ticketImgUrl'],
                                    location: data['addressFromLatLong'],
                                    time: timeago
                                        .format(DateTime.tryParse(
                                            timestamp.toDate().toString())!)
                                        .toString(),
                                    status: data['resolved'],
                                    descr: data['ticketDesc'],
                                    username: data['username'],
                                    phone: data["phone"],
                                    lat: data['lat'],
                                    long: data['long'],
                                    area: data['area'],
                                    isAuthority: true,
                                    ticketId: data['ticketId']),
                                transition: Transition.rightToLeftWithFade);
                          },
                          child: new Card(
                              child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: screenHeight * 0.12,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8)),
                                child: CachedNetworkImage(
                                  imageUrl: data['ticketImgUrl'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Text(
                                  data['tickettitle'],
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              Text(
                                timeago
                                    .format(DateTime.tryParse(
                                        timestamp.toDate().toString())!)
                                    .toString(),
                              ),
                              data['resolved']
                                  ? Text(
                                      'Resolved',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.green),
                                    )
                                  : Text(
                                      'Pending',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(color: Colors.red),
                                    ),
                            ],
                          )),
                        );
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   itemCount: snapshot.data!.size,
                        //   itemBuilder: (context, index) {
                        //     DocumentSnapshot ds = snapshot.data!.docs[index];
                        //     Timestamp timestamp = ds['time'];
                        //     return ListTile(
                        //       onTap: () {
                        //         Get.to(
                        //             SingleTicketInfoScreen(
                        //                 title: ds['tickettitle'],
                        //                 img: ds['ticketImgUrl'],
                        //                 location: ds['addressFromLatLong'],
                        //                 time: timeago
                        //                     .format(DateTime.tryParse(
                        //                         timestamp.toDate().toString())!)
                        //                     .toString(),
                        //                 status: ds['resolved'],
                        //                 descr: ds['ticketDesc'],
                        //                 username: ds['username'],
                        //                 phone: ds["phone"],
                        //                 ticketId: ds['ticketId']),
                        //             transition: Transition.rightToLeftWithFade);
                        //       },
                        //       title: Text(
                        //         ds['tickettitle'],
                        //         style: TextStyle(
                        //             fontWeight: FontWeight.w600,
                        //             color: headlineColor),
                        //       ),
                        //       leading: Container(
                        //         width: screenWidth / 4,
                        //         clipBehavior: Clip.antiAlias,
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(8)),
                        //         child: CachedNetworkImage(
                        //           imageUrl: ds['ticketImgUrl'],
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //       trailing: Flexible(
                        //         child: Column(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             if (ds['resolved'])
                        //               Text(
                        //                 'Resolved',
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .headline4!
                        //                     .copyWith(color: Colors.green),
                        //               )
                        //             else
                        //               Text(
                        //                 'Pending',
                        //                 style: Theme.of(context)
                        //                     .textTheme
                        //                     .headline4!
                        //                     .copyWith(color: Colors.red),
                        //               ),
                        //             Text(
                        //               timeago
                        //                   .format(DateTime.tryParse(
                        //                       timestamp.toDate().toString())!)
                        //                   .toString(),
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //       subtitle: Row(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Icon(
                        //             Icons.location_on_outlined,
                        //             color: primaryColor,
                        //           ),
                        //           Expanded(
                        //             child: Text(
                        //               ds['addressFromLatLong'],
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       minVerticalPadding: 8,
                        //     );
                        //   });
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _firebasePushHandle(RemoteMessage message) async {
    print("Message from push notification is ${message.data}");
    AwesomeNotifications().createNotificationFromJsonData(message.data);
  }
}
