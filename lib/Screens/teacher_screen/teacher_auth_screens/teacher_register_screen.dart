//import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_login_screen.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:collegify/shared/components/dropDownList.dart';

class TeacherRegisterScreen extends StatefulWidget {
  final Function toggleView;

  TeacherRegisterScreen({this.toggleView});
  @override
  _TeacherRegisterScreenState createState() => _TeacherRegisterScreenState();
}

class _TeacherRegisterScreenState extends State<TeacherRegisterScreen> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  String name = '';

  String university;
  String collegeName;
  String departmentName;

  String courseName;

  String email = '';
  String password = '';
  String confirmPassword = '';
  String _message;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                AlertWidget(
                  color: Colors.amber,
                  message: _message,
                  onpressed: () {
                    setState(() {
                      _message = null;
                    });
                  },
                ),
                 SizedBox(
                  height: 15.0,
                ),
                Container(
                  child:Center(
                    child: Image.asset('assets/images/teacher_register_cropped.jpg',
                     width: size.width*0.8,
              height: 200,
              fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
              //    Container(
              //     child: Center(child: Text(
              //     'Register',
              //     style:TextStyle(
              //       fontFamily: 'Qibtiyah',
              //       fontSize: 100,
              //       color: Colors.black

              //     ),
              //      ),
              //   ),
              //   ),
                
              //  Container(
              //     child: Center(child: Text(
              //     'as teacher',
              //     style:TextStyle(
              //       fontFamily: 'Qibtiyah',
              //       fontSize: 40,
              //       color: Colors.black,

              //     ),
              //      ),
              //   ),
              //   ),
                
                DropDownListForUniversityNames(
                  selectedUniversity: university,
                  onpressed: (val) {
                    setState(() {
                      collegeName = null;
                      departmentName = null;
                      courseName = null;
                      university = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                DropdownListForCollegeName(
                  universityName: university,
                  selectedCollegeName: collegeName,
                  onpressed: (val) {
                    setState(() {
                      departmentName = null;
                      courseName = null;
                      collegeName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                //list of departments
                DropDownListForDepartmentName(
                  universityName: university,
                  collegeName: collegeName,
                  selectedDepartmentName: departmentName,
                  onpressed: (val) {
                    setState(() {
                      courseName = null;
                      departmentName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                DropDownListForCourseNames(
                  universityName: university,
                  collegeName: collegeName,
                  departmentName: departmentName,
                  selectedCourseName: courseName,
                  onpressed: (val) {
                    courseName = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Name',
                  validator: (val) => val.isEmpty ? 'Field mandatory' : null,
                  onChanged: (val) {
                    name = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                SizedBox(
                  height: 5.0,
                ),

                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Email',
                  validator: (val) => val.isEmpty ? 'Field mandatory' : null,
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Password',
                  validator: (val) => val.isEmpty ? 'Field mandatory' : null,
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
                    validator: (val) =>
                        val != password ? "passwords does'nt match" : null,
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
                              
                              setState(() {
                                loading = true;
                              });
                              try {
                                dynamic result = await _authService
                                    .teacherregisterWithEmailpasswd(
                                        university,
                                        collegeName,
                                        departmentName,
                                        courseName,
                                        name,
                                        email,
                                        password,
                                        'notVerified');
                                if (result != null) {
                                  print('teacher registered');

                                  loading = false;
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  _message = e.toString();
                                  loading = false;
                                });
                              }
                            }
                          },
                          child: loading
                              ? Loader(
                                  color: HexColor(appSecondaryColour),
                                  size: 20,
                                )
                              : HeadingText(
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
