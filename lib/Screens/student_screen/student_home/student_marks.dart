import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentMarks extends StatefulWidget {
  @override
  _StudentMarksState createState() => _StudentMarksState();
}

class _StudentMarksState extends State<StudentMarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Student Mark screen"),
            ],
          ),
        ),
      ),
    );
  }
}
