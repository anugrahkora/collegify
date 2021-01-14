import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/student_screen/student_home/openImageScreen.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/dropDownList.dart';
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
  String _downloadUrl;
  String _imageUrl;
  List<Image> imageList = [];
  FullMetadata fullMetadata;

  _getNotes() async {
    String _filePath =
        '${widget.docs.data()['University']}/${widget.docs.data()['College']}/$_notes/${widget.docs.data()['Department']}/${widget.docs.data()['Course']}/${widget.docs.data()['Semester']}/${widget.teacherName}';
    try {
      final _storage = FirebaseStorage.instance.ref().child(_filePath);
      classList = await _storage.listAll();
    } catch (e) {}
  }

  _getUrl(int index) async {
    // for (int i = 0; i <=classList.items.length;++i) {
    _downloadUrl = await classList.items[index].getDownloadURL();
    return _downloadUrl;
    //   imageList.add(Image.network(_downloadUrl));
    // }

    // setState(() {
    //   _imageUrl = _downloadUrl;
    // });
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
      body: SafeArea(
        child: buildListView(size),
      ),
    );
  }

  ListView buildListView(Size size) {
    _getNotes();
    // _getUrl();

    //  ListView(
    //   children: imageList,
    // );
    return ListView.builder(
        itemCount: classList != null ? classList.items.length : 0,
        itemBuilder: (BuildContext context, index) {
          _getUrl(index);
          return Column(
            children: [
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                // height: 100.0,
                decoration: BoxDecoration(
                  color: HexColor(appSecondaryColour),
                  borderRadius: BorderRadius.circular(55),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    HeadingText(
                      text: classList.items[index].name.substring(0, 16),
                      size: 15.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 18.0,
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.open_in_full_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          String imageUrl =
                             await classList.items[index].getDownloadURL();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OpenImage(imageUrl: imageUrl,imageName:classList.items[index].name.substring(0, 16) ,)),
                          );
                        }),
                    //  SizedBox(width: 2.0,),
                    IconButton(
                        icon: Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                        ),
                        onPressed: null)
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
