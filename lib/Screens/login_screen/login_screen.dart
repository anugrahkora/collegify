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
                  height: 25.0,
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
                // Container(
                //   child: Center(child: Text(
                //   'Collegify',
                //   style:TextStyle(
                //     fontFamily: 'Qibtiyah',
                //     fontSize: 100,
                //     color: Colors.black,

                //   ),
                //    ),
                // ),
                // ),
                Container(
                  child:Center(
                    child: Image.asset('assets/images/collegify_cropped.jpg',
                     width: size.width*0.8,
              height: 150,
              fit: BoxFit.contain,
                    ),
                  ),
                
                ),
                SizedBox(
                  height: 20.0,
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
                  validator: (val) =>
                      val.isEmpty ? "Can't be empty" : null,
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
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(6,2),
            blurRadius: 6.0,
            spreadRadius: 3.0
          ),
           BoxShadow(
            color: Color.fromRGBO(85,217, 193, 0.9),
            offset: Offset(-6,-2),
            blurRadius: 6.0,
            spreadRadius: 3.0
          ),
        ],borderRadius: BorderRadius.circular(29),),
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
                              loading = true;
                            });
                            dynamic result = await _authService
                                .loginWithEmailpasswd(email, password);
                            print(email);
                            print(password);
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
                  height: 25,
                ),
                InkWell(
                  child: Text(
                    "Forgot password?",
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontSize: 15),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
