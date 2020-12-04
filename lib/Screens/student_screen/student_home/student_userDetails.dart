import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/welcome_screen/Welcomescreen_wrapper.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

class StudentUserDetails extends StatefulWidget {
  @override
  _StudentUserDetailsState createState() => _StudentUserDetailsState();
}

class _StudentUserDetailsState extends State<StudentUserDetails> {
  @override
  Widget build(BuildContext context) {
    //final studentUsers = Provider.of<DocumentSnapshot>(context);
    //print(userDetails);
    // for (var doc in studentUsers.docs) {
    //   print(doc.data());
    // }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
              ),
              Center(
                child: Text("student home"),
              ),
              SizedBox(
                height: 80,
              ),
              RoundedAuthButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedAuthButton extends StatefulWidget {
  @override
  _RoundedAuthButtonState createState() => _RoundedAuthButtonState();
}

class _RoundedAuthButtonState extends State<RoundedAuthButton> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                color: Colors.white,
                onPressed: () async {
                  dynamic result = await _authService.signOut();
                  print(result);

                  // Navigator.of(context).pushAndRemoveUntil(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) {
                  //       return Welcomescreen();
                  //    },
                  //  ),
                  //  (_) => false,
                  // );
                },
                child: Text(
                  'Signout',
                  style: GoogleFonts.montserrat(
                      color: HexColor(studentPrimaryColour), fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
