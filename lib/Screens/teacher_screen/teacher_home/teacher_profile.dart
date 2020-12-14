import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/models/user_model.dart';

import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class TeacherProfileScreen extends StatefulWidget {
  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  bool loading = false;
  String name = '';
  String university = '';
  String collegeName = '';
  String departmentName = '';
  String courseName = '';
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((docs) {
        if (docs.data().isNotEmpty) {
          if(
            this.mounted
          ){setState(() {
            name = docs.data()['Name'] ?? '----';
            university = docs.data()['University'] ?? '----';
            collegeName = docs.data()['College'] ?? '----';
            departmentName = docs.data()['Department'] ?? '----';
            courseName = docs.data()['Course'] ?? '----';
          });
          }
        }
      });
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              HeadingText(
                text: name,
                size: 20.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadingText(
                text: university.replaceAll('_', ' '),
                size: 10.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadingText(
                text: collegeName.replaceAll('_', ' '),
                size: 10.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadingText(
                text: departmentName.replaceAll('_', ' '),
                size: 10.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadingText(
                text: courseName.replaceAll('_', ' '),
                size: 10.0,
                color: HexColor(appSecondaryColour),
              ),
              RoundedButton(
                text: 'SignOut',
                color: HexColor(appSecondaryColour),
                loading: loading,
                onPressed: () async {
                  loading = true;
                  await _authService.signOut();
                  // dispose();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
