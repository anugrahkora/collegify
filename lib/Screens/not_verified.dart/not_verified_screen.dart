import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NotVerifiedScreen extends StatefulWidget {
  @override
  _NotVerifiedScreenState createState() => _NotVerifiedScreenState();
}

class _NotVerifiedScreenState extends State<NotVerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(appPrimaryColour),
          body: Container(
            child: Column(
              children: <Widget>[
                HeadingText(
                  text: "Please wait until you are authorized",
                  size: 40.0,
                  color: Colors.white,
                ),
                SizedBox(height: 30),
                Loader(
                  color: HexColor(appPrimaryColour),
                  size: 30.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
