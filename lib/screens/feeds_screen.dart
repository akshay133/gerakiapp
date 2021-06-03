import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geraki/constants/colors.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/dimestions.dart';
import 'package:geraki/constants/strings.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:readmore/readmore.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(feeds, profileUrl!, () {}, () {}),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('feeds').snapshots(),
            builder: (context,snapshot) {
               if (!snapshot.hasData) {
                return SpinKitCircle(
                color: primaryColor,
                size: 50,
              );
            }
            return Container(
              child: SingleChildScrollView(
                 child: ConstrainedBox(
                   constraints: BoxConstraints(
                      maxHeight: screenHeight,
                       minWidth: screenWidth),
                  child: Container(
                    child: Swiper(
                      //itemHeight: screenHeight,
                      itemWidth: screenWidth,
                      //layout: SwiperLayout.STACK,
                      pagination: SwiperPagination(
                          alignment: Alignment.topCenter,
                          builder: SwiperPagination.dots),
                      // //control: new SwiperControl(),
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CachedNetworkImage(
                              imageUrl: ds["feedImgUrl"],
                              height: screenHeight*0.55,
                              width: screenWidth,
                              fit: BoxFit.fill,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                              child: Text(
                                ds["feedTitle"],
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.headline5!.copyWith(
                                fontSize: 20
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
                              child: ReadMoreText(ds["feedDesc"],
                                  trimLines: 2,
                                  colorClickableText: Colors.pink,
                                  trimMode: TrimMode.Line,
                                  trimCollapsedText: '...Read more',
                                  trimExpandedText: ' Less',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: headline3Color)),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          }),
          )
    );
  }
}
