import 'package:flutter/material.dart';
import 'package:wedding_planner/themes.dart';

import '../main.dart';

Scaffold errorScreen(context) {
  return Scaffold(
      body: Center(
    child: Container(
      width: displayWidth(context),
      height: displayHeight(context),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColours.primary, Colors.white]),
      ),
      child: const Text('Something went wrong'),
    ),
  ));
}
