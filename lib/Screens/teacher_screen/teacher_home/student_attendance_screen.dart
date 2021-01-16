import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StudentAttendance extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const StudentAttendance({Key key, this.documentSnapshot}) : super(key: key);
  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  List<String> studentNames = [];
  DocumentSnapshot documentSnapshot;

  IconData radioButton = Icons.radio_button_off_rounded;

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String studentUid;
  bool _loading = false;

  Future getStudentNames() async {
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
        .doc('${widget.documentSnapshot.data()['Semester']}')
        .get()
        .then((docs) {
      documentSnapshot = docs;
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
              title: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                child: ImageIcon(
                  AssetImage('assets/icons/iconStudent.png'),
                  color: Colors.black54,
                ),
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
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: HexColor(appPrimaryColour),
              title: ImageIcon(
                AssetImage('assets/icons/iconStudent.png'),
                color: Colors.black54,
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
      itemCount: studentNames.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(vertical: 2),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              width: size.width * 0.8,
              height: size.height * 0.08,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeadingText(
                      alignment: Alignment.centerLeft,
                      color: Colors.black54,
                      text: studentNames[index],
                      size: 20,
                    ),
                  ],
                ),

                // studentNamesMap[index].present
                //       ? Icon(Icons.radio_button_on_rounded)
                //       : Icon(Icons.radio_button_off_outlined),
                onTap: () async {
                  await firebaseFirestore
                      .collection('users')
                      .where('University',
                          isEqualTo:
                              widget.documentSnapshot.data()['University'])
                      .where('College',
                          isEqualTo: widget.documentSnapshot.data()['College'])
                      .where('Department',
                          isEqualTo:
                              widget.documentSnapshot.data()['Department'])
                      .where('Course',
                          isEqualTo: widget.documentSnapshot.data()['Course'])
                      .where('Semester',
                          isEqualTo: widget.documentSnapshot.data()['Semester'])
                      .where('Name', isEqualTo: studentNames[index])
                      .get()
                      .then((query) {
                    query.docs.forEach((docs) {
                      setState(() {
                        studentUid = docs.data()['Uid'];
                      });
                    });
                    _openPopup(context, studentUid);
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }

  _openPopup(context, String _uid) {
    bool loading = false;
    Alert(
        context: context,
        title: '',
        style: AlertStyle(
          backgroundColor: HexColor(appPrimaryColour),
          isOverlayTapDismiss: false,
          alertBorder: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(8.0),
              ),
        ),
        content: HeadingText(
          text: "Attendance Status",
          color: Colors.black87,
          size: 15.0,
        ),
        buttons: [
          DialogButton(
            child: loading
                ? Loader(
                    size: 18.0,
                    color: Colors.greenAccent,
                    spinnerColor: Colors.black87,
                  )
                : Icon(Icons.done),
            onPressed: () async {
              await firebaseFirestore
                  .collection('users')
                  .doc(_uid)
                  .collection('Attendance')
                  .doc('${DateTime.now()}')
                  .set({
                'Present': 1,
              });
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.greenAccent,
            radius: BorderRadius.circular(0.0),
          ),
          DialogButton(
            child: Icon(Icons.close),
            onPressed: () async {
              await firebaseFirestore
                  .collection('users')
                  .doc(_uid)
                  .collection('Attendance')
                  .doc('${DateTime.now()}')
                  .set({
                'Present': 0,
              });
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.redAccent,
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
}
