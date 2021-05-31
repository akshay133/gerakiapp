import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/images.dart';
import 'package:geraki/constants/strings.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late String firstHalf;

  late String secondHalf;
  final String description =
      "Lorem ipsum dummy text here. It is a dummy text which comes here Flutter is Google’s mobile UI framework for crafting high-quality native interfaces on iOS and Android in record time. Flutter works with existing code, is used by developers and organizations around the world, and is free and open source.";
  bool flag = true;
  @override
  void initState() {
    super.initState();

    if (description.length > 100) {
      firstHalf = description.substring(0, 100);
      secondHalf = description.substring(100, description.length);
    } else {
      firstHalf = description;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
          appname,
          "https://www.history.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTY3MzMwNTQ0NDgzMzEzNDg5/tdih-steve-jobs-gettyimages-101805829.jpg",
          () {},
          () {}),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.016,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: screenHeight * 0.035,
                          width: screenWidth * 0.09,
                          // height: 30,
                          // width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: whiteColor,
                              ),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                "https://www.history.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTY3MzMwNTQ0NDgzMzEzNDg5/tdih-steve-jobs-gettyimages-101805829.jpg"),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              "Location",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://blueandgreentomorrow.com/wp-content/uploads/2017/12/sustainable-roads-motorways.jpg",
                    fit: BoxFit.cover,
                    height: screenHeight * 0.245,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.thumb_up_alt_outlined,
                            )),
                        Text('7'),
                        IconButton(
                            onPressed: () {}, icon: SvgPicture.asset(comment)),
                        Text('7'),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: SvgPicture.asset(share)),
                  ],
                ),
              ),
              if (secondHalf.isEmpty)
                Text(firstHalf,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: headline3Color))
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: headline3Color)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            flag = !flag;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '1 day ago',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              flag ? "read more" : "show less",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: screenHeight * 0.035,
                          width: screenWidth * 0.09,
                          // height: 30,
                          // width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: whiteColor,
                              ),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                "https://www.history.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTY3MzMwNTQ0NDgzMzEzNDg5/tdih-steve-jobs-gettyimages-101805829.jpg"),
                          ),
                        ),
                        SizedBox(
                          width: screenWidth * 0.02,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Username",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              "Location",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {},
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://blueandgreentomorrow.com/wp-content/uploads/2017/12/sustainable-roads-motorways.jpg",
                    fit: BoxFit.cover,
                    height: screenHeight * 0.245,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.thumb_up_alt_outlined,
                            )),
                        Text('7'),
                        IconButton(
                            onPressed: () {}, icon: SvgPicture.asset(comment)),
                        Text('7'),
                      ],
                    ),
                    IconButton(onPressed: () {}, icon: SvgPicture.asset(share)),
                  ],
                ),
              ),
              if (secondHalf.isEmpty)
                Text(firstHalf,
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: headline3Color))
              else
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: headline3Color)),
                      InkWell(
                        onTap: () {
                          setState(() {
                            flag = !flag;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '1 day ago',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text(
                              flag ? "read more" : "show less",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
