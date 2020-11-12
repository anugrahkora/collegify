import 'package:collegify/Screens/student_screen/student_home/navigation.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_login_screen.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_register_screen.dart';
import 'package:collegify/Screens/welcome_screen/Welcomescreen_wrapper.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/user_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
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
      return StudentLoginScreen(
        toggleView: toggleView,
      );
    } else
      return StudentRegisterScreen(
        toggleView: toggleView,
      );
  }
}
