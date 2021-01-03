import 'package:collegify/Screens/student_screen/student_home/teachers_names.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentNotes extends StatefulWidget {
  final String teacherName;

  const StudentNotes({Key key, this.teacherName}) : super(key: key);

  @override
  _StudentNotesState createState() => _StudentNotesState();
}

class _StudentNotesState extends State<StudentNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor(appPrimaryColour),
              title: HeadingText(
                alignment: Alignment.topLeft,
                text: widget.teacherName,
                color: Colors.black,
              ),
            ),
            backgroundColor: HexColor(appPrimaryColour),
            body: Container(
              child: HeadingText(
                color: Colors.black87,
                text: 'No Teachers have been assigned',
                size: 20,
              ),
            ),
          );
  }
}
