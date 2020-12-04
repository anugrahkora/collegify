import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/parent_screen/parent_home/parent_navigation_screen.dart';

import 'package:collegify/Screens/student_screen/student_home/student_navigation.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/navigation.dart';

import 'package:collegify/Screens/welcome_screen/body.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcomescreen extends StatefulWidget {
  @override
  _WelcomescreenState createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    final role = Provider.of<DocumentSnapshot>(context);
    if (user != null) {
      print(role..data()['role']);
      return StudentNavigationScreen();
    }

    return Body();
  }
}
