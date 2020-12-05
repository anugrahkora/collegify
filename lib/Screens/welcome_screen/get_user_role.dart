import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/student_screen/student_home/student_navigation.dart';
import 'package:flutter/material.dart';

class GetUserRole extends StatelessWidget {
  final String uid;

  GetUserRole({this.uid});

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        } else {
          print(snapshot.data['role']);
          return StudentNavigationScreen();
        }
      },
    );
  }
}
