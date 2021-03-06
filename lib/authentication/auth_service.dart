import 'package:collegify/Screens/email_verification_screen/email_verification_screen.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

//this class is used for all auth services
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid, email: user.email) : null;
  }

  // Stream of user containing the uid
  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

//function to peform signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  // //function to verify the email
  // Future verifyEmail(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //      User user = userCredential.user;
  //      return _userFromFirebaseUser(user);

  //   } catch (e) {
  //     print(e.message.toString());
  //     rethrow;
  //   }
  // }

//function to login user
  Future loginWithEmailpasswd(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      rethrow;
    }
  }

//function to register user with credentials

  Future studentregisterWithEmailpasswd(
    String university,
    String college,
    String department,
    String course,
    String semester,
    String name,
    String regNumber,
    String role,
    String email,
    String password,
  ) async {
    try {
      //creates student user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      await DatabaseService(uid: user.uid).updateStudentData(university,
          college, department, course, name, regNumber, semester, role);
      await DatabaseService(uid: user.uid).assignStudents(
        university,
        college,
        department,
        course,
        semester,
        {
          'Name': name,
          'Uid': user.uid,
        },
      );

      return _userFromFirebaseUser(user);

      //adds the new user data to the database

    } on FirebaseAuthException catch (e) {
      print(e.message);

      rethrow;
    }
  }

//teacher register function
  Future teacherregisterWithEmailpasswd(
    String university,
    String college,
    String department,
    String name,
    String email,
    String password,
    String role,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      await DatabaseService(uid: user.uid)
          .updateTeacherData(university, college, department, name, role);
      // await DatabaseService(uid: user.uid).assignTeachers(
      //     university, college, department, name);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      rethrow;
    }
  }

  Future parentRegisterWithEmailPassword(
      String university,
      String college,
      String department,
      String course,
      String semester,
      String parentName,
      String wardName,
      String registrationNumber,
      String role,
      String email,
      String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      await DatabaseService(uid: user.uid).updateParentData(university, college,
          department,course,semester, parentName, wardName, registrationNumber, role);
     
    } on FirebaseAuthException catch (e) {
      print(e.code);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future checkStudentDataExists(
    String university,
    String college,
    String department,
    String course,
    String semester,
    String wardName,
    String registrationNumber,
  ) async {
     await DatabaseService().checkStudentExists(university,
          college, department, course, semester, registrationNumber, wardName);
  }
}
