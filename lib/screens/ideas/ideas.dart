import 'package:flutter/material.dart';
import 'package:wedding_planner/widgets/app_bar.dart';

class Ideas extends StatelessWidget {
  const Ideas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(title: 'Ideas'),
      body: Container(),
    );
  }
}