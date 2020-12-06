import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

class StudentUserDetails extends StatefulWidget {
  @override
  _StudentUserDetailsState createState() => _StudentUserDetailsState();
}

class _StudentUserDetailsState extends State<StudentUserDetails> {
  final AuthService _authService = AuthService();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
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
              RoundedButton(
                text: 'SignOut',
                color: HexColor(appSecondaryColour),
                loading: loading,
                onPressed: () async {
                  dynamic result = await _authService.signOut();
                  print(result);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
