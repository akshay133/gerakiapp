import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/strings.dart';
import 'package:geraki/controller/auth_controller.dart';
import 'package:geraki/controller/navigation_controller.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthController controller = Get.find();

  bool isExpanded = false;
  final NavController navController = Get.put(NavController());
  final List bodyContent = [
    Text("dfdf"),
    Text('sds'),
    Text('fdf'),
    Text('fdg')
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        centerTitle: true,
        title: Text(
          appname,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: whiteColor,
                ),
                shape: BoxShape.circle),
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                  "https://miro.medium.com/max/759/1*YQNS4UzYLRO0CumGdIfU9g.jpeg"),
            ),
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_none))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        icon: isExpanded ? SvgPicture.asset(sos) : null,
        label: isExpanded
            ? Text(
                sostxt,
                style: Theme.of(context).textTheme.subtitle2,
              )
            : SvgPicture.asset(sos),
      ),
      body: Obx(() => Center(
            child: bodyContent.elementAt(navController.selectedIndex),
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
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
