import 'package:firebase_auth/firebase_auth.dart';
import '../firebase_models/user_model.dart';

class AuthService {
  static bool showErrorMessage = false;
  static String errorMessage = '';

  /// creates a userModel object based on signed in user from Firebase
  UserModel? userModelFromAuth(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid, email: user.email.toString());
    } else {
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showErrorMessage = true;
        errorMessage = 'No user found for that email.';
        print('No user found for that email.');
        return null;
      } else if (e.code == 'wrong-password') {
        showErrorMessage = true;
        errorMessage = 'Wrong password provided for that user.';
        print('Wrong password provided for that user.');
        return null;
      } else {
        showErrorMessage = true;
        errorMessage = 'Please enter a valid email and/or password';
        return null;
      }
    }
  }

  Future<User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      print(user);
      // if (user != null && !user.emailVerified) {
      //   await user.sendEmailVerification();
      //   user = FirebaseAuth.instance.currentUser;
      // }
      //ToDO check if registration success or not and return some variable
      Future.delayed(Duration(seconds: 5));
      if (user == null) {
        return null;
      } else {
        showErrorMessage = false;
        await user.sendEmailVerification();
        user = FirebaseAuth.instance.currentUser;
        return user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showErrorMessage = true;
        errorMessage = 'The password provided is too weak.';

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showErrorMessage = true;
        errorMessage = 'The account already exists for that email.';

        print('The account already exists for that email.');
      } else {
        print(e.message);

        showErrorMessage = true;
        errorMessage = 'Something went wrong, please try again.';
      }
    } catch (e) {
      print('Other exception');
      print(e);
      showErrorMessage = true;
      errorMessage = 'Something went wrong, registration was unsuccessful';
    }
  }
}