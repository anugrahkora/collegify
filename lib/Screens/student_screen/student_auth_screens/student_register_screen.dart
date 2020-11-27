import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/dropDownList.dart';
import 'package:collegify/shared/components/loadingWidget.dart';

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
  String name = '';
  String registrationNumber = '';
  String course = '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String mobileNumber = '';
  int year = 1;
  String _message;
  bool loading = false;
  String role = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loader(color: HexColor(appPrimaryColour))
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
                      DropDownListForInstitutionData(
                        institution: 'college',
                        selectedInstitution: university,
                        onpressed: (val) {
                          university = val;
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      DropdownListForCollegeName(
                        institution: 'college',
                        universityName: university,
                        selectedCollegeName: collegeName,
                        onpressed: (val) {
                          collegeName = val;
                        },
                      ),
                      SizedBox(
                        height: 5.0,
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
                      RoundedInputField(
                        hintText: 'Course',
                        validator: (val) =>
                            val.isEmpty ? 'enter a Course' : null,
                        onChanged: (val) {
                          course = val;
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      DropDownListContainer(
                        data: year,
                        color: Colors.white,
                        onpressed: (value) {
                          setState(() {
                            year = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RoundedInputField(
                        hintText: 'Email',
                        validator: (val) =>
                            val.isEmpty ? 'enter an email' : null,
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
                                setState(() {
                                  loading = true;
                                });
                                print(email);
                                print(password);
                                dynamic result = await _authService
                                    .studentregisterWithEmailpasswd(
                                        email,
                                        password,
                                        name,
                                        course,
                                        year.toString(),
                                        registrationNumber,
                                        'student');
                                if (result != null) {
                                  print("Registered");
                                  setState(() {
                                    loading = false;
                                  });
                                  SharedPreferences usertype =
                                      await SharedPreferences.getInstance();
                                  usertype.setInt('usertype', 1);
                                  print(usertype);
                                } else if (result == null) {
                                  setState(() {
                                    _message = 'Invalid user credentials!';
                                    print(_message);
                                    loading = false;
                                  });
                                }
                              }
                            },
                            child: HeadingText(
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
