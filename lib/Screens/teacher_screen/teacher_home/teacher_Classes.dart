import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/Teacher_Navigation.dart';
import 'package:collegify/Screens/teacher_screen/teacher_home/create_notes_screen.dart';
import 'package:collegify/authentication/auth_service.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';

import 'package:flutter/material.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherHome extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const TeacherHome({Key key, this.documentSnapshot}) : super(key: key);
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  bool loading = false;
  List<QueryDocumentSnapshot> classList = new List<QueryDocumentSnapshot>();
  DocumentSnapshot snapshot;
  String _className;
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
    return classList.isEmpty
        ? Scaffold(
            floatingActionButton: FloatingActionButton(
              splashColor: HexColor(appSecondaryColour),
              hoverElevation: 20,
              elevation: 3.0,
              backgroundColor: Colors.white,
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
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black54, //change your color here
              ),
              backgroundColor: Colors.white,
              title: HeadingText(
                alignment: Alignment.topLeft,
                text: "Classes",
                color: Colors.black54,
              ),
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
                    child: ImageIcon(
                      AssetImage('assets/icons/iconTeacherLarge.png'),
                      color: Colors.black54,
                      size: 50,
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
                    onTap: () async{
                     await _authService.signOut();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeadingText(
                          alignment: Alignment.topLeft,
                          color: Colors.black54,
                          text: classList[index].data()['ClassName'],
                          size: 23,
                        ),
                        // SizedBox(width: 25.0,),
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

  // popup function
  _openPopup(context, String _uid) {
    String semester;
    final _formkey = GlobalKey<FormState>();
    Alert(
        style: AlertStyle(
          backgroundColor: HexColor(appPrimaryColour),
          isOverlayTapDismiss: false,
          alertBorder: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        context: context,
        title: "",
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
                validator: (val) => val.isEmpty ? 'Field Mandatory' : null,
                onChanged: (val) {
                  semester = val;
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            height: 50.0,
            width: 100.0,
             radius: BorderRadius.circular(0.0),
            color: HexColor(appPrimaryColourDark),
            onPressed: () async {
              if (_formkey.currentState.validate()) {
                try {
                  setState(() {
                    loading = true;
                  });
                  await DatabaseService(uid: _uid)
                      .addNewClass(_className, semester);
                  setState(() {
                    loading = false;
                  });
                  Navigator.of(context, rootNavigator: true).pop();
                } catch (e) {
                  print(e);
                }
              }
            },
            child: loading
                ? Loader(
                    color: HexColor(appSecondaryColour),
                    size: 18,
                  )
                : HeadingText(
                    text: 'Add',
                    color: Colors.black54,
                    size: 18,
                  ),
          )
        ]).show();
  }
}
