import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TeacherProfileScreen extends StatefulWidget {
  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  bool loading = false;
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RoundedButton(
              text: 'SignOut',
              color: HexColor(appSecondaryColour),
              loading: loading,
              onPressed: () async {
                dynamic result = await _authService.signOut();
                print(result);
              },
            )
          ],
        ),
      ),
    );
  }
}
