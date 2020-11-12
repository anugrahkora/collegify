import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_login_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_register_screen.dart';
import 'package:flutter/material.dart';

class TeacherScreen extends StatefulWidget {
  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  bool showLogin = true;
  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final _userType = UserType().userType;
    // final user = Provider.of<UserModel>(context);
    if (showLogin) {
      return TeacherLoginScreen(
        toggleView: toggleView,
      );
    } else
      return TeacherRegisterScreen(
        toggleView: toggleView,
      );
  }
}
