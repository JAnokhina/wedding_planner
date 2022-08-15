import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text(
        'Sign out',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        final User? user = await _auth.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('No one has signed in.'),
          ));
          return;
        }
        await _auth.signOut();
        final String uid = user.uid;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$uid has successfully signed out.'),
        ));
        context.go('/login');
      },
    );
  }
}