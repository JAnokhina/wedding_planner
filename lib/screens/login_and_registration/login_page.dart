import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/screens/login_and_registration/registration_page.dart';
import 'package:wedding_planner/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedding_planner/widgets/sign_out_button.dart';
import 'package:wedding_planner/widgets/submit_button.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/entry_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: WPAppBar(title: 'Log In', actions: const [SignOutButton()]),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          reverse: false,
          child: Container(
            width: displayWidth(context),
            height: displayHeight(context),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColours.primary,
                    Color.fromRGBO(255, 255, 255, 1)
                  ]),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 46),
                  child: Image.asset(
                    'assets/logo.png',
                    color: Colors.white,
                    scale: 1.4,
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: LoginForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _passwordVisible = false;
  bool _showErrorMessage = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.41,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        borderSide: BorderSide(color: Colors.red),
                        gapPadding: 0),
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
                        borderSide: BorderSide(color: Colors.red),
                        gapPadding: 0),
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
// Login button
            SubmitButton(
              buttonName: 'Log In',
              onPressedFunction: () async {
                if ((_loginFormKey.currentState)!.validate()) {
                  _signInWithEmailAndPassword();
                }
                SystemChannels.textInput.invokeMethod('TextInput.hide');
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Forgot password
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forgot your password?',
                      style: TextStyle(
                          fontFamily: 'Gothic',
                          fontSize: 13,
                          color: AppColours.primary),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Click Here',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        height: 2,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.white,
                        height: 2,
                        indent: 8,
                      ),
                    ),
                  ],
                ),
// Create account button
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an account?',
                        style: TextStyle(fontSize: 14),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationPage()),
                            );
                          },
                          child: const Text(
                            'Create one',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _showErrorMessage = true;
          errorMessage = 'No user found for that email.';
        });
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        setState(() {
          _showErrorMessage = true;
          errorMessage = 'Wrong password provided for that user.';
        });
        print('Wrong password provided for that user.');
      } else {
        setState(() {
          _showErrorMessage = true;
          errorMessage = 'Please enter a valid email and/or password';
        });
      }
    }
    // final User? user = (await _auth.signInWithEmailAndPassword(
    //   email: _emailController.text,
    //   password: _passwordController.text,
    // ))
    //     .user;
    //
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     print('User is currently signed out!');
    //   } else {
    //     print('User is signed in!');
    //   }
    // });

    // if (user != null) {
    //   setState(() {
    //     _showErrorMessage = true;
    //     _success = true;
    //     _userEmail = user.email!;
    //   });
    // } else {
    //   setState(() {
    //     _showErrorMessage = false;
    //     _success = false;
    //   });
    // }
  }
}