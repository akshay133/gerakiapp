import 'package:firebase_auth/firebase_auth.dart';
import 'package:geraki/screens/home_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var authState = ''.obs;
  String verificationID = '';
  var auth = FirebaseAuth.instance;
  verifyPhone(String phone) async {
    try {
      await auth.verifyPhoneNumber(
          timeout: Duration(seconds: 40),
          phoneNumber: phone,
          verificationCompleted: (AuthCredential authCredential) {},
          verificationFailed: (authException) {
            Get.snackbar("error", authException.message.toString());
          },
          codeSent: (String id, [int? forceResent]) {
            this.verificationID = id;
            authState.value = "Login Success";
          },
          codeAutoRetrievalTimeout: (id) {
            this.verificationID = id;
          });
    } catch (e) {
      print("error$e");
      Get.snackbar("Phone Number info!", "Something went wrong");
    }
  }

  verifyOTP(String otp) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationID, smsCode: otp));
      if (credential.user != null) {
        Get.snackbar("otp info", "Verified",
            snackPosition: SnackPosition.BOTTOM);
        Get.to(HomeScreen());
      }
    } catch (e) {
      print("error$e");

      Get.snackbar("otp info", "otp code is not correct!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
