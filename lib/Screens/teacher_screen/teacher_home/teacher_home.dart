import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:collegify/shared/components/constants.dart';
import 'package:collegify/shared/components/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class TeacherHome extends StatefulWidget {
  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  bool loading = false;
  List<String> classList = new List<String>();
  //getting the list of classes
  Future getClass(String uid) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    await firebaseFirestore.collection('users').doc(uid).get().then((docs) {
      classList = List.from(docs.data()['Subjects']);
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
            appBar: AppBar(
              leading: GestureDetector(
                child: Icon(
                  Icons.menu,
                ),
              ),
              title: HeadingText(
                text: 'Classes',
                color: Colors.black87,
              ),
              backgroundColor: HexColor(appPrimaryColour),
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
            floatingActionButton: FloatingActionButton.extended(
              splashColor: HexColor(appSecondaryColour),
              hoverElevation: 20,
              elevation: 3.0,
              backgroundColor: const Color(0xff03dac6),
              foregroundColor: Colors.black,
              onPressed: () async {
                try {
                  await DatabaseService(uid: user.uid).addNewClass('python');
                } catch (e) {
                  print(e);
                }
              },
              icon: Icon(Icons.add),
              label: HeadingText(
                color: Colors.black,
                text: 'new class',
                size: 13,
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(29),
              ),
              child: HeadingText(
                color: Colors.black87,
                text: classList[index],
                size: 20,
              ),
            ),
          ],
        );
      },
    );
  }
}
