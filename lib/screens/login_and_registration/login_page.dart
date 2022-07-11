import 'package:flutter/material.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wedding_planner/widgets/sign_out_button.dart';
import 'package:wedding_planner/widgets/submit_button.dart';

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
        appBar: AppBar(
          title: const Text(
            'Welcome!!!',
            style: TextStyle(fontFamily: 'Mellony'),
          ),
          actions: <Widget>[
            Builder(builder: (BuildContext context) {
              return const SignOutButton();
            })
          ],
        ),
        body: Container(
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
              Image.asset(
                'assets/logo.png',
                color: Colors.white,
                scale: 2,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LoginForm(),
                ),
              ),
            ],
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
  bool _success = false;
  String _userEmail = '';
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: displayHeight(context) * 0.5,
      child: Form(
        key: _loginFormKey,
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
            SubmitButton(
              buttonName: 'Log In',
              onPressedFunction: () async {
                if ((_loginFormKey.currentState)!.validate()) {
                  _signInWithEmailAndPassword();
                }
              },
            ),
            // Container(
            //   alignment: Alignment.center,
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Text(
            //     _success == null
            //         ? ''
            //         : (_success
            //             ? 'Successfully signed in ' + _userEmail
            //             : 'Sign in failed'),
            //     style: const TextStyle(color: Colors.red),
            //   ),
            // )
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
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _success = false;
        print('User is currently signed out!');
      } else {
        _success = true;
        print('User is signed in!');
      }
    });

    // if (user != null) {
    //   setState(() {
    //     _success = true;
    //     _userEmail = user.email!;
    //   });
    // } else {
    //   setState(() {
    //     _success = false;
    //   });
    // }
  }
}