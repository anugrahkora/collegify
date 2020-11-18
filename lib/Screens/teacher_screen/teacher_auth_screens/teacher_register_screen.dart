//import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_login_screen.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
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
  final _formkey = GlobalKey<FormState>();
  String name = '';
  String department = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loader(
            color: HexColor(appPrimaryColour),
          )
        : Scaffold(
            backgroundColor: HexColor(appPrimaryColour),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
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
                        validator: (val) =>
                            val.isEmpty ? 'Field mandatory' : null,
                        onChanged: (val) {
                          name = val;
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RoundedInputField(
                        hintText: 'Department',
                        validator: (val) =>
                            val.isEmpty ? 'Field mandatory' : null,
                        onChanged: (val) {
                          department = val;
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RoundedInputField(
                        hintText: 'Email',
                        validator: (val) =>
                            val.isEmpty ? 'Field mandatory' : null,
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RoundedInputField(
                        hintText: 'Password',
                        validator: (val) =>
                            val.isEmpty ? 'Field mandatory' : null,
                        boolean: true,
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RoundedInputField(
                          hintText: 'Confirm Password',
                          validator: (val) => val != password
                              ? "passwords does'nt match"
                              : null,
                          boolean: true,
                          onChanged: (val) {
                            confirmPassword = val;
                          }),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          width: size.width * 0.8,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(29),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 40),
                                color: HexColor(appSecondaryColour),
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    SharedPreferences usertype =
                                        await SharedPreferences.getInstance();
                                    usertype.setInt('usertype', 2);
                                  }
                                },
                                child: HeadingText(
                                  color: Colors.white,
                                  text: 'Register',
                                  size: 16.0,
                                ),
                              ))),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
