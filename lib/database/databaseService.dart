import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  //references of users
  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('users');

  Future updateStudentData(
      String university,
      String college,
      String department,
      String course,
      String name,
      String regNumber,
      String year,
      String role) async {
    return await userCollectionReference.doc(uid).set({
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

  Future updateTeacherData(String university, String college, String department,
      String course, String name, String role) async {
    return await userCollectionReference.doc(uid).set({
      'University': university,
      'College': college,
      'Departmnet': department,
      'course': course,
      'Current Year': 0,
      'Name': name,
      'role': role
    });
  }

  // adding new university

  Future addNewDepartment(
      String universityName, String collegeName, String departmentName) async {
    try {
      final DocumentReference newDepartmentDocument = FirebaseFirestore.instance
          .collection('college')
          .doc('$universityName')
          .collection('CollegeNames')
          .doc('$collegeName')
          .collection('DepartmentNames')
          .doc('$departmentName');
      return await newDepartmentDocument.set({"Department": departmentName});
    } catch (e) {
      rethrow;
    }
  }

  //add new college under a given university

  Future addNewCourse(String universityName, String collegeName,
      String departmentName, String courseName) async {
    try {
      final DocumentReference newCourseDocument = FirebaseFirestore.instance
          .collection('college')
          .doc('$universityName')
          .collection('CollegeNames')
          .doc('$collegeName')
          .collection('DepartmentNames')
          .doc('$departmentName')
          .collection('CourseNames')
          .doc('$courseName');
      return await newCourseDocument.set({"Course": courseName});
    } catch (e) {
      rethrow;
    }
  }

  // add new year
  Future addNewYear(String universityName, String collegeName,
      String departmentName, String courseName, String year) async {
    try {
      final DocumentReference newYearDocument = FirebaseFirestore.instance
          .collection('college')
          .doc('$universityName')
          .collection('CollegeNames')
          .doc('$collegeName')
          .collection('DepartmentNames')
          .doc('$departmentName')
          .collection('CourseNames')
          .doc('$courseName')
          .collection('years')
          .doc('$year');
      return await newYearDocument.set({"year": year});
    } catch (e) {
      rethrow;
    }
  }
}
