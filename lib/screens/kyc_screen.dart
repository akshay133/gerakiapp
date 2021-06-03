import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:get/get.dart';

class KycScreen extends StatefulWidget {
  @override
  _KycScreenState createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  String? selectedValue = "";
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Please complete your KYC",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      width: screenWidth * 0.02,
                    ),
                    SvgPicture.asset(done)
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.023,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("kycCategories")
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
                                ds["adhar"],
                                ds["pan"],
                                ds["voterID"],
                              ],
                              label: "Choose a option",
                              hint: "country in menu mode",
                              popupItemDisabled: (String s) =>
                                  s.startsWith('I'),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value!;
                                  print(selectedValue);
                                });
                              },
                              selectedItem: ds["adhar"]);
                        },
                      );
                    }),
                SizedBox(
                  height: screenHeight * 0.023,
                ),
                Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                      color: textFieldColor,
                      border: Border.all(color: buttonBorder, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    minLines: 1,
                    maxLines: 2,
                    controller: numberController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "$selectedValue Card Number",
                      labelStyle: Theme.of(context).textTheme.subtitle1,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.023,
                ),
                button("Submit", context, () {
                  if (numberController.text.isEmpty) {
                    Get.snackbar("Please enter $selectedValue Card Number", "",
                        snackPosition: SnackPosition.BOTTOM);
                  }
                }),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Divider(),
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("kycScreenText")
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
                          return Column(
                            children: [
                              SizedBox(
                                height: screenHeight * 0.024,
                              ),
                              Container(
                                child: Text(
                                  ds["youcan"],
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                alignment: Alignment.topLeft,
                              ),
                              SizedBox(
                                height: screenHeight * 0.012,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(doneCheck),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  Text(
                                    ds["emergency"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.012,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(doneCheck),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  Text(
                                    ds["alerts"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.012,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(doneCheck),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  Text(
                                    ds["supported"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1!
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.012,
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(doneCheck),
                                  SizedBox(
                                    width: screenWidth * 0.02,
                                  ),
                                  Text(ds["gpstxt"],
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(fontSize: 12)),
                                ],
                              ),
                            ],
                          );
                        });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
