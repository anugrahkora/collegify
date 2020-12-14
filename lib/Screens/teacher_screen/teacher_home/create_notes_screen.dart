import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateNoteScreen extends StatefulWidget {
  final DocumentSnapshot snapshot;
  final String className;

  const CreateNoteScreen({Key key, this.snapshot, this.className}) : super(key: key);
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30.0,
            ),
            HeadingText(
              text: widget.className?? '---',
              size: 20.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
                child: RoundedButton(
              color: HexColor(appSecondaryColour),
              text: 'Back',
              loading: false,
              onPressed: () {
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }
}
