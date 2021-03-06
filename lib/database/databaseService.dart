import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

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
      String name, String role) async {
    try {
      return await userCollectionReference.doc(uid).set({
        'Uid': uid,
        'University': university,
        'College': college,
        'Department': department,
        'Name': name,
        'Role': role,
      });
    } catch (e) {
      rethrow;
    }
  }

  //setting parent data

  Future updateParentData(
      String university,
      String college,
      String department,
      String course,
      String semester,
      String parentName,
      String wardName,
      String registrationNumber,
      String role) async {
    try {
      return await userCollectionReference.doc(uid).set({
        'Uid': uid,
        'University': university,
        'College': college,
        'Department': department,
        'Course': course,
        'Semester': semester,
        'Name': parentName,
        'Ward_Name': wardName,
        'Registration_Number': registrationNumber,
        'Role': role,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future checkStudentExists(
    String university,
    String college,
    String department,
    String course,
    String semester,
    String registrationNumber,
    String wardName,
  ) async {
    try {
      await userCollectionReference
          .where('University', isEqualTo: university)
          .where('College', isEqualTo: college)
          .where('Department', isEqualTo: department)
          .where('Course', isEqualTo: course)
          .where('Semester', isEqualTo: semester)
          .where('Registration_Number', isEqualTo: registrationNumber)
          .where('Name', isEqualTo: wardName)
          .get();
    } catch (e) {
      return null;
    }
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
      return await newYearDocument.update({"Semester": semester});
    } catch (e) {
      rethrow;
    }
  }

  // assign new class names to teacher
  Future assignClassNames(
      String course, String className, String semester) async {
    try {
      final DocumentReference newClassDocument = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('Classes')
          .doc(className);
      return await newClassDocument.set({
        'Course': course,
        'ClassName': className,
        'Semester': semester,
      });
    } catch (e) {
      rethrow;
    }
  }

//add new class in courses
  Future addNewClass(
      String universityName,
      String collegeName,
      String departmentName,
      String courseName,
      String className,
      String semester) async {
    try {
      final DocumentReference newClassDocument = FirebaseFirestore.instance
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
      return await newClassDocument.update({
        'Classes': FieldValue.arrayUnion([className]),
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

  //create an array of the student names in the semester document of each courses
  Future assignStudents(
      String universityName,
      String collegeName,
      String departmentName,
      String courseName,
      String semester,
      Map<String, String> name) async {
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
        'Students': FieldValue.arrayUnion([name]),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future markAttendancePresent(
      String universityName,
      String collegeName,
      String departmentName,
      String courseName,
      String className,
      String semester,
      String date,
      Map<String, String> name) async {
    try {
      final DocumentReference markAttendancePresentDocument = FirebaseFirestore
          .instance
          .collection('college')
          .doc('$universityName')
          .collection('CollegeNames')
          .doc('$collegeName')
          .collection('DepartmentNames')
          .doc('$departmentName')
          .collection('CourseNames')
          .doc('$courseName')
          .collection('Semester')
          .doc('$semester')
          .collection('Attendance')
          .doc(className)
          .collection('Dates')
          .doc(date);
      return await markAttendancePresentDocument.update({
        'Students': FieldValue.arrayUnion([name]),
      });
    } on FirebaseException catch (e) {
      return e.code;
    }
  }

  Future createNewAttendanceDocument(
    String universityName,
    String collegeName,
    String departmentName,
    String courseName,
    String className,
    String semester,
    String date,
     Map<String, String> name,
  ) async {
    try {
      final DocumentReference createNewAttendanceDocument = FirebaseFirestore
          .instance
          .collection('college')
          .doc('$universityName')
          .collection('CollegeNames')
          .doc('$collegeName')
          .collection('DepartmentNames')
          .doc('$departmentName')
          .collection('CourseNames')
          .doc('$courseName')
          .collection('Semester')
          .doc('$semester')
          .collection('Attendance')
          .doc(className)
          .collection('Dates')
          .doc(date);
           return await createNewAttendanceDocument.set({
        // 'Students': FieldValue.arrayUnion([name]),
      });
    } on FirebaseException catch (e) {
      return e.code;
    }
  }

}
