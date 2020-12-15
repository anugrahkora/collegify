import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double size;
  final Color spinnerColor;
  Loader({this.color, this.size, this.spinnerColor:Colors.white});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: SpinKitFadingCircle(
          color: spinnerColor,
          size: size,
        ),
      ),
    );
  }
}
