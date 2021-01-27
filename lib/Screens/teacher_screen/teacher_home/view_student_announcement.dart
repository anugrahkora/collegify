import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/create_announcement.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewStudentAnnouncements extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String semester;

  const ViewStudentAnnouncements(
      {Key key, this.documentSnapshot, this.semester})
      : super(key: key);
  @override
  _ViewStudentAnnouncementsState createState() =>
      _ViewStudentAnnouncementsState();
}

class _ViewStudentAnnouncementsState extends State<ViewStudentAnnouncements> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<AnnouncementModel> studentAnnouncements = [];
  DocumentSnapshot snapshot;
  Future _getStudentAnnouncements() async {
    try {
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
          .doc('${widget.semester}')
          .get()
          .then((docs) {
        if (docs.exists) {
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
        } else {
          setState(() {
            studentAnnouncements = [];
          });
        }
      });
    } catch (e) {}
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getStudentAnnouncements();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'floatingActionButtonStudent',
        splashColor: HexColor(appSecondaryColour),
        hoverElevation: 20,
        elevation: 3.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.black54,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateAnnouncement(
                documentSnapshot: widget.documentSnapshot,
                role: 'Student',
                semester: widget.semester,
              ),
            ),
          );
        },
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: buildListViewStudentAnnouncement(size),
    );
  }
}
