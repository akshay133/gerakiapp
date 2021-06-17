import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/dimestions.dart';

class SingleTicketInfoScreen extends StatefulWidget {
  final String title;
  final String img;
  final String location;
  final String time;
  bool status;
  final String descr;
  final String username;
  final String phone;
  final String ticketId;
  final String lat;
  final String long;
  final String area;
  final bool isAuthority;

  SingleTicketInfoScreen(
      {required this.title,
      required this.img,
      required this.location,
      required this.time,
      required this.status,
      required this.descr,
      required this.username,
      required this.phone,
      required this.ticketId,
      required this.lat,
      required this.long,
      required this.isAuthority,
      required this.area});

  @override
  _SingleTicketInfoScreenState createState() => _SingleTicketInfoScreenState();
}

class _SingleTicketInfoScreenState extends State<SingleTicketInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.30,
                clipBehavior: Clip.antiAlias,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: widget.img,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.descr,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      "Address: ${widget.location}",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Text(
                      "lat: ${widget.lat} long:${widget.long}",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Container(
                        alignment: Alignment.topRight,
                        child: Text(widget.time)),
                    Divider(),
                    Text(
                      "createdBy: ${widget.username}",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "Phone Number: ${widget.phone}",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Status"),
                        if (!widget.isAuthority)
                          widget.status
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
                                )
                        else
                          InputChip(
                            padding: EdgeInsets.all(4.0),
                            avatar: CircleAvatar(
                              backgroundColor: whiteColor,
                            ),
                            label: Text(
                              widget.status ? 'Resolved' : "Pending",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: widget.status
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            selected: widget.status,
                            selectedColor: primaryColor,

                            onSelected: (bool selected) {
                              setState(() {
                                widget.status = selected;
                              });
                              FirebaseFirestore.instance
                                  .collection('tickets')
                                  .doc(widget.ticketId)
                                  .update({'resolved': widget.status});
                            },
                            // onDeleted: () {},
                          ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
