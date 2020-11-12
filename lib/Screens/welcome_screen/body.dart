import 'package:collegify/Screens/parent_screen/parent_screen_authenticate.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_screen_authenticate.dart';
import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_screen_authenticate.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  SharedPreferences userdetails;
  int _userRole = 0;
  @override
  Widget build(BuildContext context) {
    if (_userRole == 1) {
      return StudentScreen();
    } else if (_userRole == 2) {
      return TeacherScreen();
    } else if (_userRole == 3) {
      return ParentScreen();
    }
    return Scaffold(
      backgroundColor: HexColor(welcomePrimaryColour),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 38.0,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  HeadingText(
                    text: 'Welcome.',
                    size: 65.0,
                    color: HexColor(teacherPrimaryColour),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  HeadingText(
                    text: 'Select the user',
                    size: 25.0,
                    color: HexColor(parentPrimaryColour),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 140.0,
            ),
            RoundedButton(
              text: 'Student',
              color: HexColor(studentPrimaryColour),
              textColor: Colors.white,
              route: '/studentScreen',
              press: () {
                setState(() {
                  _userRole = 1;
                });
              },
            ),
            RoundedButton(
              text: 'Teacher',
              color: HexColor(teacherPrimaryColour),
              textColor: Colors.white,
              route: '/teacherScreen',
              press: () {
                setState(() {
                  _userRole = 2;
                });
              },
            ),
            RoundedButton(
              text: 'Parent',
              route: '/parentScreen',
              color: HexColor(parentPrimaryColour),
              textColor: Colors.white,
              press: () {
                setState(() {
                  _userRole = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
