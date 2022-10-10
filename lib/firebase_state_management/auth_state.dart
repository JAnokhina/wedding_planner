import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wedding_planner/firebase_services/auth_service.dart';
import 'package:wedding_planner/locator.dart';

class AuthState extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  logIn({required String email, required String password}) async {
    await locator<AuthService>().signInWithEmailAndPassword(email, password);
  }

  register({required String email, required String password}) async {
    await locator<AuthService>().register(email, password);
  }

  logOut() async {
    await _auth.signOut();
  }
}