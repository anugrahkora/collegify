import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherLoginScreen extends StatefulWidget {
  final Function toggleView;
  TeacherLoginScreen({this.toggleView});
  @override
  _TeacherLoginScreenState createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  //SharedPreferences usertype;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(teacherPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              HeadingText(
                text: 'Login',
                size: 60.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 25.0,
              ),
              RoundedInputField(
                hintText: "Email",
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: "Password",
                boolean: true,
                onChanged: (val) {},
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                text: 'Login',
                color: Colors.white,
                textColor: HexColor(teacherPrimaryColour),
                press: () {
                  Navigator.pushReplacementNamed(
                      context, '/teacherNavigationScreen');
                  // usertype.setInt('usertype', 2);
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  widget.toggleView();
                },
                child: HeadingText(
                  text: 'register?',
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
