import 'package:cloud_firestore/cloud_firestore.dart';
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
    Size size = MediaQuery.of(context).size;
    final user = Provider.of<UserModel>(context);
    getClass(user.uid);
    return Scaffold(
      backgroundColor: HexColor(appPrimaryColour),
      body: SafeArea(
        child: Column(
          
          children: [
            Container(
               margin: EdgeInsets.all(30),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      height: 160.0,
      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(29),
      ),
              child: Center(child: HeadingText(color: Colors.black87,text: classList[0],size: 20,)),
            ),
          ],
        ),
      ),
    );
  }
}
