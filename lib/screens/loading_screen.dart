import 'package:flutter/material.dart';
import 'package:wedding_planner/themes.dart';

Scaffold loadingScreen(context) {
  // Timer(
  //     const Duration(seconds: 30),
  //     () => showDialog(
  //           context: context,
  //           builder: (BuildContext context) => AlertDialog(
  //             title: const Text(
  //                 'Something went wrong... Data was not loaded successfully',
  //                 style: TextStyle(fontFamily: 'Roboto-Regular', fontSize: 12)),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   // context.go('/inthecity');
  //                   context.pop();
  //                 },
  //                 child: const Text(
  //                   'Ok',
  //                   style: TextStyle(color: ColorPalette.white),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ));
  return Scaffold(
      body: Center(
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 50,
      child: const CircularProgressIndicator(
        color: AppColours.primary,
      ),
    ),
  ));
}
