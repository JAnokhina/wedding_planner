import 'package:flutter/material.dart';
import 'package:wedding_planner/widgets/app_bar.dart';

class Vendors extends StatelessWidget {
  const Vendors({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(title: 'Vendors'),
      body: Container(),
    );
  }
}