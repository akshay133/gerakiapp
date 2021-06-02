import 'package:flutter/material.dart';
import 'package:geraki/constants/custome_shapes.dart';
import 'package:geraki/constants/strings.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(feeds, profileUrl!, () {}, () {}),
    );
  }
}
