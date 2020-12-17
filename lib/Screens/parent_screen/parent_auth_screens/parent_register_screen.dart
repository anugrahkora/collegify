//import 'package:collegify/Screens/parent_screen/parent_login_screen.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/dropDownList.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class ParentRegisterScreen extends StatefulWidget {
  @override
  _ParentRegisterScreenState createState() => _ParentRegisterScreenState();
}

class _ParentRegisterScreenState extends State<ParentRegisterScreen> {
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;
  String _university;
  String _collegeName;
  String _departmentName;

  String _courseName;

  String _parentName = '';
  String _wardName = '';
  String _registrationNumber = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _message;
  final AuthService _authService = AuthService();
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
                  child: Center(
                    child: Image.asset(
                      'assets/images/parent_register_cropped.jpg',
                      width: size.width * 0.8,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                DropDownListForUniversityNames(
                  selectedUniversity: _university,
                  onpressed: (val) {
                    setState(() {
                      _collegeName = null;
                      _departmentName = null;
                      _courseName = null;
                      _university = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                DropdownListForCollegeName(
                  universityName: _university,
                  selectedCollegeName: _collegeName,
                  onpressed: (val) {
                    setState(() {
                      _departmentName = null;
                      _courseName = null;
                      _collegeName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                DropDownListForDepartmentName(
                  universityName: _university,
                  collegeName: _collegeName,
                  selectedDepartmentName: _departmentName,
                  onpressed: (val) {
                    setState(() {
                      _courseName = null;
                      _departmentName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                DropDownListForCourseNames(
                  universityName: _university,
                  collegeName: _collegeName,
                  departmentName: _departmentName,
                  selectedCourseName: _courseName,
                  onpressed: (val) {
                    setState(() {
                      _courseName = val;
                    });
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Parent name',
                  validator: (val) =>
                      val.isEmpty ? 'This field is mandatory' : null,
                  onChanged: (val) {
                    _parentName = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Ward name',
                  validator: (val) =>
                      val.isEmpty ? 'This field is mandatory' : null,
                  onChanged: (val) {
                    _wardName = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Register number',
                  validator: (val) =>
                      val.length == 10 ? null : 'enter a vald number',
                  onChanged: (val) {
                    _registrationNumber = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: 'Email',
                  validator: (val) => val.isEmpty ? 'enter an email' : null,
                  onChanged: (val) {
                    _email = val;
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
                      _password = val;
                    }),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                    hintText: 'Confirm Password',
                    validator: (val) => _confirmPassword != _password
                        ? "passwords does'nt match"
                        : null,
                    boolean: true,
                    onChanged: (val) {
                      _confirmPassword = val;
                    }),


                    Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                      color: HexColor(appSecondaryColour),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          try {
                            setState(() {
                              _loading = true;
                            });
                            dynamic result = await _authService
                                .parentRegisterWithEmailPassword(
                              _university,
                              _collegeName,
                              _departmentName,
                              _courseName,
                            
                              _parentName,
                              _wardName,
                              _registrationNumber,
                              'parent',
                              _email,
                              _password,
                            );
                            if (result != null) {
                              print('parent registred  in');

                              _loading = false;
                            } else {
                              
                                _loading = false;
                              
                            }
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              _message = e.message.toString();
                              _loading = false;
                            });
                          }
                        }
                      },
                      child: _loading
                          ? Loader(
                              color: HexColor(appSecondaryColour),
                              size: 20.0,
                            )
                          : Text(
                              'Register',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 18),
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
