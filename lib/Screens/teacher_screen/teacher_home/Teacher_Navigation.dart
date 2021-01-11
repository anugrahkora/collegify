import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/student_screen/student_home/student_marks.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/student_attendance_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/student_mark_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/teacher_Classes.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/teacher_profile.dart';
import 'package:collegify/shared/components/constants.dart';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';



List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.book, color: Colors.black),
      title: ("Classes"),
      activeColor: Colors.white,
      inactiveColor: CupertinoColors.systemGrey,
      activeContentColor: HexColor(appSecondaryColour),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.check_mark, color: Colors.black),
      title: ("Attendance"),
      activeColor: Colors.white,
      inactiveColor: CupertinoColors.systemGrey,
      activeContentColor: HexColor(appSecondaryColour),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.graph_circle, color: Colors.black),
      title: ("Marks"),
      activeColor: Colors.white,
      inactiveColor: CupertinoColors.systemGrey,
      activeContentColor: HexColor(appSecondaryColour),
    ),
    PersistentBottomNavBarItem(
      icon: Icon(
        CupertinoIcons.person,
        color: Colors.black,
      ),
      title: ("Profile"),
      activeColor: Colors.white,
      inactiveColor: CupertinoColors.systemGrey,
      activeContentColor: HexColor(appSecondaryColour),
    ),
  ];
}

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class TeacherNavigationScreen extends StatefulWidget {
 
  final DocumentSnapshot documentSnapshot;

  const TeacherNavigationScreen({Key key, this.documentSnapshot}) : super(key: key);
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
      backgroundColor: HexColor(appPrimaryColour),
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
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
  List<Widget> _buildScreens() {
  return [
    TeacherHome(),

    StudentAttendance(documentSnapshot: widget.documentSnapshot,),
    StudentMarkScreen(),
    // from student screen
    TeacherProfileScreen(),
  ];
}
}
