import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/create_announcement_parent.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/create_announcement_student.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/models/user_model.dart';

import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherProfileScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const TeacherProfileScreen({Key key, this.documentSnapshot})
      : super(key: key);
  @override
  _TeacherProfileScreenState createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  bool loading = false;
  List<AnnouncementModel> studentAnnouncements = [];
  List<AnnouncementModel> parentAnnouncements = [];
  DocumentSnapshot snapshot;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final AuthService _authService = AuthService();
  Future _getStudentAnnouncements() async {
    await firebaseFirestore
        .collection('college')
        .doc('${widget.documentSnapshot.data()['University']}')
        .collection('CollegeNames')
        .doc('${widget.documentSnapshot.data()['College']}')
        .collection('DepartmentNames')
        .doc('${widget.documentSnapshot.data()['Department']}')
        .collection('CourseNames')
        .doc('${widget.documentSnapshot.data()['Course']}')
        .collection('Semester')
        .doc('${widget.documentSnapshot.data()['Semester']}')
        .get()
        .then((docs) {
      snapshot = docs;
      setState(() {
        studentAnnouncements = List<AnnouncementModel>.from(
          docs.data()['Student_Announcements'].map(
            (item) {
              return new AnnouncementModel(
                subject: item['Subject'],
                announcement: item['Announcement'],
              );
            },
          ),
        );
      });
    });
  }

  _getParentAnnouncements() {
    setState(() {
      parentAnnouncements = List<AnnouncementModel>.from(
        snapshot.data()['Parent_Announcements'].map(
          (item) {
            return new AnnouncementModel(
              subject: item['Subject'],
              announcement: item['Announcement'],
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getStudentAnnouncements();
    _getParentAnnouncements();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: HexColor(appPrimaryColour),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
                icon: ImageIcon(
            AssetImage('assets/icons/iconStudent.png'),
            color: Colors.black54,
          ),
                onPressed: () {
                   Navigator.push(
              context,
              MaterialPageRoute(
                builder: ( context) => CreateAnnouncementStudent(
                  documentSnapshot: widget.documentSnapshot,
                ),
              ),
            );
                }),
            SizedBox(
              width: 40.0,
            ),
            IconButton(
                icon:ImageIcon(
            AssetImage('assets/icons/iconParent.png'),
            color: Colors.black54,
          ),
                onPressed: () {
                   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ( context) => CreateAnnouncementParent(
                    documentSnapshot: widget.documentSnapshot,
                  ),
                ),
              );
                }),
          ],
        ),
      ),
      // floatingActionButton:
      // //  Column(
      // //   mainAxisAlignment: MainAxisAlignment.end,
      // //   children: [
      //     FloatingActionButton.extended(
      //       splashColor: HexColor(appSecondaryColour),
      //       hoverElevation: 20,
      //       elevation: 3.0,
      //       backgroundColor: Colors.white,
      //       foregroundColor: Colors.black,
      //       label: HeadingText(
      //         text: 'Parent',
      //         size: 15.0,
      //         color: Colors.black54,
      //       ),
      //       icon: Icon(
      //         Icons.add,
      //         color: Colors.black54,
      //       ),
      //       onPressed: () {
             
      //       },
      //     ),
      //   SizedBox(
      //     height: size.height * 0.02,
      //   ),
      //   FloatingActionButton.extended(
      //     splashColor: HexColor(appSecondaryColour),
      //     hoverElevation: 20,
      //     elevation: 3.0,
      //     backgroundColor: Colors.white,
      //     foregroundColor: Colors.black,
      //     label: HeadingText(
      //       text: 'Student',
      //       size: 15.0,
      //       color: Colors.black54,
      //     ),
      //     icon: Icon(Icons.add, color: Colors.black54),
      //     onPressed: () {
           
      //     },
      //   ),
      // ],
      // ),
      appBar: AppBar(
        backgroundColor: HexColor(appPrimaryColour),
        title: HeadingText(
          alignment: Alignment.topLeft,
          text: 'Announcements',
          color: Colors.black54,
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
          child: ImageIcon(
            AssetImage('assets/icons/iconTeacher.png'),
            color: HexColor(appSecondaryColour),
          ),
        ),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        // child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: buildListViewStudentAnnouncement(size)),
            Expanded(child: buildListViewParentAnnouncement(size)),
          ],
        ),
      ),
    );
  }

  ListView buildListViewStudentAnnouncement(Size size) {
    return ListView.builder(
      itemCount: studentAnnouncements.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: size.width * 0.8,

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      offset: Offset(6, 2),
                      blurRadius: 6.0,
                      spreadRadius: 3.0),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      offset: Offset(-6, -2),
                      blurRadius: 6.0,
                      spreadRadius: 3.0),
                ],
                color: HexColor(appPrimaryColourLight),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                // child: SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HeadingText(
                      alignment: Alignment.center,
                      color: Colors.black54,
                      text: '${studentAnnouncements[index].subject}',
                      size: 20,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    HeadingText(
                      alignment: Alignment.centerLeft,
                      color: Colors.black54,
                      text: '${studentAnnouncements[index].announcement}',
                      size: 15,
                    ),
                  ],
                ),
              ),
              // onTap: () async {
              //   _openPopup(context, studentNames[index].uid);
              // },
              // ),
            ),
          ],
        );
      },
    );
  }

  ListView buildListViewParentAnnouncement(Size size) {
    return ListView.builder(
      itemCount: parentAnnouncements.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: size.width * 0.8,

              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      offset: Offset(6, 2),
                      blurRadius: 6.0,
                      spreadRadius: 3.0),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      offset: Offset(-6, -2),
                      blurRadius: 6.0,
                      spreadRadius: 3.0),
                ],
                color: HexColor(appPrimaryColourLight),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    HeadingText(
                      alignment: Alignment.center,
                      color: Colors.black54,
                      text: '${parentAnnouncements[index].subject}',
                      size: 20,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    HeadingText(
                      alignment: Alignment.centerLeft,
                      color: Colors.black54,
                      text: '${parentAnnouncements[index].announcement}',
                      size: 15,
                    ),
                  ],
                ),
              ),
              // onTap: () async {
              //   _openPopup(context, studentNames[index].uid);
              // },
            ),
          ],
        );
      },
    );
  }
}
