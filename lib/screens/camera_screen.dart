import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/main.dart';
import 'package:geraki/screens/preview_screen.dart';
import 'package:geraki/screens/video_preview_screen.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  late XFile file;
  late XFile Vfile;
  int cameraType = 0;
  int flashType = 0;
  bool _startRecording = false;
  Icon flashicon = Icon(Icons.flash_on);
  int recordType = 0;
  BoxShape videoShape = BoxShape.circle;
  final String _assetVideoRecorder = 'assets/images/play.png';
  final String _assetStopVideoRecorder = 'assets/images/stop.png';
  late String videoPath;
  late VideoPlayerController videoController;
  late VoidCallback videoPlayerListener;
  late Timer _timer;
  int _start = 0;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 60) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setCameraType();
  }

  @override
  void dispose() {
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          Container(
            height : screenHeight,
            child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
            ),
          ),
          Positioned(
              top: 50,
              left: 10,
              child: Row(
                children: [
                  CircleImg(
                      "https://blueandgreentomorrow.com/wp-content/uploads/2017/12/sustainable-roads-motorways.jpg"),
                  SizedBox(
                    width: screenWidth * 0.015,
                  ),
                  // Text(
                  //   recordType == 0 ? "" : "Rec.$_start",
                  //   style: TextStyle(color: Color(0xffF61304)),
                  // )
                ],
              )),
          Positioned(
            right: 50,
            bottom: 15,
            left: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryColor),
                    color: whiteColor.withOpacity(0.3),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 30,
                    icon: flashicon,
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      if (flashType == 0) {
                        controller.setFlashMode(FlashMode.torch);
                        flashType = 1;
                        setState(() {
                          flashicon = Icon(Icons.flash_off);
                        });
                      } else {
                        controller.setFlashMode(FlashMode.off);
                        flashType = 0;
                        setState(() {
                          flashicon = Icon(Icons.flash_on);
                        });
                      }
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: primaryColor),
                    color: whiteColor.withOpacity(0.3),
                  ),
                  child: IconButton(
                    color: Colors.white,
                    iconSize: 30,
                    icon: Icon(Icons.flip_camera_android),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      cameraType == 0 ? cameraType = 1 : cameraType = 0;
                      setCameraType();
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 50,
            left: 50,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildCemaraElips(
                    () async {
                      HapticFeedback.lightImpact();
                      final path = join(
                        // Store the picture in the temp directory.
                        // Find the temp directory using the `path_provider` plugin.
                        (await getTemporaryDirectory()).path,
                        '${DateTime.now()}.png',
                      );
                      file = await controller.takePicture();
                      print(file);
                      file.saveTo(path).then((saveImgPath) {
                        print(path);
                        Get.to(PreviewScreen(
                          imagePath: path,
                        ));
                      });
                    },
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  InkWell(
                    onTap: () async {
                      HapticFeedback.lightImpact();
                      if (recordType == 0) {
                        await controller.startVideoRecording();
                        recordType = 1;
                        setState(() {
                          videoShape = BoxShape.circle;
                        });
                      } else {
                        stopvideo();

                        recordType = 0;
                        setState(() {
                          videoShape = BoxShape.circle;
                        });
                      }
                    },
                    child: Container(
                      width: screenWidth * 0.15,
                      height: screenHeight * 0.10,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                          border: Border.all(color: primaryColor)),
                      child: Center(
                        child: Container(
                          width: screenWidth * 0.05,
                          height: screenHeight * 0.05,
                          decoration: BoxDecoration(
                              shape: videoShape,
                              color: recordType == 0
                                  ? Color(0xffF61304)
                                  : Colors.black45),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }

  setCameraType() {
    controller = CameraController(cameras[cameraType], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  stopvideo() async {
    final path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.mp4',
    );
    Vfile = await controller.stopVideoRecording();

    Vfile.saveTo(path).then((value) {
      Get.to(VideoPreviewScreen(
        videoFile: path,
      ));
    });
  }
}
