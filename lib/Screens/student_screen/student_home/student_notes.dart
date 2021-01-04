import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentNotes extends StatefulWidget {
  final String teacherName;
  final DocumentSnapshot docs;

  const StudentNotes({Key key, this.teacherName, this.docs}) : super(key: key);

  @override
  _StudentNotesState createState() => _StudentNotesState();
}

class _StudentNotesState extends State<StudentNotes> {
  String _notes = 'Notes';
  ListResult classList;

  _getNotes() async {
    String _filePath =
        '${widget.docs.data()['University']}/${widget.docs.data()['College']}/$_notes/${widget.docs.data()['Department']}/${widget.docs.data()['Course']}/${widget.docs.data()['Semester']}';
    try {
      final _storage = FirebaseStorage.instance.ref().child(_filePath);

      classList = await _storage.listAll();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: SafeArea(child: buildListView(size),),
    );
  }

  ListView buildListView(Size size) {
    _getNotes();

    return ListView.builder(
        itemCount: classList != null ? classList.prefixes.length : 0,
        itemBuilder: (BuildContext context, index) {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                 width: size.width * 0.8,
                height: 100.0,
                decoration: BoxDecoration(
                  color: HexColor(appSecondaryColour),
                  borderRadius: BorderRadius.circular(55),
                ),
                child: InkWell(
                  child: HeadingText(
                    color: Colors.white,
                    text: classList.prefixes[index].name ?? '---',
                    size: 23,
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => CreateNoteScreen(
                    //       snapshot: snapshot,
                    //       className: classList[index].data()['ClassName'],
                    //       year: classList[index].data()['Semester'],
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ],
          );
        });
  }
}
