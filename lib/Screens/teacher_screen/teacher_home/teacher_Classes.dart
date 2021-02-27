import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Teacher_Navigation.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/create_notes_screen.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/dropDownList.dart';
import 'package:collegify/shared/components/loadingWidget.dart';

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherHome extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  final String semester;

  const TeacherHome({Key key, this.documentSnapshot, this.semester})
      : super(key: key);
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  bool loading = false;
  List<QueryDocumentSnapshot> classList = new List<QueryDocumentSnapshot>();
  DocumentSnapshot snapshot;
  String _className;
  String _course;
  final AuthService _authService = AuthService();

  //getting the list of classes
  Future getClass(String uid) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    snapshot = await firebaseFirestore.collection('users').doc(uid).get();

    await firebaseFirestore
        .collection('users')
        .doc(uid)
        .collection('Classes')
        .get()
        .then((query) {
      classList = query.docs.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    //ThemeData(primarySwatch: Colors.black);
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserModel>(context);
    getClass(user.uid);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black54, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                children: [
                  ImageIcon(
                    AssetImage('assets/icons/iconTeacherLarge.png'),
                    color: Colors.black54,
                    size: 90,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: HeadingText(
                        text: user.email,
                        size: 15.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: HexColor(appPrimaryColour),
              ),
            ),
            ListTile(
              title: Text(widget.documentSnapshot.data()['Name']),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Signout'),
              onTap: () {
                showAlertDialog(context);
                // await _authService.signOut();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: HexColor('#99b4bf'),
        hoverElevation: 20,
        elevation: 3.0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () async {
          try {
            showDialog(
                context: context,
                builder: (_) {
                  return OpenPopupDialogue(
                    documentSnapshot: widget.documentSnapshot,
                    uid: user.uid,
                  );
                });
          } catch (e) {}
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: classList.isNotEmpty
            ? buildListView(size)
            : HeadingText(
                text: 'No classes have been added',
                size: 25.0,
                color: Colors.black54,
              ),
      ),
    );
  }

  ListView buildListView(Size size) {
    return ListView.builder(
      itemCount: classList.length,
      itemBuilder: (BuildContext context, index) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: size.width * 0.8,
              // height: size.height * 0.1,
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
                child: Column(
                  children: [
                    HeadingText(
                      alignment: Alignment.topLeft,
                      color: Colors.black54,
                      text: classList[index]
                              .data()['Course']
                              .replaceAll('_', ' ') ??
                          '---',
                      size: 23,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingText(
                          alignment: Alignment.topLeft,
                          color: Colors.black54,
                          text: classList[index]
                                  .data()['ClassName']
                                  .replaceAll('_', ' ') ??
                              '---',
                          size: 23,
                        ),
                        SizedBox(width: 25.0,),
                        HeadingText(
                          color: Colors.black54,
                          text: classList[index].data()['Semester'],
                          size: 23,
                        ),
                      ],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherNavigationScreen(
                        className: classList[index].data()['ClassName'],
                        semester: classList[index].data()['Semester'],
                        courseName:classList[index].data()['Course'] ,
                        documentSnapshot: snapshot,
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

  

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () async {
        await _authService.signOut();
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // backgroundColor: HexColor(appPrimaryColour),
      title: Text(
        "Sign out?",
        style: TextStyle(color: Colors.black),
      ),
      // content: Text(
      //     ""),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class OpenPopupDialogue extends StatefulWidget {
  final String uid;
  final DocumentSnapshot documentSnapshot;

  const OpenPopupDialogue({Key key, this.uid, this.documentSnapshot})
      : super(key: key);
  @override
  _OpenPopupDialogueState createState() => _OpenPopupDialogueState();
}

class _OpenPopupDialogueState extends State<OpenPopupDialogue> {
  String _semester;
  String _className;
  String _course;
  String _selectedSemester;
  bool _loading = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      title: HeadingText(
        text: 'New class',
        size: 20.0,
        color: Colors.black54,
      ),
      backgroundColor: HexColor(appPrimaryColour),
      content: Container(
        height: size.height * 0.35,
        // color: HexColor(appPrimaryColour),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              DropDownListForCourseNames(
                universityName: widget.documentSnapshot.data()['University'],
                collegeName: widget.documentSnapshot.data()['College'],
                departmentName: widget.documentSnapshot.data()['Department'],
                selectedCourseName: _course,
                onpressed: (val) {
                  setState(() {
                    _course = val;
                    _selectedSemester = null;
                  });
                },
              ),
              DropDownListForYearData(
                universityName: widget.documentSnapshot.data()['University'],
                collegeName: widget.documentSnapshot.data()['College'],
                departmentName: widget.documentSnapshot.data()['Department'],
                courseName: _course,
                selectedYear: _selectedSemester,
                onpressed: (val) {
                  setState(() {
                    _selectedSemester = val;
                  });
                },
              ),
              RoundedInputField(
                hintText: 'Class Name',
                validator: (val) => val.isEmpty ? 'Field Mandatory' : null,
                onChanged: (val) {
                  _className = val;
                },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        _loading
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Loader(
                  spinnerColor: Colors.black54,
                  color: HexColor(appPrimaryColour),
                  size: 24.0,
                ),
              )
            : IconButton(
                icon: Icon(
                  Icons.done,
                ),
                onPressed: () async{
                 
                  if (_formkey.currentState.validate() && _course != null&&_selectedSemester!=null) {
                     setState(() {
                    _loading = !_loading;
                  });
                try {
                  await DatabaseService(uid: widget.uid)
                      .assignClassNames(_course, _className, _selectedSemester);
                  await DatabaseService(uid: widget.uid).addNewClass(
                      widget.documentSnapshot.data()['University'],
                      widget.documentSnapshot.data()['College'],
                      widget.documentSnapshot.data()['Department'],
                      _course,
                      _className,
                      _selectedSemester);
                       setState(() {
                    _loading = !_loading;
                  });

                  Navigator.of(context, rootNavigator: true).pop();
                } catch (e) {
                  print(e);
                }
              }
                })
      ],
    );
  }
}
