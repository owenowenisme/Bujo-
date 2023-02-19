// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  String? _uid;
  String? _email;
  String? get getUid => _uid;
  String? get getEmail => _email;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> signUpUser(String email, String password) async {
    bool retVal = false;
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (_userCredential.user != null) {
        retVal = true;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<bool> loginUser(String email, String password) async {
    bool retVal = false;
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_userCredential.user != null) {
        _uid = _userCredential.user!.uid;
        _email = _userCredential.user!.email;
        retVal = true;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  // Future<bool> logoutUser() {
  //   return

  // }
}
