import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/admin_screen/admin_navigation.dart';
import 'package:collegify/Screens/parent_screen/parent_home/parent_navigation_screen.dart';

import 'package:collegify/Screens/student_screen/student_home/student_navigation.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Teacher_Navigation.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/teacher_Classes.dart';

import 'package:collegify/Screens/welcome_screen/body.dart';
import 'package:collegify/database/databaseService.dart';

import 'package:collegify/models/user_model.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class RoleCheck extends StatefulWidget {
  @override
  _RoleCheckState createState() => _RoleCheckState();
}

class _RoleCheckState extends State<RoleCheck> {
  String role;
  DocumentSnapshot documentSnapshot;
//  dynamic docs;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    // docs = DatabaseService(uid: user.uid).getDocument();
    //User _verifiedUser = _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then((docs) {
        if (docs.exists && docs.data().isNotEmpty) {
          setState(() {
            role = docs.data()['Role'];
            documentSnapshot = docs;
          });
        }
      });
      if (role == 'student') {
        return StudentNavigationScreen(documentSnapshot: documentSnapshot,);
      } else if (role == 'teacher') {
        return TeacherNavigationScreen(documentSnapshot: documentSnapshot,);
      } else if (role == 'admin') {
        return AdminNavigationScreen();
      } else if (role == 'notVerified') {
        return TeacherNavigationScreen();
      } else if (role == 'parent') {
        return ParentNavigationScreen();
      }
    }
    return Body();
  }
}
