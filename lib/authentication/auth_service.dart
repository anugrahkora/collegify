import 'package:collegify/Screens/student_screen/student_auth_screens/student_login_screen.dart';
import 'package:collegify/Screens/student_screen/student_auth_screens/student_register_screen.dart';
import 'package:collegify/database/databaseService.dart';
import 'package:collegify/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //final String message;
  //AuthService({this.message});
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

  Future studentregisterWithEmailpasswd(String email, String password,
      String name, String course, String year, String regNumber) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      await DatabaseService(uid: user.uid, name: name)
          .updateStudentData(name, regNumber, course, year);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());

      return null;
    }
  }

  Future loginWithEmailpasswd(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future teacherregisterWithEmailpasswd(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     User user = userCredential.user;
  //     await DatabaseService(uid: user.uid)
  //         .updateTeacherData('firstName', 'lastName', 'teacherID');
  //     return _userFromFirebaseUser(user);
  //   } on FirebaseAuthException catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
}
