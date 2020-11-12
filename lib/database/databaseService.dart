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
      .collection('studentusers');
  //final CollectionReference teacherCollection = FirebaseFirestore.instance.collection('Kannur University').doc('Stems').collection('collectionPath').
  Future updateStudentData(
      String name, String regNumber, String course, String currentYear) async {
    return await studentCollection.doc(name).set({
      'Name': name,
      'Registration Number': regNumber,
      'course': course,
      'Current Year': currentYear
    });
  }

  // Future updateTeacherData(
  //     String firstName, String lastName, String teacherID) async {
  //   return await studentCollection.doc(uid).set({
  //     'first_name': firstName,
  //     'last_name': lastName,
  //     'teacher_id': teacherID,
  //   });
  // }

  Stream<QuerySnapshot> get studentUsers {
    return studentCollection.snapshots();
  }
}
