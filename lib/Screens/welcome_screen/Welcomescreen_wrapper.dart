import 'package:collegify/Screens/parent_screen/parent_home/parent_navigation_screen.dart';

import 'package:collegify/Screens/student_screen/student_home/navigation.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/navigation.dart';

import 'package:collegify/Screens/welcome_screen/body.dart';
import 'package:collegify/models/user_model.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcomescreen extends StatefulWidget {
  @override
  _WelcomescreenState createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
  int usertype;

  Future<void> checkUserType() async {
    SharedPreferences userDetails = await SharedPreferences.getInstance();
    setState(() {
      usertype = userDetails.getInt('usertype') ?? 0;
    });

    print(usertype);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await checkUserType());

    final user = Provider.of<UserModel>(context, listen: false);
    if (user != null && usertype == 1) {
      // Navigator.pushReplacementNamed(context, '/StudentHome');
      return StudentNavigationScreen();
    } else if (user != null && usertype == 2) {
      return TeacherNavigationScreen();
    } else if (user != null && usertype == 3) {
      return ParentNavigationScreen();
    } else if (usertype == 0) return Body();
    return Body();
  }
}
