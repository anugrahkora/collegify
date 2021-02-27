import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/student_screen/student_home/student_marks.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Announcements_screens/teacher_announcement.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/create_notes_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Attendance_screens/student_attendance_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/student_mark_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/teacher_Classes.dart';

import 'package:collegify/shared/components/constants.dart';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.book, color: Colors.black54),
      title: ("Notes"),
      activeColor: Colors.white,
      inactiveColor: CupertinoColors.systemGrey,
      activeContentColor: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.check_mark, color: Colors.black54),
      title: ("Attendance"),
      activeColor: Colors.white,
      inactiveColor: CupertinoColors.systemGrey,
      activeContentColor: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.graph_circle, color: Colors.black54),
      title: ("Marks"),
      activeColor: Colors.white,
      inactiveColor: CupertinoColors.systemGrey,
      activeContentColor: Colors.black54,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(
        CupertinoIcons.person,
        color: Colors.black54,
      ),
      title: ("Profile"),
      activeColor: Colors.white,
      inactiveColor: CupertinoColors.systemGrey,
      activeContentColor: Colors.black54,
    ),
  ];
}

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class TeacherNavigationScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String courseName;
  final String className;
  final String semester;

  const TeacherNavigationScreen(
      {Key key, this.documentSnapshot, this.className, this.semester, this.courseName,})
      : super(key: key);
  @override
  _TeacherNavigationScreenState createState() =>
      _TeacherNavigationScreenState();
}

class _TeacherNavigationScreenState extends State<TeacherNavigationScreen> {
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears.
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument.
      // decoration: NavBarDecoration(
      //   borderRadius: BorderRadius.circular(10.0),
      //   colorBehindNavBar: Colors.white,
      // ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style5, // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      CreateNoteScreen(
        docs: widget.documentSnapshot,
        className: widget.className,
        semester: widget.semester,
      ),

      StudentAttendance(
        documentSnapshot: widget.documentSnapshot,
        courseName: widget.courseName,
        className: widget.className,
        semester: widget.semester,
      ),
      StudentMarkScreen(),
      // from student screen
      TeacherProfileScreen(
        documentSnapshot: widget.documentSnapshot,
        semester: widget.semester,
      ),
    ];
  }
}
