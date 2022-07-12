import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedding_planner/widgets/entry_field.dart';

import '../../main.dart';
import '../../themes.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/submit_button.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(title: 'Registration'),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        reverse: true,
        child: Container(
          width: displayWidth(context),
          height: displayHeight(context),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColours.primary, Color.fromRGBO(255, 255, 255, 1)]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Image.asset(
                  'assets/logo.png',
                  color: Colors.white,
                  scale: 1.4,
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 45),
                  child: RegistrationForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();

  bool _passwordVisible = false;
  bool _visiblePasswordVisible = false;
  bool _showErrorMessage = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
// Email
          EntryField(
            child: TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: AppColours.primary,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        _emailController.clear();
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: AppColours.primary,
                      )),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red), gapPadding: 0),
                  errorStyle: const TextStyle(height: 0),
                  hintText: 'Email Address',
                  hintStyle: const TextStyle(
                      fontFamily: 'Gothic',
                      fontSize: 14,
                      color: AppColours.secondary),
                  border: InputBorder.none),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '';
                }
                return null;
              },
            ),
          ),
// Password
          EntryField(
            child: TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              obscureText: !_passwordVisible,
              cursorColor: AppColours.primary,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColours.primary,
                      )),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red), gapPadding: 0),
                  errorStyle: const TextStyle(height: 0),
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                      fontFamily: 'Gothic',
                      fontSize: 14,
                      color: AppColours.secondary),
                  border: InputBorder.none),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '';
                }
                return null;
              },
            ),
          ),
// Verify Password
          EntryField(
            child: TextFormField(
              controller: _verifyPasswordController,
              keyboardType: TextInputType.text,
              obscureText: !_visiblePasswordVisible,
              cursorColor: AppColours.primary,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _visiblePasswordVisible = !_visiblePasswordVisible;
                        });
                      },
                      icon: Icon(
                        _visiblePasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColours.primary,
                      )),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red), gapPadding: 0),
                  errorStyle: const TextStyle(height: 0),
                  hintText: 'Verify password',
                  hintStyle: const TextStyle(
                      fontFamily: 'Gothic',
                      fontSize: 14,
                      color: AppColours.secondary),
                  border: InputBorder.none),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    _passwordController.text !=
                        _verifyPasswordController.text) {
                  errorMessage = 'Your passwords do not match';
                  return '';
                }
                return null;
              },
            ),
          ),
          // Login button
          SubmitButton(
            buttonName: 'Sign Up',
            onPressedFunction: () async {
              SystemChannels.textInput.invokeMethod('TextInput.hide');
              if ((_registerFormKey.currentState)!.validate()) {
                _register();
              } else {}
            },
          ),
          Visibility(
            visible: _showErrorMessage,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          _showErrorMessage = true;
          errorMessage = 'The password provided is too weak.';
        });
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        setState(() {
          _showErrorMessage = true;
          errorMessage = 'The account already exists for that email.';
        });
        print('The account already exists for that email.');
      } else {
        setState(() {
          _showErrorMessage = true;
          errorMessage = 'Something went wrong, please try again.';
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _showErrorMessage = true;
        errorMessage = 'Something went wrong, registration was unsuccessful';
      });
    }
  }
}