import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  final Color color;
  final double size;
  Loader({this.color, this.size});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: size,
        ),
      ),
    );
  }
}
