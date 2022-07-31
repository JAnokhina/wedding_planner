import 'package:flutter/material.dart';
import 'package:wedding_planner/widgets/app_bar.dart';

class ToDos extends StatelessWidget {
  const ToDos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(title: 'I-Do\'s'),
      body: Container(),
    );
  }
}