import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/create_notes_screen.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';


import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherHome extends StatefulWidget {
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  bool loading = false;
  List<QueryDocumentSnapshot> classList = new List<QueryDocumentSnapshot>();
  DocumentSnapshot snapshot;
  String _className;
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
    return classList.isEmpty
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              splashColor: HexColor(appSecondaryColour),
              hoverElevation: 20,
              elevation: 3.0,
              backgroundColor: const Color(0xff03dac6),
              foregroundColor: Colors.black,
              onPressed: () async {
                try {
                  _openPopup(context, user.uid);
                } catch (e) {}
              },
              child: Icon(Icons.add),
            ),
            backgroundColor: HexColor(appPrimaryColour),
            body: Container(
              child: HeadingText(
                color: Colors.black87,
                text: 'No classes have been added',
                size: 20,
              ),
            ),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              splashColor: HexColor(appSecondaryColour),
              hoverElevation: 20,
              elevation: 3.0,
              backgroundColor: const Color(0xff03dac6),
              foregroundColor: Colors.black,
              onPressed: () async {
                try {
                  _openPopup(context, user.uid);
                } catch (e) {}
              },
              child: Icon(Icons.add),
            ),
            backgroundColor: HexColor(appPrimaryColour),
            body: SafeArea(
              child: buildListView(size),
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
                  text: classList[index].data()['ClassName'],
                  size: 23,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateNoteScreen(
                        snapshot: snapshot,
                        className: classList[index].data()['ClassName'],
                        year: classList[index].data()['Semester'],
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

  // popup function
  _openPopup(context, String _uid) {
    String semester;
    final _formkey = GlobalKey<FormState>();
    Alert(
        style: AlertStyle(
          backgroundColor: HexColor(appPrimaryColour),
          isOverlayTapDismiss: false,
          alertBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        context: context,
        title: "Class Name",
        content: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              RoundedInputField(
                hintText: 'Class Name',
                validator: (val) => val.isEmpty ? 'Field Mandatory' : null,
                onChanged: (val) {
                  _className = val;
                },
              ),
              RoundedInputFieldNumbers(
                hintText: 'Semester',
                validator: (val) => val.isEmpty? 'Field Mandatory' : null,
                onChanged: (val) {
                  semester = val;
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            
            radius: BorderRadius.circular(20),
            color: HexColor(appSecondaryColour),
            onPressed: () async {
              if (_formkey.currentState.validate()) {
                try {
                  await DatabaseService(uid: _uid).addNewClass(_className,semester);
                  Navigator.of(context, rootNavigator: true).pop();
                } catch (e) {
                  print(e);
                }
              }
            },
            child: HeadingText(
              text: 'Add',
              color: Colors.white,
              size: 18,
            ),
          )
        ]).show();
  }
}
