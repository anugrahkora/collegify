import 'package:collegify/Screens/parent_screen/parent_register_screen.dart';
import 'package:flutter/material.dart';

class ParentScreen extends StatefulWidget {
  @override
  _ParentScreenState createState() => _ParentScreenState();
}

class _ParentScreenState extends State<ParentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParentRegisterScreen(),
    );
  }
}
