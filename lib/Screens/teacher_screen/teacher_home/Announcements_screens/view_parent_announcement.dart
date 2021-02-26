import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Announcements_screens/create_announcement.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewParentAnnouncement extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String semester;

  const ViewParentAnnouncement({Key key, this.documentSnapshot, this.semester})
      : super(key: key);
  @override
  _ViewParentAnnouncementState createState() => _ViewParentAnnouncementState();
}

class _ViewParentAnnouncementState extends State<ViewParentAnnouncement> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<AnnouncementModel> parentAnnouncements = [];
  DocumentSnapshot snapshot;
  Future _getParentAnnouncements() async {
    try{
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
          parentAnnouncements = List<AnnouncementModel>.from(
            docs.data()['Parent_Announcements'].map(
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
          parentAnnouncements = [];
        });
      }
    });
    }catch(e){

    }
    
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _getParentAnnouncements();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'floatingActionButtonParent',
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
                      role: 'Parent',
                      semester: widget.semester,
                    )),
          );
        },
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: buildListViewParentAnnouncement(size),
    );
  }
}
