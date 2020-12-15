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
  String university ='';
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
       appBar: AppBar(
        backgroundColor: HexColor(appPrimaryColour),
        title: HeadingText(
          alignment: Alignment.topLeft,
          text: name,
          color: Colors.black,
        ),
        
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
          child: ImageIcon(
            AssetImage('assets/icons/iconTeacher.png'),
            color:HexColor(appSecondaryColour),
            
          ),
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    
                    RoundedField(
                      label: 'University',
                      text: university.replaceAll('_', ' '),
                      color: Colors.black,
                    ),
                    RoundedField(
                      label: 'College',
                      text: collegeName.replaceAll('_', ' '),
                      color: Colors.black,
                    ),
                    RoundedField(
                      label: 'Department',
                      text: departmentName.replaceAll('_', ' '),
                      color: Colors.black,
                    ),
                    RoundedField(
                      label: 'Course',
                      text: courseName.replaceAll('_', ' '),
                      color: Colors.black,
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
            ],
      ),
        ),
      ),

    );
  }
}
