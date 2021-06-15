import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' show join;
import 'package:flutter/foundation.dart' show kIsWeb;

Timer? _timer;
int _start = 0;
int timerFlag=0;
String? path;

showmyBottomSheet(context){
  showModalBottomSheet(context: context,builder: (context){
    return MyBottomSheet();
  });
}

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;

  @override
  void initState() {
    _mPlayer!.openAudioSession().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });

    openTheRecorder().then((value) {
      setState(() {
        _mRecorderIsInited = true;
        // _mRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
        // _mRecorder.setOutputFormat(MediaRecorder.OutputFormat.AAC_ADTS);
        // _mRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.AAC);
        _mRecorder!.isEncoderSupported(Codec.aacADTS);
      });
    });
     getPath();
    super.initState();
  }

  @override
  void dispose() {
    _mPlayer!.closeAudioSession();
    _mPlayer = null;

    _mRecorder!.closeAudioSession();
    _mRecorder = null;

    super.dispose();
  }

  getPath()async {
    path = join(
      // Store the picture in the temp directory.
      // Find the temp directory using the `path_provider` plugin.
        (await getTemporaryDirectory()).path,
    '${DateTime.now()}.mp3',
    );
    print("path is $path");
  }

  Future<void> openTheRecorder() async {
    if (!kIsWeb) {
      var status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      }
    }
    await _mRecorder!.openAudioSession();
    _mRecorderIsInited = true;
  }

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    print("path is $path");
    _mRecorder!
        .startRecorder(
      toFile: path
    )
        .then((value) {
      setState(() {
        print("path is $path");
      });
    });
  }

  void stopRecorder() async {
    await _mRecorder!.stopRecorder().then((value) {
      setState(() {
        //var url = value;
        _mplaybackReady = true;
      });
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        _mRecorder!.isStopped &&
        _mPlayer!.isStopped);
    _mPlayer!
        .startPlayer(
        fromURI: path,
        codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {
          setState(() {});
        })
        .then((value) {
      setState(() {});
    });
  }

  void stopPlayer() {
    _mPlayer!.stopPlayer().then((value) {
      setState(() {});
    });
  }

  uploadFile() {
    File file=File(path!);
    DateTime time = DateTime.now();
    String filename = 'files/SOS/${uid! + time.toString()}';
    try {
      final ref = FirebaseStorage.instance.ref(filename);

      UploadTask task = ref.putFile(file,SettableMetadata(contentType: 'audio/mpeg'));

      return task;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff737373),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20)
            )
        ),
        height: screenHeight*0.4,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Stack(
            children: [
              Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: IconButton(icon: Icon(Icons.close),onPressed: (){_timer!.cancel();Navigator.pop(context);},)),
              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: IconButton(icon: Icon(Icons.delete_forever_outlined),onPressed: (){},)),
              Align(
                alignment: AlignmentDirectional.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('Record Your',style: Theme.of(context).textTheme.headline5,),
                        SizedBox(height: 5,),
                        Text('Voice',style: Theme.of(context).textTheme.headline5,),
                      ],
                    ),
                    MaterialButton(
                      onPressed: (){

                        if(timerFlag==0){
                          setState(() {
                            startTimer();
                            timerFlag=1;
                            record();
                          });

                        }
                        else{
                          setState(() {
                            _timer!.cancel();
                            timerFlag=0;
                            stopRecorder();
                          });

                        }
                        },
                      child: Container(
                        decoration: BoxDecoration(
                            color: whiteColor,
                            //border: Border.all(width: 1,color: buttonBorder),
                            boxShadow: [
                              BoxShadow(
                                  color: shadowColor1,
                                  offset: Offset(30,10),
                                  blurRadius: 30
                              ),
                              BoxShadow(
                                  color: whiteColor,
                                  offset: Offset(-30,-10),
                                  blurRadius: 30
                              ),
                            ],
                            shape: BoxShape.circle
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(Icons.keyboard_voice,color: primaryColor,size: screenWidth/7,),
                        ),
                      ),
                    ),
                    Text(
                      "00:$_start",style: Theme.of(context).textTheme.subtitle1,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        uploadFile();
                        print('send');
                      },
                      child: Text('Send',style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
}



