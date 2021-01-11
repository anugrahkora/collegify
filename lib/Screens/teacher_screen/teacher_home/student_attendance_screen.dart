import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentAttendance extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const StudentAttendance({Key key, this.documentSnapshot}) : super(key: key);
  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  List<String> studentNames = [];
  String university;
  String collegeName;
  String departmentName;
  String courseName;
  String name;
  int semester;
  Future getStudentNames() async {
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
        studentNames = List.from(docs.data()['Student_Names']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getStudentNames();
    return studentNames.isEmpty
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: HexColor(appPrimaryColour),
              title: HeadingText(
                alignment: Alignment.topLeft,
                text: "Your Students",
                color: Colors.black,
              ),
            ),
            backgroundColor: HexColor(appPrimaryColour),
            body: Container(
              child: HeadingText(
                color: Colors.black87,
                text:
                    'No Students have been registererd yet or an unknown error has occured',
                size: 20,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: HexColor(appPrimaryColour),
            body: SafeArea(
              child: buildListView(size),
            ),
          );
  }

  ListView buildListView(Size size) {
    return ListView.builder(
      itemCount: studentNames.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              height: 100.0,
              decoration: BoxDecoration(
                color: HexColor(appSecondaryColour),
                borderRadius: BorderRadius.circular(55),
              ),
              child: InkWell(
                child: HeadingText(
                  color: Colors.white,
                  text: studentNames[index],
                  size: 23,
                ),
                onTap: () {
                  // setState(() async{
                  //   selectedTeacher = teacherNames[index];
                  // });
                  // FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
                  // await firebaseFirestore.collection('users').where('')
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => StudentNotes(
                  //       teacherName: teacherNames[index],
                  //       docs: widget.documentSnapshot,
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
