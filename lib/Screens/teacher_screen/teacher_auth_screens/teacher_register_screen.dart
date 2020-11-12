import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_login_screen.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherRegisterScreen extends StatefulWidget {
  final Function toggleView;

  TeacherRegisterScreen({this.toggleView});
  @override
  _TeacherRegisterScreenState createState() => _TeacherRegisterScreenState();
}

class _TeacherRegisterScreenState extends State<TeacherRegisterScreen> {
  //SharedPreferences usertype;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor(teacherPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 38.0,
              ),
              HeadingText(
                text: 'Register',
                size: 60.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 30.0,
              ),
              RoundedInputField(
                hintText: 'Name',
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: 'Department',
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: 'Email',
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: 'Password',
                boolean: true,
                onChanged: (val) {},
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        color: Colors.white,
                        onPressed: () async {
                          SharedPreferences usertype =
                              await SharedPreferences.getInstance();
                          usertype.setInt('usertype', 2);
                        },
                        child: HeadingText(
                          color: HexColor(studentPrimaryColour),
                          text: 'Register',
                          size: 12.0,
                        ),
                      ))),
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  widget.toggleView();
                },
                child: HeadingText(
                  text: 'Already registered?',
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
