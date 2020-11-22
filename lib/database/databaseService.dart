import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('kannur_university')
      .doc('stems')
      .collection('users');
  Future checkUserRole(DocumentSnapshot snapshot) async {
    try {
      //todo implement role checking
    } catch (e) {}
  }

  Future updateStudentData(String name, String regNumber, String course,
      String currentYear, String role) async {
    return await collectionReference.doc(uid).set({
      'Name': name,
      'Registration Number': regNumber,
      'course': course,
      'Current Year': currentYear,
      'role': role
    });
  }

  Future updateTeacherData(
      String firstName, String lastName, String department, String role) async {
    return await collectionReference.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'department': department,
      'role': role,
    });
  }

  Stream<QuerySnapshot> get userCollection {
    return collectionReference.snapshots();
  }
}
