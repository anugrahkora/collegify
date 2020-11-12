import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  final Color color;
  Loader({this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
