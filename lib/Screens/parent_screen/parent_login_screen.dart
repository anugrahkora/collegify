import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ParentLoginScreen extends StatefulWidget {
  @override
  _ParentLoginScreenState createState() => _ParentLoginScreenState();
  ParentLoginScreen();
}

class _ParentLoginScreenState extends State<ParentLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(parentPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 25.0,
              ),
              HeadingText(
                text: 'Login',
                size: 60.0,
                color: Colors.white,
              ),
              SizedBox(
                height: 25.0,
              ),
              RoundedInputField(
                hintText: "Email",
                onChanged: (val) {},
              ),
              SizedBox(
                height: 5.0,
              ),
              RoundedInputField(
                hintText: "Password",
                boolean: true,
                onChanged: (val) {},
              ),
              SizedBox(
                height: 15.0,
              ),
              RoundedButton(
                text: 'Login',
                color: Colors.white,
                textColor: HexColor(parentPrimaryColour),
                press: () {},
              ),
              SizedBox(
                height: 15.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: HeadingText(
                  text: 'register?',
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
