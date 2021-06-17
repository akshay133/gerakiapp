import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:geraki/controller/navigation_controller.dart';
import 'package:geraki/screens/DspSalooniDasboard.dart';
import 'package:geraki/screens/authority_dashboard.dart';
import 'package:geraki/screens/camera_screen.dart';
import 'package:geraki/screens/dashboard_screen.dart';
import 'package:geraki/screens/dsp_chamba_dashboard.dart';
import 'package:geraki/screens/dsp_dalhousie_dashboard.dart';
import 'package:geraki/screens/feeds_screen.dart';
import 'package:geraki/screens/myTickets_screen.dart';
import 'package:geraki/screens/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenMain extends StatefulWidget {
  @override
  _HomeScreenMainState createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  AuthController controller = Get.find();

  final NavController navController = Get.put(NavController());
  final List bodyContent = [
    DashboardScreen(),
    CameraScreen(),
    MyTicketsScreen(),
    FeedsScreen()
  ];
  late SharedPreferences _prefs;

  bool? authChamba;
  bool? authDalhousie;
  bool? authSaloni;
  bool? isauthority;
  getInstances() async {
    _prefs = await SharedPreferences.getInstance();
    isauthority = _prefs.getBool("authority")!;
    authChamba = _prefs.getBool("chamba")!;
    authDalhousie = _prefs.getBool("dalhousie")!;
    authSaloni = _prefs.getBool("salooni")!;
    if (isauthority == true) {
      Get.offAll(AuthoritiesDashboard());
    } else if (authChamba == true) {
      Get.offAll(DspChambaDashboard());
    } else if (authDalhousie == true) {
      Get.offAll(DspDalhousieDashboard());
    } else if (authSaloni == true) {
      Get.offAll(DspSalooniDashboard());
    } else {
      Get.offAll(WelcomeScreen());
    }
  }

  @override
  void initState() {
    getInstances();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: navController.selectedIndex != 1
      //     ? FloatingActionButton.extended(
      //         onPressed: () {
      //           showmyBottomSheet(context);
      //
      //           //Get.to(KycScreen());
      //         },
      //         icon: SvgPicture.asset(sos),
      //         label: Text(
      //           sostxt,
      //           style: Theme.of(context).textTheme.subtitle2,
      //         ),
      //       )
      //     : null,
      body: Obx(() => Center(
            child: bodyContent.elementAt(navController.selectedIndex),
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            iconSize: screenHeight * 0.035,
            selectedItemColor: primaryColor,
            unselectedItemColor: lightGrey,
            unselectedIconTheme: IconThemeData(size: screenHeight * 0.030),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.grid_view,
                  ),
                  label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.description), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.view_agenda), label: "")
            ],
            currentIndex: navController.selectedIndex,
            onTap: (index) => navController.selectedIndex = index,
          )),
    );
  }
}
