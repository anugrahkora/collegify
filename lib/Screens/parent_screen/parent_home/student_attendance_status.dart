import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentAttendanceStatus extends StatefulWidget {
  @override
  _StudentAttendanceStatusState createState() =>
      _StudentAttendanceStatusState();
}

class _StudentAttendanceStatusState extends State<StudentAttendanceStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Attendance screen"),
            ],
          ),
        ),
      ),
    );
  }
}
