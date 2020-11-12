//import 'package:collegify/Screens/student_screen/student_home/student_home.dart';
//import 'package:collegify/Screens/student_screen/student_screen_authenticate.dart';
//import 'package:collegify/Screens/welcome_screen/Welcomescreen_wrapper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:collegify/shared/components/user_type.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentLoginScreen extends StatefulWidget {
  final Function toggleView;

  StudentLoginScreen({
    this.toggleView,
  });

  @override
  _StudentLoginScreenState createState() => _StudentLoginScreenState();
}

final _formkey = GlobalKey<FormState>();

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  String email = '';
  String password = '';
  String _message;
  final AuthService _authService = AuthService();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return loading
        ? Loader(color: HexColor(studentPrimaryColour))
        : Scaffold(
            backgroundColor: HexColor(studentPrimaryColour),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                      ),
                      showAlert(),
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
                        validator: (val) => val.isEmpty
                            ? 'Oops! you left this field empty'
                            : null,
                        onChanged: (val) {
                          email = val;
                        },
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RoundedInputField(
                        hintText: "Password",
                        validator: (val) => val.isEmpty
                            ? 'Oops! you left this field empty'
                            : null,
                        boolean: true,
                        onChanged: (val) {
                          password = val;
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        width: size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            color: Colors.white,
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result = await _authService
                                    .loginWithEmailpasswd(email, password);
                                print(email);
                                print(password);
                                if (result != null) {
                                  print('Logged in');
                                  setState(() {
                                    _message = 'logged in';
                                    print(_message);
                                    loading = false;
                                  });
                                  SharedPreferences userdetails =
                                      await SharedPreferences.getInstance();
                                  userdetails.setInt('usertype', 1);
                                } else if (result == null) {
                                  setState(() {
                                    _message = 'Invalid credentials';
                                    print(_message);
                                    loading = false;
                                  });
                                }

                                // Navigator.pop(context);

                              }
                            },
                            child: Text(
                              'login',
                              style: GoogleFonts.montserrat(
                                  color: HexColor(studentPrimaryColour),
                                  fontSize: 20),
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
                          text: 'register?',
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

  Widget showAlert() {
    if (_message != null) {
      return Container(
        color: Colors.amber,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline_rounded),
            ),
            Expanded(
              child: AutoSizeText(
                _message,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _message = null;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
