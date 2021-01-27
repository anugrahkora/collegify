import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/dropDownList.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentRegisterScreen extends StatefulWidget {
  StudentRegisterScreen();
  @override
  _StudentRegisterScreenState createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  final AuthService _authService = AuthService();

  final _formkey =
      GlobalKey<FormState>(); // this is used for validation purpose
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
  bool universityLoading = true;
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
                  height: 40.0,
                ),

                Container(
                  child: Center(
                    child: ImageIcon(
                      AssetImage('assets/icons/iconStudentLarge.png'),
                      color: Colors.black54,
                      size: 70,
                    ),
                    // HeadingText(
                    //   text: "student",
                    //   size: 50.0,
                    //   color: Colors.black54,
                    // ),
                    //       Image.asset('assets/images/collegify_cropped.jpg',
                    //        width: size.width*0.8,
                    // height: 150,
                    // fit: BoxFit.contain,
                    //       ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),

                //list of universities
                DropDownListForUniversityNames(
                  selectedUniversity: university,
                  onpressed: (val) {
                    setState(() {
                      universityLoading = false;
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

                DropDownListForYearData(
                    universityName: university,
                    collegeName: collegeName,
                    departmentName: departmentName,
                    courseName: courseName,
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
                  validator: (val) =>
                      val.isEmpty ? 'Please enter a valid email' : null,
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                    hintText: 'Password',
                    validator: (val) => val.length < 6
                        ? 'provide a password 6 character long'
                        : null,
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
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: HexColor(appSecondaryColour),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          if (university != null &&
                              collegeName != null &&
                              departmentName != null &&
                              courseName != null &&
                              year != null) {
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
                                name.trim(),
                                registrationNumber.trim(),
                                'student',
                                email.trim().trim(),
                                password,
                              );
                              if (result != null) {
                                print('registered');
                              } else {
                                setState(() {
                                  loading = false;
                                  _message = 'error';
                                });
                              }
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                _message = e.message.toString();
                                loading = false;
                              });
                            }
                          } else {
                            setState(() {
                              _message = 'please select your insitution data';
                            });
                          }
                        }
                      },
                      child: loading
                          ? Loader(
                              spinnerColor: Colors.white,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
