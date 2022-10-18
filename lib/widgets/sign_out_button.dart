import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/firebase_state_management/auth_state.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context);
    return TextButton(
      child: const Text(
        'Log out',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () async {
        final User? user = await authState.getCurrentUser();
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('No one has signed in.'),
          ));
          return;
        }
        await authState.logOut();
        final String uid = user.uid;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('$uid has successfully signed out.'),
        ));
        context.go('/login');
      },
    );
  }
}