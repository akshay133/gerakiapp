import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/strings.dart';
import 'package:get/get.dart';

class ReportOffenceScreen extends StatefulWidget {
  final String imgPath;

  ReportOffenceScreen({required this.imgPath});

  @override
  _ReportOffenceScreenState createState() => _ReportOffenceScreenState();
}

class _ReportOffenceScreenState extends State<ReportOffenceScreen> {
  bool loading = false;
  TextEditingController description = TextEditingController();
  TextEditingController title = TextEditingController();
  late String selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report a offense"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 12),
        child: loading
            ? Center(
                child: SpinKitCircle(
                  color: primaryColor,
                  size: 50.0,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: screenWidth,
                        height: screenHeight * 0.3,
                        child: Image.file(
                          File(widget.imgPath),
                          fit: BoxFit.fill,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Your Current Location',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              width: screenWidth,
                              decoration: BoxDecoration(
                                  color: textFieldColor,
                                  border:
                                      Border.all(color: buttonBorder, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "latitude,longitude",
                                style: Theme.of(context).textTheme.subtitle1,
                              )),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
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
                                    DocumentSnapshot ds =
                                        snapshot.data!.docs[index];
                                    return DropdownSearch<String>(
                                        mode: Mode.MENU,
                                        showSelectedItem: true,
                                        items: [
                                          ds["roadissues"],
                                          ds["roadviolance"],
                                          ds["trafficissues"],
                                        ],
                                        label: "Select category",
                                        hint: "country in menu mode",
                                        popupItemDisabled: (String s) =>
                                            s.startsWith('I'),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedValue = value!;
                                            print(selectedValue);
                                          });
                                        },
                                        selectedItem: ds["roadissues"]);
                                  },
                                );
                              }),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Container(
                            width: screenWidth,
                            decoration: BoxDecoration(
                                color: textFieldColor,
                                border:
                                    Border.all(color: buttonBorder, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              minLines: 1,
                              maxLines: 2,
                              controller: title,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Title",
                                labelStyle:
                                    Theme.of(context).textTheme.subtitle1,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          Container(
                            width: screenWidth,
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                                color: textFieldColor,
                                border:
                                    Border.all(color: buttonBorder, width: 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextField(
                              minLines: 1,
                              maxLines: 10,
                              controller: description,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: "Write About the offense",
                                labelStyle:
                                    Theme.of(context).textTheme.subtitle1,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ),
                          button("Submit", context, () {
                            submitOffense();
                          })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  var firebase = FirebaseFirestore.instance;
  submitOffense() async {
    UploadTask photopath = uploadPhoto();
    setState(() {
      loading = true;
    });
    final snapshot = await photopath.whenComplete(() {});
    final ticketImgUrl = await snapshot.ref.getDownloadURL();
    firebase.collection("tickets").doc(uid).set({
      "location": "4,8",
      "profileUrl": profileUrl,
      "ticketDesc": description.text,
      "ticketImgUrl": ticketImgUrl,
      "username": name,
      "tickettitle": title.text,
      "category": selectedValue
    }).then((value) {
      setState(() {
        loading = false;
      });
      Get.snackbar(
        "Submitted!",
        "",
        duration: Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }

  uploadPhoto() {
    DateTime time = DateTime.now();
    String filename = 'files/ticketsImages/${uid! + time.toString()}';
    try {
      final ref = FirebaseStorage.instance.ref(filename);

      UploadTask task = ref.putFile(File(widget.imgPath));

      return task;
    } catch (e) {
      print(e);
    }
  }
}
