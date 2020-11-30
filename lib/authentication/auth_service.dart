import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_register_screen.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

//this class is used for all auth services
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signOut() async {
    try {
      SharedPreferences usertype = await SharedPreferences.getInstance();
      usertype.setInt('usertype', 0);
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future loginWithEmailpasswd(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future studentregisterWithEmailpasswd(
    String university,
    String college,
    String department,
    String course,
    String year,
    String name,
    String regNumber,
    String role,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      await DatabaseService(uid: user.uid).updateStudentData(
          university, college, department, course, year, name, regNumber, role);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      rethrow;
    }
  }

  Future teacherregisterWithEmailpasswd(String email, String password,
      String firstname, String lastname, String department, String role) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      await DatabaseService(uid: user.uid)
          .updateTeacherData(firstname, lastname, department, role);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      //return null;
      rethrow;
    }
  }

  // Future<Map<dynamic, dynamic>> get currentUserClaims async {
  //   final role = FirebaseAuth.instance.currentUser;
  //   final idTokenResult = await role.getIdTokenResult(true);
  //   return idTokenResult.claims;
  // }
}
