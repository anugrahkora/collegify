import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/student_screen/student_home/student_analytics.dart';
import 'package:collegify/Screens/student_screen/student_home/student_userDetails.dart';

class DatabaseService {
  final String uid;
  final String name;

  DatabaseService({
    this.uid,
    this.name,
  });

  final CollectionReference studentCollection = FirebaseFirestore.instance
      .collection('kannur_university')
      .doc('stems')
      .collection('users');
  //final CollectionReference teacherCollection = FirebaseFirestore.instance.collection('Kannur University').doc('Stems').collection('collectionPath').
  Future updateStudentData(String name, String regNumber, String course,
      String currentYear, String role) async {
    return await studentCollection.doc(uid).set({
      'Name': name,
      'Registration Number': regNumber,
      'course': course,
      'Current Year': currentYear,
      'role': role
    });
  }

  Future updateTeacherData(
      String firstName, String lastName, String department, String role) async {
    return await studentCollection.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'department': department,
      'role': role,
    });
  }

  Stream<QuerySnapshot> get studentUsers {
    return studentCollection.snapshots();
  }
}
