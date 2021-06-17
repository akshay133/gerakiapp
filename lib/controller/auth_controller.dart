import 'package:firebase_auth/firebase_auth.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/screens/DspSalooniDasboard.dart';
import 'package:geraki/screens/authority_dashboard.dart';
import 'package:geraki/screens/dsp_chamba_dashboard.dart';
import 'package:geraki/screens/dsp_dalhousie_dashboard.dart';
import 'package:geraki/screens/home_screen_main.dart';
import 'package:geraki/screens/profile_setup.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var authState = ''.obs;
  String verificationID = '';
  var auth = FirebaseAuth.instance;
  late SharedPreferences _prefs;

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
            Get.snackbar("code send", "");
          },
          codeAutoRetrievalTimeout: (id) {
            this.verificationID = id;
          });
    } catch (e) {
      print("error$e");
      Get.snackbar("Phone Number info!", "Something went wrong");
    }
  }

  verifyOTP(String otp, String screen) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationID, smsCode: otp));
      if (credential.user != null) {
        Get.snackbar("otp info", "Verified",
            snackPosition: SnackPosition.BOTTOM);
        if (screen == signup) {
          Get.offAll(ProfileSetup(), transition: Transition.cupertino);
        } else {
          Get.offAll((HomeScreenMain()), transition: Transition.cupertino);
        }
      }
    } catch (e) {
      print("error$e");

      Get.snackbar("otp info", "otp code is not correct!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  login(String email, String password) async {
    _prefs = await SharedPreferences.getInstance();
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar("Login", "Success", snackPosition: SnackPosition.BOTTOM);
        if (email.contains("authority")) {
          _prefs.setBool('authority', true).then((value) {
            Get.offAll(AuthoritiesDashboard());
          });
          _prefs.setBool('chamba', false);
          _prefs.setBool('dalhousie', false);
          _prefs.setBool('salooni', false);
        } else if (email.contains("dspchamba")) {
          _prefs.setBool('chamba', true).then((value) {
            Get.offAll(DspChambaDashboard());
          });
          _prefs.setBool('authority', false);
          _prefs.setBool('dalhousie', false);
          _prefs.setBool('salooni', false);
        } else if (email.contains("dspdalhousie")) {
          _prefs.setBool('dalhousie', true).then((value) {
            Get.offAll(DspDalhousieDashboard());
          });
          _prefs.setBool('authority', false);
          _prefs.setBool('chamba', false);
          _prefs.setBool('salooni', false);
        } else if (email.contains("dspsalooni")) {
          _prefs.setBool('salooni', true).then((value) {
            Get.offAll(DspSalooniDashboard());
          });
          _prefs.setBool('authority', false);
          _prefs.setBool('chamba', false);
          _prefs.setBool('dalhousie', false);
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
