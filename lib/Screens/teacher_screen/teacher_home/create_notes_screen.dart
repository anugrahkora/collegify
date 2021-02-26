import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/student_screen/student_home/openImageScreen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/select_file_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Attendance_screens/student_attendance_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/student_mark_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/teacher_Classes.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Announcements_screens/teacher_announcement.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateNoteScreen extends StatefulWidget {
  final DocumentSnapshot docs;
  final String className;
  final String semester;
  final String courseName;

  const CreateNoteScreen({Key key, this.docs, this.className, this.semester, this.courseName})
      : super(key: key);
  @override
  _CreateNoteScreenState createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  String _notes = 'Notes';
  ListResult classList;
  String _downloadUrl;
  String _imageUrl;
  List<Image> imageList = [];
  FullMetadata fullMetadata;
  String _filePath;

  _getNotes() async {
    setState(() {
      _filePath =
          '${widget.docs.data()['University']}/${widget.docs.data()['College']}/$_notes/${widget.docs.data()['Department']}/${widget.className}/${widget.semester}/${widget.docs.data()['Name']}';
    });

    try {
      final _storage = FirebaseStorage.instance.ref().child(_filePath);
      classList = await _storage.listAll();
    } catch (e) {}
  }

  _getUrl(int index) async {
    _downloadUrl = await classList.items[index].getDownloadURL();
    return _downloadUrl;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: HeadingText(
          alignment: Alignment.center,
          text: widget.className,
          color: Colors.black54,
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: buildListView(size),
      ),
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
                  docs: widget.docs,
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

  ListView buildListView(Size size) {
    _getNotes();

    return ListView.builder(
        itemCount: classList != null ? classList.items.length : 0,
        itemBuilder: (BuildContext context, index) {
          _getUrl(index);
          return Column(
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                // height: 100.0,
                decoration: BoxDecoration(
                  color: HexColor(appPrimaryColourLight),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        offset: Offset(6, 2),
                        blurRadius: 6.0,
                        spreadRadius: 0.0),
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.1),
                        offset: Offset(-6, -2),
                        blurRadius: 6.0,
                        spreadRadius: 0.0),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.black54,
                    ),

                    HeadingText(
                      text: classList.items[index].name.substring(0, 16),
                      size: 15.0,
                      color: Colors.black54,
                    ),

                    IconButton(
                        icon: Icon(
                          Icons.open_in_full_rounded,
                          color: Colors.black87,
                        ),
                        onPressed: () async {
                          String imageUrl =
                              await classList.items[index].getDownloadURL();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OpenImage(
                                      imageUrl: imageUrl,
                                      imageName: classList.items[index].name
                                          .substring(0, 16),
                                      imagePath: classList.items[index].name,
                                      documentSnapshot: widget.docs,
                                      path: _filePath,
                                    )),
                          );
                        }),
                    //  SizedBox(width: 2.0,),
                  ],
                ),
                //  InkWell(
                //   child:,
                //   onTap: () {
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
                // },
              ),
            ],
          );
        });
  }
}
