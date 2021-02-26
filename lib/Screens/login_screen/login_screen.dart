import 'package:collegify/Screens/Forgot_password/forgot_password_screen.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

final _formkey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  String _message;
  final AuthService _authService = AuthService();
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
              children: <Widget>[
                SizedBox(
                  height: 35.0,
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
                  height: 10.0,
                ),
                Container(
                  child: Center(
                    child: HeadingText(
                      text: "Collegify",
                      size: 70.0,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                RoundedInputField(
                  hintText: "email",
                  validator: (val) =>
                      val.isEmpty ? 'Oops! you left this field empty' : null,
                  onChanged: (val) {
                    email = val;
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                RoundedInputField(
                  hintText: "password",
                  validator: (val) => val.isEmpty ? "Can't be empty" : null,
                  boolean: true,
                  onChanged: (val) {
                    password = val;
                  },
                ),
                SizedBox(
                  height: 25.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: HexColor(appPrimaryColour),
                  ),
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 18, horizontal: 40),
                      color: HexColor(appSecondaryColour),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          try {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authService
                                .loginWithEmailpasswd(email, password);

                            if (result != null) {
                              print('user Logged in');

                              loading = false;
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
                              spinnerColor: Colors.white,
                              color: HexColor(appSecondaryColour),
                              size: 20.0,
                            )
                          : Text(
                              'login',
                              style: GoogleFonts.montserrat(
                                  color: Colors.white, fontSize: 18),
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  child: Text(
                    "Forgot password?",
                    style: GoogleFonts.montserrat(
                        color: Colors.black54, fontSize: 15),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen(),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
