import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:collegify/Screens/teacher_screen/teacher_home/view_parent_announcement.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/view_student_announcement.dart';

import 'package:collegify/models/user_model.dart';

import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';

class TeacherProfileScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String semester;

  const TeacherProfileScreen({Key key, this.documentSnapshot, this.semester})
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

  List<Widget> _buildScreens() {
    return [
      ViewStudentAnnouncements(
        documentSnapshot: widget.documentSnapshot,semester: widget.semester,
      ),
      ViewParentAnnouncement(
        documentSnapshot: widget.documentSnapshot,semester: widget.semester,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: HeadingText(
            alignment: Alignment.topLeft,
            text: 'Announcements',
            color: Colors.black54,
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: HeadingText(
                  text: 'Student',
                  color: Colors.black54,
                ),
                icon: ImageIcon(
                  AssetImage('assets/icons/iconStudent.png'),
                  color: Colors.black54,
                ),
              ),
              Tab(
                child: HeadingText(
                  text: 'Parent',
                  color: Colors.black54,
                ),
                icon: ImageIcon(
                  AssetImage('assets/icons/iconParent.png'),
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: HexColor(appPrimaryColour),
        body: SafeArea(
            // child: SingleChildScrollView(
            child: TabBarView(
          children: _buildScreens(),
        )),
      ),
    );
  }
}
