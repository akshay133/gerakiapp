import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/screens/report_offence_screen.dart';
import 'package:get/get.dart';

class PreviewScreen extends StatefulWidget {
  final String imagePath;

  PreviewScreen({required this.imagePath});

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Image.file(File(widget.imagePath)),
              Positioned(
                  bottom: -5,
                  right: 25,
                  child: InputChip(
                    padding: EdgeInsets.all(4.0),
                    avatar: CircleAvatar(
                      backgroundColor: whiteColor,
                    ),
                    label: Text(
                      'Done',
                      style: TextStyle(
                          fontSize: 16,
                          color: _isSelected ? Colors.white : Colors.black),
                    ),
                    selected: _isSelected,
                    selectedColor: primaryColor,

                    onSelected: (bool selected) {
                      setState(() {
                        _isSelected = selected;
                      });
                      Get.to(ReportOffenceScreen(imgPath: widget.imagePath));
                    },
                    // onDeleted: () {},
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
