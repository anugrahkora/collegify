import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/student_screen/student_home/student_notes.dart';
import 'package:collegify/authentication/auth_service.dart';

import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TeacherNames extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const TeacherNames({Key key, this.documentSnapshot}) : super(key: key);
  @override
  _TeacherNamesState createState() => _TeacherNamesState();
}

class _TeacherNamesState extends State<TeacherNames> {
  List classes = [];
  List<String> teacherNames = [];
  String university;
  String collegeName;
  String departmentName;
  String courseName;
  String name;
  String semester;
  String selectedTeacher;
  String teacherUid;
  String teacherClassName;
  final AuthService _authService = new AuthService();

  // DocumentReference documentReference;

  Future getTeacherData() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    university = widget.documentSnapshot.data()['University'];
    collegeName = widget.documentSnapshot.data()['College'];
    departmentName = widget.documentSnapshot.data()['Department'];
    courseName = widget.documentSnapshot.data()['Course'];
    semester = widget.documentSnapshot.data()['Semester'];

    await firebaseFirestore
        .collection('college')
        .doc('$university')
        .collection('CollegeNames')
        .doc('$collegeName')
        .collection('DepartmentNames')
        .doc('$departmentName')
        .collection('CourseNames')
        .doc('$courseName')
        .collection('Semester')
        .doc('$semester')
        .get()
        .then((docs) {
      setState(() {
        teacherNames = List.from(docs.data()['Teacher_Names']);
      });
    });
    await firebaseFirestore
        .collection('users')
        .where('University', isEqualTo: university)
        .where('College', isEqualTo: collegeName)
        .where('Department', isEqualTo: departmentName)
        .where('Course', isEqualTo: courseName)
        .where('Semester', isEqualTo: semester)
        .where('Name',isEqualTo: 'teacher')
        .get()
        .then((query) {
      query.docs.forEach((docs) {
        setState(() {
          teacherUid = docs.data()['Uid'];
        });
      });
    });
    await firebaseFirestore
        .collection('users')
        .doc(teacherUid)
        .collection('Classes')
        .where('Semester', isEqualTo: semester)
        .get()
        .then((query) {
      query.docs.forEach((docs) {
        setState(() {
          teacherClassName = docs.data()['ClassName'];
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // final user = Provider.of<UserModel>(context);
    getTeacherData();

    return teacherNames.isEmpty
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor(appPrimaryColour),
              title: HeadingText(
                alignment: Alignment.topLeft,
                text: "Your teachers",
                color: Colors.black,
              ),
            ),
            backgroundColor: HexColor(appPrimaryColour),
            body: Container(
              child: HeadingText(
                color: Colors.black87,
                text: 'No Teachers have been assigned',
                size: 20,
              ),
            ),
          )
        : Scaffold(
            drawer: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: ImageIcon(
                      AssetImage('assets/icons/iconStudentLarge.png'),
                      color: Colors.black54,
                      size: 30,
                    ),
                    decoration: BoxDecoration(
                      color: HexColor(appPrimaryColour),
                    ),
                  ),
                  ListTile(
                    title: Text(widget.documentSnapshot.data()['Name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          widget.documentSnapshot
                              .data()['Registration_Number']
                              .toString()
                              .replaceAll('_', ' '),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.documentSnapshot
                              .data()['University']
                              .toString()
                              .replaceAll('_', ' '),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.documentSnapshot
                              .data()['College']
                              .toString()
                              .replaceAll('_', ' '),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.documentSnapshot
                              .data()['Department']
                              .toString()
                              .replaceAll('_', ' '),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.documentSnapshot
                              .data()['Course']
                              .toString()
                              .replaceAll('_', ' '),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          widget.documentSnapshot
                              .data()['Semester']
                              .toString()
                              .replaceAll('_', ' '),
                        ),
                        Text(
                          teacherUid??'null' ,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  ListTile(
                    title: Text('Sign Out'),
                    onTap: () async {
                      await _authService.signOut();
                    },
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black54, //change your color here
              ),
              centerTitle: true,
              backgroundColor: HexColor(appPrimaryColour),
              title: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                child: ImageIcon(
                  AssetImage('assets/icons/iconTeacher.png'),
                  color: Colors.black54,
                ),
              ),
            ),
            backgroundColor: HexColor(appPrimaryColour),
            body: SafeArea(
              child: buildListView(size),
            ),
          );
  }

  ListView buildListView(Size size) {
    return ListView.builder(
      itemCount: teacherNames.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              width: size.width * 0.8,
              decoration: BoxDecoration(
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
                color: HexColor(appPrimaryColourLight),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                child: HeadingText(
                  color: Colors.black87,
                  text: teacherNames[index],
                  size: 23,
                ),
                onTap: () {
                  // setState(() async{
                  //   selectedTeacher = teacherNames[index];
                  // });
                  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                  // await firebaseFirestore.collection('users').where('')
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentNotes(
                        teacherName: teacherNames[index],
                        docs: widget.documentSnapshot,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
