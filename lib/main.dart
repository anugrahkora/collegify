import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/admin_screen/admin_home.dart';
import 'package:collegify/Screens/admin_screen/admin_navigation.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Teacher_Navigation.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:flutter/material.dart';
import 'Screens/parent_screen/parent_home/parent_navigation_screen.dart';
import 'Screens/welcome_screen/role_check.dart';
import 'package:collegify/Screens/parent_screen/parent_auth_screens/parent_register_screen.dart';
//import 'package:collegify/Screens/parent_screen/parent_screen_authenticate.dart';
import 'package:collegify/Screens/student_screen/student_home/student_navigation.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_register_screen.dart';
//import 'package:collegify/Screens/student_screen/student_auth_screens/student_screen_authenticate.dart';
import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_register_screen.dart';
//import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_screen_authenticate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(InitializeMyapp());
}

class InitializeMyapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel>(
          create: (context) => AuthService().user,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RoleCheck(),
        routes: {
          '/studentRegisterScreen': (context) => StudentRegisterScreen(),
          '/parentNavigationScreen': (context) => ParentNavigationScreen(),
          '/parentRegisterScreen': (context) => ParentRegisterScreen(),
          '/studentNavigationScreen': (context) => StudentNavigationScreen(),
          '/teacherNavigationScreen': (context) => TeacherNavigationScreen(),
          '/adminHome': (context) => AdminHome(),
        },
      ),
    );
  }
}
