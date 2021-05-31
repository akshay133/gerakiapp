import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/strings.dart';

class MyTicketsScreen extends StatefulWidget {
  @override
  _MyTicketsScreenState createState() => _MyTicketsScreenState();
}

class _MyTicketsScreenState extends State<MyTicketsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
          mytickets,
          "https://www.history.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTY3MzMwNTQ0NDgzMzEzNDg5/tdih-steve-jobs-gettyimages-101805829.jpg",
          () {},
          () {}),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TabBar(
            unselectedLabelColor: subtitleColor,
            labelColor: headlineColor,
            labelStyle: Theme.of(context).textTheme.headline5,
            tabs: [
              Tab(
                text: pending,
              ),
              Tab(
                text: resolved,
              )
            ],
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: primaryColor,
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListTile(
                  title: Text(
                    'Ticket title here',
                    style: TextStyle(
                        fontWeight: FontWeight.w600, color: headlineColor),
                  ),
                  leading: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://www.environmentalscience.org/wp-content/uploads/2015/01/Roads-300x300.jpg",
                    ),
                  ),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: primaryColor,
                      ),
                      Text(
                        'location',
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            '1 day ago',
                          ),
                        ),
                      ),
                    ],
                  ),
                  minVerticalPadding: 20,
                ),
                Text('Person')
              ],
              controller: _tabController,
            ),
          ),
        ],
      ),
    );
  }
}
