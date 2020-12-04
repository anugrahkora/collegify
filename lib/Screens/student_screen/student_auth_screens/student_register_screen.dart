import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/dropDownList.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentRegisterScreen extends StatefulWidget {
  final Function toggleView;
  final String message;
  StudentRegisterScreen({this.toggleView, this.message});
  @override
  _StudentRegisterScreenState createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  final AuthService _authService = AuthService();

  final _formkey = GlobalKey<FormState>();
  String university;
  String collegeName;
  String departmentName;

  String courseName;
  String name = '';
  String registrationNumber = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  String year;
  String _message;
  bool loading = false;
  String role = '';
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
                  message: _message,
                  onpressed: () {
                    setState(() {
                      _message = null;
                    });
                  },
                ),
                HeadingText(
                  text: 'Register',
                  size: 70.0,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 6.0,
                ),
                HeadingText(
                  text: 'as student.',
                  size: 23.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 30.0,
                ),
                //list of universities
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
                // list of colleges
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
                    setState(() {
                      courseName = val;
                      year = null;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Name',
                  validator: (val) =>
                      val.isEmpty ? 'This field is mandatory' : null,
                  onChanged: (val) {
                    name = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Registration number',
                  validator: (val) => val.length == 10
                      ? null
                      : 'enter a valid registration number',
                  onChanged: (val) {
                    registrationNumber = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),

                SizedBox(
                  height: 5.0,
                ),
                DropDownListForYearData(
                    universityName: university,
                    collegeName: collegeName,
                    departmentName: departmentName,
                    selectedYear: year,
                    onpressed: (val) {
                      setState(() {
                        year = val;
                      });
                    }),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Email',
                  validator: (val) => val.isEmpty ? 'enter an email' : null,
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
                        val.isEmpty ? 'atleast provide a password' : null,
                    boolean: true,
                    onChanged: (val) {
                      password = val;
                    }),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                    hintText: 'Confirm Password',
                    validator: (val) => confirmPassword != password
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
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: HexColor(appSecondaryColour),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          try {
                            setState(() {
                              loading = true;
                            });
                            print(email);
                            print(password);
                            dynamic result = await _authService
                                .studentregisterWithEmailpasswd(
                              university,
                              collegeName,
                              departmentName,
                              courseName,
                              year,
                              name,
                              registrationNumber,
                              'student',
                              email,
                              password,
                            );
                            if (result != null) {
                              SnackBar(
                                content: Text('User successfully registered'),
                              );
                              // dynamic role =
                              //     await _authService.currentUserClaims;
                              // print(role);
                              setState(() {
                                loading = false;
                              });
                            } else {
                              setState(() {
                                loading = false;
                              });
                            }
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              _message = e.message.toString();
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
                    ),
                  ),
                ),
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
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
