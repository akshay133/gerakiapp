
import 'dart:io';
import "package:file_picker/file_picker.dart";
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

TextEditingController name=TextEditingController();
TextEditingController email=TextEditingController();
TextEditingController date=TextEditingController();
TextEditingController month=TextEditingController();
TextEditingController year=TextEditingController();
TextEditingController address=TextEditingController();
var radioValue;
File? photo;

class ProfileSetup extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),onPressed: (){},),
        title: Text('Profile'),
      ),
      body: Profile(),
    );
  }
}

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
            minWidth: screenWidth
          ),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight/25,
              ),
              Avatar(),
              MyTextField(title: 'Full Name',keyBoardType: TextInputType.name, Width: screenWidth,controller: name,),
              MyTextField(title: 'Email',keyBoardType: TextInputType.emailAddress, Width: screenWidth,controller: email,),
              GenderRadio(context),
              Padding(
                padding: const EdgeInsets.only(left: 15,top: 10),
                child: Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text('Date of Birth',
                    style: Theme.of(context).textTheme.subtitle1,
                   ),
                ),
              ),
              Row(
                children: [
                   MyTextField(title: 'DD',keyBoardType: TextInputType.number, Width: screenWidth*0.20,controller: date,),
                   MyTextField(title: 'MM',keyBoardType: TextInputType.number, Width: screenWidth*0.22,controller: month,),
                   MyTextField(title: 'YYYY',keyBoardType: TextInputType.number, Width: screenWidth*0.30,controller: year,),
                ],
              ),
             MyTextField(title: 'Address',keyBoardType: TextInputType.streetAddress, Width: screenWidth,controller: address,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: button('Submit', context, (){
                  submitDetails();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row GenderRadio(BuildContext context) {
    return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Container(
                  child: Text('Gender',
                  style: Theme.of(context).textTheme.subtitle1),
                ),
                Row(
                    children: [
                      Radio(
                        value: 'M',
                        onChanged: (val){
                          radioValue=val;
                          setState(() {
                            print(radioValue);
                          });
                        },
                        groupValue: radioValue,
                      ),
                      Text('Male',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 14
                        ),),
                      Radio(
                        value: 'F',
                        groupValue: radioValue,
                        onChanged: (val){
                          radioValue=val;
                          setState(() {
                            print(radioValue);
                          });
                        },
                      ),
                      Text('Female',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 14
                        ),),
                      Radio(
                        value: 'O',
                        groupValue: radioValue,
                        onChanged: (val){
                          radioValue=val;
                          setState(() {
                            print(radioValue);
                          });
                        },
                      ),
                      Text('Other',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontSize: 14
                        ),)
                    ],
                  ),

              ],
            );
  }
}

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
  required this.title,
  required this.keyBoardType,
  required this.Width,
    required this.controller,
  }) : super(key: key);

  final String title;
  final TextInputType keyBoardType;
  final double Width;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: Width,
        decoration: BoxDecoration(
          color: textFieldColor,
          border: Border.all(color: buttonBorder,width: 1),
          borderRadius: BorderRadius.circular(10)
        ),
        child: TextField(
          controller: controller,
          keyboardType: keyBoardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: title,
            labelStyle: Theme.of(context).textTheme.subtitle1,
            contentPadding:
            EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
          ),
      ),
    );
  }
}

class Avatar extends StatefulWidget {
  
  const Avatar({
    Key? key,
  }) : super(key: key);

  @override
  _AvatarState createState() => _AvatarState();
}

class _AvatarState extends State<Avatar> {

  @override
  Widget build(BuildContext context) {
   
    return Container(
        child: InkWell(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if(result != null) {
              setState(() {
                File file = File(result.files.single.path!);
                photo = file;
              });
            }
          },
          child: (photo==null)
              ? buildCircleAvatar(AssetImage(profileImg))
              : buildCircleAvatar(FileImage(photo!))
        )
    );
  }
}

AuthController authController = Get.find();

submitDetails()  async {

  if(photo==null || name.text=='' || email.text==''|| date.text==''|| month.text==''|| year.text==''|| address.text==''|| radioValue==null){
    Get.snackbar(
      "Please fill all details",
      "",
      snackPosition: SnackPosition.BOTTOM,
    );
    return;
  }
  UploadTask photopath= uploadPhoto();

 final snapshot= await  photopath.whenComplete(() {});
  final photourl=await snapshot.ref.getDownloadURL();

  authController.firebase.collection('users').doc().set(
    {
      'photourl': photourl,
      'name':name.text,
      'email':email.text,
      'gender':radioValue.toString(),
      'dob':'${date.text}/${month.text}/${year.text}',
      'address':address.text
    }
  );
}

 uploadPhoto(){

      String filename='files/${photo!.path}';
    try {
      final ref = FirebaseStorage.instance.ref(filename);

      UploadTask task = ref.putFile(photo!);

      return task;
    }
    catch(e){
      print(e);
    }
}