import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

//this class is used for all auth services
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
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
      print(e.toString());
      return null;
    }
  }

//function to login user
  Future loginWithEmailpasswd(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      rethrow;
    }
  }

//function to register user with credentials

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
      //creates student user
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      //adds the new user data to the database
      await DatabaseService(uid: user.uid).updateStudentData(
          university, college, department, course, name, regNumber, year, role);

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      rethrow;
    }
  }

//teacher register function
  Future teacherregisterWithEmailpasswd(
    String university,
    String college,
    String department,
    String course,
    String name,
    String email,
    String password,
    String role,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;

      await DatabaseService(uid: user.uid).updateTeacherData(
          university, college, department, course, name, role);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());

      rethrow;
    }
  }

  Future parentRegisterWithEmailPassword(
      String university,
      String college,
      String department,
      String course,
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
      await DatabaseService(uid: user.uid)
          .updateParentData(university, college, department, course,parentName, wardName, registrationNumber, role);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
