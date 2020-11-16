import 'package:collegify/Screens/login_screen/login_screen.dart';
import 'package:collegify/Screens/parent_screen/parent_register_screen.dart';
import 'package:collegify/Screens/parent_screen/parent_screen_authenticate.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_register_screen.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_screen_authenticate.dart';
import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_login_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_register_screen.dart';
import 'package:collegify/Screens/teacher_screen/teacher_auth_screens/teacher_screen_authenticate.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

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
      decoration: NavBarDecoration(
        //borderRadius: BorderRadius.circular(10.0),
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

  List<Widget> _buildScreens() {
    return [
      LoginScreen(),
      StudentRegisterScreen(),
      TeacherRegisterScreen(),
      ParentRegisterScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage('assets/icons/iconLogin.png'),
          color: HexColor(appSecondaryColour),
        ),
        title: ("LogIn"),
        activeColor: Colors.white, //HexColor(appSecondaryColour),
        inactiveColor: CupertinoColors.systemGrey,
        activeContentColor: HexColor(appSecondaryColour),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage('assets/icons/iconStudent.png'),
          color: HexColor(appSecondaryColour),
        ),
        title: ("Student"),
        activeColor: Colors.white, //HexColor(appSecondaryColour),
        inactiveColor: CupertinoColors.systemGrey,
        activeContentColor: HexColor(appSecondaryColour),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage('assets/icons/iconTeacher.png'),
          color: HexColor(appSecondaryColour),
        ),
        title: ("Teacher"),
        activeColor: Colors.white,
        inactiveColor: CupertinoColors.systemGrey,
        activeContentColor: HexColor(appSecondaryColour),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage('assets/icons/iconParent.png'),
          color: HexColor(appSecondaryColour),
        ),
        title: ("Parent"),
        activeColor: Colors.white,
        inactiveColor: CupertinoColors.systemGrey,
        activeContentColor: HexColor(appSecondaryColour),
      ),
    ];
  }
}
//  if (_userRole == 1) {
//       return StudentScreen();
//     } else if (_userRole == 2) {
//       return TeacherScreen();
//     } else if (_userRole == 3) {
//       return ParentScreen();
//     }

// Scaffold(
//   backgroundColor: HexColor(welcomePrimaryColour),
//   body: SafeArea(
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         SizedBox(
//           height: 39.0,
//         ),
//         Center(
//           child: Column(
//             children: <Widget>[
//               HeadingText(
//                 text: 'Welcome.',
//                 size: 65.0,
//                 color: HexColor(teacherPrimaryColour),
//               ),
//               SizedBox(
//                 height: 4.0,
//               ),
//               HeadingText(
//                 text: 'Select the user',
//                 size: 25.0,
//                 color: HexColor(parentPrimaryColour),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 140.0,
//         ),
//         RoundedButton(
//           text: 'Student',
//           color: HexColor(studentPrimaryColour),
//           textColor: Colors.white,
//           route: '/studentScreen',
//           press: () {
//             setState(() {
//               _userRole = 1;
//             });
//           },
//         ),
//         RoundedButton(
//           text: 'Teacher',
//           color: HexColor(teacherPrimaryColour),
//           textColor: Colors.white,
//           route: '/teacherScreen',
//           press: () {
//             setState(() {
//               _userRole = 2;
//             });
//           },
//         ),
//         RoundedButton(
//           text: 'Parent',
//           route: '/parentScreen',
//           color: HexColor(parentPrimaryColour),
//           textColor: Colors.white,
//           press: () {
//             setState(() {
//               _userRole = 2;
//             });
//           },
//         ),
//       ],
//     ),
//   ),
// );
