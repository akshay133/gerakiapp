import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/screens/report_offence_screen.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final String videoFile;

  VideoPreviewScreen({required this.videoFile});

  @override
  _VideoPreviewScreenState createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late VideoPlayerController _controller;
  bool _isSelected = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video'),
      ),
      body: Stack(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          Positioned(
            bottom: 10,
            left: 30,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: whiteColor,
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              right: 30,
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
                  Get.to(ReportOffenceScreen(file: widget.videoFile));
                },
                // onDeleted: () {},
              ))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
