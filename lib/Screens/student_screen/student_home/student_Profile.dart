import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/models/user_model.dart';

import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class StudentUserDetails extends StatefulWidget {
  @override
  _StudentUserDetailsState createState() => _StudentUserDetailsState();
}

class _StudentUserDetailsState extends State<StudentUserDetails> {
  final AuthService _authService = AuthService();
  bool loading = false;
  String name = '';
  String university = '';
  String collegeName = '';
  String departmentName = '';
  String courseName = '';
  String year = '';
  String registrationNumber = '';
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
          if(this.mounted){

            setState(() {
            name = docs.data()['Name']?? '-----';
            university = docs.data()['University']?? '-----';
            collegeName = docs.data()['College']?? '-----';
            departmentName = docs.data()['Department']?? '-----';
            courseName = docs.data()['Course']?? '-----';
            year = docs.data()['Current_Year']?? '-----';
          });
          }
          
        }
      });
    }
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
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
                size: 15.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadingText(
                text: departmentName.replaceAll('_', ' '),
                size: 15.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadingText(
                text: courseName.replaceAll('_', ' '),
                size: 15.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadingText(
                text: year,
                size: 15.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 10.0,
              ),
              HeadingText(
                text: registrationNumber,
                size: 15.0,
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 40.0,
              ),
              RoundedButton(
                text: 'SignOut',
                color: HexColor(appSecondaryColour),
                loading: loading,
                onPressed: () async {
                  loading = true;

                  await _authService.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
