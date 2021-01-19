import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/select_file_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/student_attendance_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/student_mark_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/teacher_Classes.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/teacher_announcement.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateNoteScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String className;
  final String semester;

  const CreateNoteScreen(
      {Key key, this.snapshot, this.className, this.semester})
      : super(key: key);
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor(appPrimaryColour),
        title: HeadingText(
          alignment: Alignment.center,
          text: widget.className,
          color: Colors.black,
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
          child: Column(
        children: [
          Container(),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        splashColor: HexColor('#99b4bf'),
        hoverElevation: 20,
        elevation: 3.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () async {
          try {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectFileScreen(
                  docs: widget.snapshot,
                  className: widget.className,
                  semester: widget.semester,
                ),
              ),
            );
          } catch (e) {}
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
