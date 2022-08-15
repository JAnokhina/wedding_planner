import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedding_planner/models/user.dart';

class AuthService {
  /// creates a userModel object based on signed in user from Firebase
  UserModel? _userModelFromAuth(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  Future<User?> _signInWithEmailAndPassword(
      String email, String password) async {
    bool _showErrorMessage = false;
    String errorMessage = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showErrorMessage = true;
        errorMessage = 'No user found for that email.';
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        _showErrorMessage = true;
        errorMessage = 'Wrong password provided for that user.';
        print('Wrong password provided for that user.');
        return null;
      } else {
        _showErrorMessage = true;
        errorMessage = 'Please enter a valid email and/or password';
        return null;
      }
    }
  }

  void _register(String email, String password) async {
    bool _showErrorMessage = false;
    String errorMessage = '';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      print(user);
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        user = FirebaseAuth.instance.currentUser;
      }
      //ToDO check if registration success or not and return some variable
      // Future.delayed(Duration(seconds: 5));
      // if (user == null) {
      //   loadingScreen(context);
      // } else {
      //   Navigator.of(context)
      //       .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showErrorMessage = true;
        errorMessage = 'The password provided is too weak.';

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        _showErrorMessage = true;
        errorMessage = 'The account already exists for that email.';

        print('The account already exists for that email.');
      } else {
        print(e.message);

        _showErrorMessage = true;
        errorMessage = 'Something went wrong, please try again.';
      }
    } catch (e) {
      print('Other exception');
      print(e);
      _showErrorMessage = true;
      errorMessage = 'Something went wrong, registration was unsuccessful';
    }
  }
}