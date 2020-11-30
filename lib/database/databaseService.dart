import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('college');

  Future checkUserRole(String institution, String university, String college,
      String department, String course) async {
    try {
      //todo implement role checking

    } catch (e) {}
  }

  Future updateStudentData(
      String university,
      String college,
      String department,
      String course,
      String name,
      String regNumber,
      String year,
      String role) async {
    return await collectionReference
        .doc(university)
        .collection('CollegeNames')
        .doc(college)
        .collection('DepartmentNames')
        .doc(department)
        .collection('CourseNames')
        .doc(course)
        .collection('users')
        .doc(uid)
        .set({
      'University': university,
      'College': college,
      'Departmnet': department,
      'course': course,
      'Current Year': year,
      'Name': name,
      'Registration Number': regNumber,
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

  // adding new university

  Future addNewUniversity(String universityName) async {
    try {
      final DocumentReference newUniversityDocument = FirebaseFirestore.instance
          .collection('college')
          .doc('$universityName');
      return await newUniversityDocument
          .set({"UniversityName": universityName});
    } catch (e) {
      rethrow;
    }
  }

  //add new college uner a given university

  Future addNewCollege(String universityName, String collegeName) async {
    try {
      final DocumentReference newCollegeDocument = FirebaseFirestore.instance
          .collection('college')
          .doc('$universityName')
          .collection('CollegeNames')
          .doc('$collegeName');
      return await newCollegeDocument.set({"Collegename": collegeName});
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> get userCollection {
    return collectionReference.snapshots();
  }
}
