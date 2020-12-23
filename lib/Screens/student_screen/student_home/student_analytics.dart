import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentAnalytics extends StatefulWidget {
  @override
  _StudentAnalyticsState createState() => _StudentAnalyticsState();
}
//implement charts
class _StudentAnalyticsState extends State<StudentAnalytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(child: Text("student analytics screen")),
            ],
          ),
        ),
      ),
    );
  }
}
