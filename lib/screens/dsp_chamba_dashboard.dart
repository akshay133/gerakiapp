import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/screens/single_ticket_info_screen.dart';
import 'package:geraki/screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;

class DspChambaDashboard extends StatefulWidget {
  const DspChambaDashboard({Key? key}) : super(key: key);

  @override
  _DspChambaDashboardState createState() => _DspChambaDashboardState();
}

class _DspChambaDashboardState extends State<DspChambaDashboard> {
  late SharedPreferences _prefs;
  String? selectedValue;

  getInstances() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    getInstances();
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
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("tickets")
                      .where('area', isEqualTo: "DSP Chamba")
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
                                    isAuthority:false,
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
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
