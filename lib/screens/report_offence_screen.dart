import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';

class ReportOffenceScreen extends StatefulWidget {
  final String imgPath;

  ReportOffenceScreen({required this.imgPath});

  @override
  _ReportOffenceScreenState createState() => _ReportOffenceScreenState();
}

class _ReportOffenceScreenState extends State<ReportOffenceScreen> {
  String dropdownValue = 'Select a category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report a offense"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, bottom: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: screenWidth,
                  height: screenHeight * 0.3,
                  child: Image.file(
                    File(widget.imgPath),
                    fit: BoxFit.cover,
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
                      width: screenWidth,
                      decoration: BoxDecoration(
                          color: textFieldColor,
                          border: Border.all(color: buttonBorder, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "latitide,logitude",
                          labelStyle: Theme.of(context).textTheme.subtitle1,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    // Container(
                    //   width: screenWidth,
                    //   decoration: BoxDecoration(
                    //       color: textFieldColor,
                    //       border: Border.all(color: buttonBorder, width: 1),
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: DropdownButton<String>(
                    //     underline: SizedBox(),
                    //     isExpanded: true,
                    //     value: dropdownValue.isNotEmpty ? dropdownValue : null,
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         dropdownValue = newValue!;
                    //       });
                    //     },
                    //     items: <String>['First', 'Second', 'Third', 'Fourth']
                    //         .map<DropdownMenuItem<String>>((String value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(value),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.15,
                      decoration: BoxDecoration(
                          color: textFieldColor,
                          border: Border.all(color: buttonBorder, width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextField(
                        minLines: 1,
                        maxLines: 10,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Write About the offense",
                          labelStyle: Theme.of(context).textTheme.subtitle1,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    button("Submit", context, () {})
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
