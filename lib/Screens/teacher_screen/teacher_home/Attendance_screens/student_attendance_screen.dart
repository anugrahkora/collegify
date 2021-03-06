import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StudentAttendance extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String courseName;
  final String className;
  final String semester;

  const StudentAttendance({
    Key key,
    this.documentSnapshot,
    this.className,
    this.semester,
    this.courseName,
  }) : super(key: key);
  @override
  _StudentAttendanceState createState() => _StudentAttendanceState();
}

class _StudentAttendanceState extends State<StudentAttendance> {
  List<StudentModel> studentNames = [];
  DocumentSnapshot documentSnapshot;
  IconData radioButton = Icons.radio_button_off_rounded;
  DateTime dateTime = DateTime.now();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  String studentUid;

  bool _loading = false;
  bool _present = false;
  bool _flutter = false;

  Future getStudentNames() async {
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
          .get()
          .then((docs) {
        if (docs.exists) {
          documentSnapshot = docs;
          setState(() {
            studentNames = List<StudentModel>.from(
              docs.data()['Students'].map(
                (item) {
                  return new StudentModel(
                    name: item['Name'],
                    uid: item['Uid'],
                  );
                },
              ),
            );
          });
        } else {
          setState(() {
            studentNames = [];
          });
        }
      });
    } catch (e) {}
  }

// to select the date
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
      dynamic result = await DatabaseService().createNewAttendanceDocument(
        widget.documentSnapshot.data()['University'],
        widget.documentSnapshot.data()['College'],
        widget.documentSnapshot.data()['Department'],
        widget.courseName,
        widget.className,
        widget.semester,
        dateTime.toString().substring(0, 10).replaceAll('-', '_'),
        {
          'Name': null,
          'Status': null,
        },
      );
      if (result == null) {
        Fluttertoast.showToast(msg: 'Added');
      }
    }
  }

  Future _checkPresent(String _uid) async {
    try {
      return await firebaseFirestore
          .collection('users')
          .doc(_uid)
          .collection('Attendance')
          .where('Course', isEqualTo: widget.documentSnapshot.data()['Course'])
          .where(
            'Semester',
            isEqualTo: widget.documentSnapshot.data()['Semester'],
          )
          .get()
          .then((query) {
        query.docs.forEach((docs) {
          setState(() {
            _present = docs.data()['Present'];
          });
        });

        return _present ? true : null;
      });
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getStudentNames();

    return studentNames.isEmpty
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 15.0, 0.0, 15.0),
                child: ImageIcon(
                  AssetImage('assets/icons/iconStudent.png'),
                  color: Colors.black54,
                ),
              ),
            ),
            backgroundColor: HexColor(appPrimaryColour),
            body: Center(
              child: Container(
                child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Loader(
                      color: HexColor(appPrimaryColour),
                      size: 34.0,
                      spinnerColor: Colors.black54,
                    )),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ImageIcon(
                  AssetImage('assets/icons/iconStudent.png'),
                  color: Colors.black54,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              title: HeadingText(
                text: dateTime.toString().substring(0, 11),
                size: 20.0,
                color: Colors.black54,
              ),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      selectDate(context);
                    })
              ],
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
            ListSwitchTileSelect(
              name: studentNames[index].name,
              documentSnapshot: widget.documentSnapshot,
              courseName: widget.courseName,
              className: widget.className,
              semester: widget.semester,
              dateTime:
                  dateTime.toString().substring(0, 10).replaceAll('-', '_'),
            )
          ],
        );
      },
    );
  }

  _openPopup(context, String _uid) {
    bool loading = false;
    Alert(
        context: context,
        title: 'Attendance',
        style: AlertStyle(
          backgroundColor: HexColor(appPrimaryColour),
          isOverlayTapDismiss: false,
          alertBorder: RoundedRectangleBorder(
              // borderRadius: BorderRadius.circular(8.0),
              ),
        ),
        // content: HeadingText(
        //   text: "Attendance Status",
        //   color: Colors.black87,
        //   size: 15.0,
        // ),
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
                  .doc(
                      '${dateTime.toString().substring(0, 10).replaceAll('-', '_')}')
                  .set({
                'Course': widget.documentSnapshot.data()['Course'],
                'Semester': widget.documentSnapshot.data()['Semester'],
                'ClassName': widget.className,
                'Present': true,
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
                  .doc('${dateTime.toString().substring(0, 10)}')
                  .set({
                'Course': widget.documentSnapshot.data()['Course'],
                'Semester': widget.documentSnapshot.data()['Semester'],
                'ClassName': widget.className,
                'Present': false,
              });
              Navigator.of(context, rootNavigator: true).pop();
            },
            color: Colors.redAccent,
            radius: BorderRadius.circular(0.0),
          ),
        ]).show();
  }
}

class ListSwitchTileSelect extends StatefulWidget {
  final String name;
  final String dateTime;
  final DocumentSnapshot documentSnapshot;
  final String courseName;
  final String className;
  final String semester;

  const ListSwitchTileSelect({
    Key key,
    this.name,
    this.dateTime,
    this.documentSnapshot,
    this.courseName,
    this.className,
    this.semester,
  }) : super(key: key);
  @override
  _ListSwitchTileSelectState createState() => _ListSwitchTileSelectState();
}

class _ListSwitchTileSelectState extends State<ListSwitchTileSelect> {
  bool _value = false;
  DatabaseService _databaseService = new DatabaseService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      alignment: Alignment.topCenter,
      // margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
      child: SwitchListTile(
        activeColor: Colors.greenAccent,
        activeTrackColor: Colors.green,
        inactiveThumbColor: Colors.redAccent,
        inactiveTrackColor: Colors.red,
        title: HeadingText(
          alignment: Alignment.centerLeft,
          color: Colors.black54,
          text: widget.name,
          size: 20,
        ),
        value: _value,
        onChanged: (val) async {
          setState(() {
            _value = val;
          });
          if (_value) {
            dynamic result = await _databaseService.markAttendancePresent(
              widget.documentSnapshot.data()['University'],
              widget.documentSnapshot.data()['College'],
              widget.documentSnapshot.data()['Department'],
              widget.courseName,
              widget.className,
              widget.semester,
              widget.dateTime,
              {
                'Name': widget.name,
                'Status': 'Present',
              },
            );
            if (result != null) {
              Fluttertoast.showToast(msg: result);
            } else {
              Fluttertoast.showToast(msg: '${widget.name} is present ');
            }
          } else if (!_value) {
            Fluttertoast.showToast(msg: '${widget.name}  is absent');
          }
        },
      ),
    );
  }
}
