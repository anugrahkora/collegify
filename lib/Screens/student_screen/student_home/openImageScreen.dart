import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class OpenImage extends StatelessWidget {
  final String imageUrl;
  final String imageName;

  const OpenImage({Key key, this.imageUrl, this.imageName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(appPrimaryColour),
        title: HeadingText(
          alignment: Alignment.topLeft,
          text: imageName,
          color: Colors.black,
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Image.network(imageUrl),
        ),
      ),
    );
  }
}
