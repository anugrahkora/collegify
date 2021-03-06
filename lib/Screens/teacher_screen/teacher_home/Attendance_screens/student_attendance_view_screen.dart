import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StudentAttendanceViewScreen extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String courseName;
  final String className;
  final String semester;

  const StudentAttendanceViewScreen(
      {Key key,
      this.documentSnapshot,
      this.courseName,
      this.className,
      this.semester})
      : super(key: key);
  @override
  _StudentAttendanceViewScreenState createState() =>
      _StudentAttendanceViewScreenState();
}

class _StudentAttendanceViewScreenState
    extends State<StudentAttendanceViewScreen> {
  DateTime dateTime = DateTime.now();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<AttendanceStatusModel> attendanceStatus = [];
  Future<Null> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (picked != null && picked != dateTime) {
      setState(() {
        dateTime = picked;
      });
      getAttendanceStatus(
          dateTime.toString().substring(0, 10).replaceAll('-', '_'));
    }
  }

  Future getAttendanceStatus(String date) async {
    try {
      await firebaseFirestore
          .collection('college')
          .doc('${widget.documentSnapshot.data()['University']}')
          .collection('CollegeNames')
          .doc('${widget.documentSnapshot.data()['College']}')
          .collection('DepartmentNames')
          .doc('${widget.documentSnapshot.data()['Department']}')
          .collection('CourseNames')
          .doc('${widget.courseName}')
          .collection('Semester')
          .doc('${widget.semester}')
          .collection('Attendance')
          .doc(widget.className)
          .collection('Dates')
          .doc(date)
          .get()
          .then((docs) {
        if (docs.exists) {
          setState(() {
            attendanceStatus = List<AttendanceStatusModel>.from(
              docs.data()['Students'].map(
                (item) {
                  return new AttendanceStatusModel(
                    name: item['Name'],
                    status: item['Status'],
                  );
                },
              ),
            );
          });
        } else {
          setState(() {
            attendanceStatus = [];
          });
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    getAttendanceStatus(
      dateTime.toString().substring(0, 10).replaceAll('-', '_'),
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: HeadingText(
          text:' Attendance registry ' +
              ' ' +
              '( ${dateTime.toString().substring(0, 10)} )',
          size: 18.0,
          color: Colors.black54,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: HexColor('#99b4bf'),
        hoverElevation: 20,
        elevation: 3.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () async {
          selectDate(context);
        },
        child: Icon(Icons.date_range),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: buildListView(size),
      ),
    );
  }

  ListView buildListView(Size size) {
    return ListView.builder(
      itemCount: attendanceStatus.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
         
          children: [
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 1.0,
              color: Colors.black,
            ),
             SizedBox(
              height: 10.0,
            ),
            Container(
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text((index + 1).toString()),
                  Text(attendanceStatus[index].name),
                  Text(attendanceStatus[index].status),
                ],
              ),
            ),
            
          ],
        );
      },
    );
  }
}
