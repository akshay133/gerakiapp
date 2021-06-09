import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/strings.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyTicketsScreen extends StatefulWidget {
  @override
  _MyTicketsScreenState createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen> {
  @override
  void initState() {
    super.initState();
    print(uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(mytickets, profileUrl!, () {}, () {}),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("tickets")
            .where('uid', isEqualTo: uid)
            .snapshots(),
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
                    title: Text(
                      ds['tickettitle'],
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: headlineColor),
                    ),
                    leading: Container(
                      width: screenWidth / 4,
                      clipBehavior: Clip.antiAlias,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
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
    );
  }
}
