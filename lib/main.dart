
import 'package:collegify/authentication/auth_service.dart';

import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Screens/welcome_screen/role_check.dart';


import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


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
        
        debugShowCheckedModeBanner: false,
        home: RoleCheck(),
        
        
      ),
    );
  }
}


