import 'package:flutter/material.dart';
import 'package:wedding_planner/widgets/app_bar.dart';

import '../../widgets/bottom_nav_bar.dart';

class Budget extends StatelessWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(
        title: 'Budget',
      ),
      body: Container(),
      bottomNavigationBar: BottomNavBar(currentIndex: 1),
    );
  }
}