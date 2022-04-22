import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/models/MyUser.dart';
import 'package:first_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//Create User obj based on FireBase User
  // MyUser? _userFromFirebaseUser1(User? user)//, String? email, String? firstName,
  //     //String? lastName, String? phoneNumber)
  //     {
  //   return user != null
  //       ? MyUser(
  //           uid: user.uid,
  //           email: user.email,
  //           firstName: FirebaseFirestore.instance.collection('devices').doc(user.uid).
  //           lastName: lastName,
  //           phoneNumber: phoneNumber)
  //       : null;
  // }

  MyUser? _userFromFirebaseUser(User? user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

//auth change user stream
  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

//sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign in email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // UserCredential result = await _auth.signInWithEmailAndPassword(
      //   email: email, password: password);
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: 'yuvalbader96@gmail.com', password: '1234566');
      User? user = result.user;
      //AuthCredential? credential = result.credential;

      print('FireBase respond:' + result.user.toString());
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithUserCredentials(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      print('FireBase respond:' + result.user.toString());
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//register with email & password
  Future registerWithEmailAndPassword(String email, String password,
      String firstName, String lastName, String phoneNumber) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      //Create a new document for the user with the id
      await DatabaseService(uid: user?.uid)
          .updateUserData(email, firstName, lastName, phoneNumber);

      return _userFromFirebaseUser(
          user); //, email, firstName, lastName, phoneNumber);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
