import 'package:flutter/material.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/strings.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
          feeds,
          "https://www.history.com/.image/ar_4:3%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTY3MzMwNTQ0NDgzMzEzNDg5/tdih-steve-jobs-gettyimages-101805829.jpg",
          () {},
          () {}),
    );
  }
}
