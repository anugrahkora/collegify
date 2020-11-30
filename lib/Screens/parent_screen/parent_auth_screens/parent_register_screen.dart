//import 'package:collegify/Screens/parent_screen/parent_login_screen.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ParentRegisterScreen extends StatefulWidget {
  @override
  _ParentRegisterScreenState createState() => _ParentRegisterScreenState();
}

class _ParentRegisterScreenState extends State<ParentRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 38.0,
              ),
              HeadingText(
                text: 'Register',
                size: 60.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 30.0,
              ),
              RoundedInputField(
                hintText: 'Parent name',
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: 'Name of your ward',
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: 'Course',
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: 'Email',
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: 'Password',
                boolean: true,
                onChanged: (val) {},
              ),
              RoundedButton(
                text: 'Register',
                color: HexColor(appSecondaryColour),
              ),
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {},
                child: HeadingText(
                  text: 'Already registered?',
                  color: Colors.white,
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
