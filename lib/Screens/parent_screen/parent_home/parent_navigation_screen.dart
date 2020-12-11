import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/parent_screen/parent_home/announcements_from_teacher.dart';
import 'package:collegify/Screens/parent_screen/parent_home/fee_payment_screen.dart';
import 'package:collegify/Screens/parent_screen/parent_home/parent_home.dart';
import 'package:collegify/Screens/parent_screen/parent_home/student_attendance_status.dart';
import 'package:collegify/Screens/student_screen/student_home/student_analytics.dart';
import 'package:collegify/Screens/student_screen/student_home/student_home.dart';
import 'package:collegify/Screens/student_screen/student_home/student_marks.dart';
import 'package:collegify/Screens/student_screen/student_home/student_Profile.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:flutter/material.dart';

import 'package:collegify/Screens/student_screen/student_auth_screens/student_register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:provider/provider.dart';

List<Widget> _buildScreens() {
  return [
    ParentHome(),
    StudentAttendanceStatus(),
    FeePaymentScreen(),
    AnnouncementFromTeacher()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.home),
      title: ("Home"),
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.list_bullet),
      title: ("Analytics"),
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.person),
      title: ("Marks"),
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(CupertinoIcons.person),
      title: ("User"),
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.systemGrey,
    ),
  ];
}

PersistentTabController _controller = PersistentTabController(initialIndex: 0);

class ParentNavigationScreen extends StatefulWidget {
  @override
  _ParentNavigationScreenState createState() => _ParentNavigationScreenState();
}

class _ParentNavigationScreenState extends State<ParentNavigationScreen> {
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
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
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
}
