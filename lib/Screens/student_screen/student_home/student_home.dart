import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentNotes extends StatefulWidget {
  @override
  _StudentNotesState createState() => _StudentNotesState();
}

class _StudentNotesState extends State<StudentNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Center(child: Text("student  Note screen")),
            ],
          ),
        ),
      ),
    );
  }
}
