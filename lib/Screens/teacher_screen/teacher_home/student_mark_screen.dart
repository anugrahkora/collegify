import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentMarkScreen extends StatefulWidget {
  @override
  _StudentMarkScreenState createState() => _StudentMarkScreenState();
}

class _StudentMarkScreenState extends State<StudentMarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(child: Text("Student Mark screen")),
            ],
          ),
        ),
      ),
    );
  }
}
