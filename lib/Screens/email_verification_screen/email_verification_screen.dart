import 'dart:async';

import 'package:collegify/Screens/welcome_screen/role_check.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailVerifyScreen extends StatefulWidget {
  @override
  _EmailVerifyScreenState createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final _auth = FirebaseAuth.instance;
  User user;
  Timer timer;

  @override
  void initState() {
    user = _auth.currentUser;
    user.reload();
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final _userObject = Provider.of<UserModel>(context);
    return Scaffold(
      body: SafeArea(
          child: HeadingText(
              alignment: Alignment.center,
              text: 'An email has been sent to ${_auth.currentUser.email}',
              size: 25.0,
              color: Colors.black)),
    );
  }

  Future<void> checkVerified() async {
    user = _auth.currentUser;
    user.reload();
    if (user.emailVerified) {
      timer.cancel();
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => RoleCheck()));
     }


    return RoleCheck();
  }
}
