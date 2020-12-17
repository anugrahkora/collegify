import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class AnnouncementFromTeacher extends StatefulWidget {
  @override
  _AnnouncementFromTeacherState createState() =>
      _AnnouncementFromTeacherState();
}

class _AnnouncementFromTeacherState extends State<AnnouncementFromTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text("Announcement screen"),
            ],
          ),
        ),
      ),
    );
  }
}
