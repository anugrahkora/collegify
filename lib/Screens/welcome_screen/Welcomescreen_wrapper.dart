import 'package:collegify/Screens/parent_screen/parent_home/parent_home.dart';
import 'package:collegify/Screens/parent_screen/parent_screen_authenticate.dart';
import 'package:collegify/Screens/student_screen/student_home/navigation.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_screen_authenticate.dart';
import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_screen_authenticate.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/teacher_home.dart';
import 'package:collegify/Screens/welcome_screen/body.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/user_type.dart';

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
      return NavigationScreen();
    } else if (user != null && usertype == 2) {
      return TeacherScreen();
    } else if (user != null && usertype == 3) {
      return ParentScreen();
    } else if (usertype == 0) return Body();
    return Body();
  }
}
