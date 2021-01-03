
import 'package:collegify/authentication/auth_service.dart';

import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Screens/welcome_screen/role_check.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: HexColor(appPrimaryColour), // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(InitializeMyapp());
}

class InitializeMyapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  
    return StreamProvider<UserModel>.value(
      
      value: AuthService().user,
      child: MaterialApp(
        color: HexColor(appPrimaryColour),
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: 
        AnimatedSplashScreen(
          nextScreen: RoleCheck(),
          splash: Container(
            child: Center(
              child: Image.asset(
                'assets/images/collegify_cropped.jpg',
                width:600.0,
                height: 450.0,
                fit: BoxFit.contain,
              ),
            ),
          ),
          backgroundColor: HexColor(appPrimaryColour),
          centered: true,
          splashTransition: SplashTransition.fadeTransition,
          splashIconSize: 100.0,
        ),
        
      ),
    );
  }
}


