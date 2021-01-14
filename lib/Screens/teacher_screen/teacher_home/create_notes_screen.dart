import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/select_file_screen.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateNoteScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String className;
  final String semester;

  const CreateNoteScreen({Key key, this.snapshot, this.className, this.semester})
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
          alignment: Alignment.topLeft,
          text: widget.className,
          color: Colors.black,
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        splashColor: HexColor(appSecondaryColour),
        hoverElevation: 20,
        elevation: 3.0,
        backgroundColor: const Color(0xff03dac6),
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
        label: Text('Upload files'),
      ),
    );
  }
}
