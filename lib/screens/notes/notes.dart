import 'package:flutter/material.dart';
import 'package:wedding_planner/widgets/app_bar.dart';

class Notes extends StatelessWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(title: 'Notes'),
      body: Container(),
    );
  }
}