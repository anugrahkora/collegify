import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    this.uid,
  });

  //references of users
  final CollectionReference userCollectionReference =
      FirebaseFirestore.instance.collection('users');
//setting student data
  Future updateStudentData(
      String university,
      String college,
      String department,
      String course,
      String name,
      String regNumber,
      String semester,
      String role) async {
    return await userCollectionReference.doc(uid).set({
      'Uid': uid,
      'University': university,
      'College': college,
      'Department': department,
      'Course': course,
      'Semester': semester,
      'Name': name,
      'Registration_Number': regNumber,
      'Role': role
    });
  }

  //setting teacher data

  Future updateTeacherData(String university, String college, String department,
      String course, String name, String role) async {
    try {
      return await userCollectionReference.doc(uid).set({
        'Uid': uid,
        'University': university,
        'College': college,
        'Department': department,
        'Course': course,
        'Semester': 0,
        'Name': name,
        'Role': role,
      });
    } catch (e) {}
  }

  //setting parent data

  Future updateParentData(
      String university,
      String college,
      String department,
      String course,
      String parentName,
      String wardName,
      String registrationNumber,
      String role) async {
    return await userCollectionReference.doc(uid).set({
      'Uid': uid,
      'University': university,
      'College': college,
      'Department': department,
      'Course': course,
      'Name': parentName,
      'Ward_Name': wardName,
      'Registration_Number': registrationNumber,
      'Role': role,
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
      String departmentName, String courseName, String semester) async {
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
          .collection('Semester')
          .doc('$semester');
      return await newYearDocument.set({"Semester": semester});
    } catch (e) {
      rethrow;
    }
  }

//add new class for teachers
  Future addNewClass(String className, String semester) async {
    try {
      final DocumentReference newClassDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Classes')
          .doc(className);
      return await newClassDocument.set({
        'ClassName': className,
        'Semester': semester,
      });
    } catch (e) {
      rethrow;
    }
  }

  //create an array of the student names in the semester document of each courses
  Future assignStudents(
      String universityName,
      String collegeName,
      String departmentName,
      String courseName,
      String semester,
      String name) async {
    try {
      final DocumentReference assignTeacherDocument = FirebaseFirestore.instance
          .collection('college')
          .doc('$universityName')
          .collection('CollegeNames')
          .doc('$collegeName')
          .collection('DepartmentNames')
          .doc('$departmentName')
          .collection('CourseNames')
          .doc('$courseName')
          .collection('Semester')
          .doc('$semester');
      return await assignTeacherDocument.update({
        'Student_Names': FieldValue.arrayUnion([name]),
      });
    } catch (e) {
      rethrow;
    }
  }

  //create an array of the teacher names in the semester document of each courses
  Future assignTeachers(
      String universityName,
      String collegeName,
      String departmentName,
      String courseName,
      String semester,
      String name) async {
    try {
      final DocumentReference assignTeacherDocument = FirebaseFirestore.instance
          .collection('college')
          .doc('$universityName')
          .collection('CollegeNames')
          .doc('$collegeName')
          .collection('DepartmentNames')
          .doc('$departmentName')
          .collection('CourseNames')
          .doc('$courseName')
          .collection('Semester')
          .doc('$semester');
      return await assignTeacherDocument.update({
        'Teacher_Names': FieldValue.arrayUnion([name]),
      });
    } catch (e) {
      rethrow;
    }
  }
}
