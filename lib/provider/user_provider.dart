import 'package:evently_app/firebase/firebasemanger.dart';
import 'package:evently_app/models/userdata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User? firebaseUser;
  Userdata? userdata;

  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initUser();
    }
  }

  initUser() async {
    userdata = await Firebasemanger.readUser();
    notifyListeners();
  }

  clearData() {
    firebaseUser = null;
    userdata = null;
    notifyListeners();
  }
}
