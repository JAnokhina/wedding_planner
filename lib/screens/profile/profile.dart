import 'package:flutter/material.dart';

import '../../widgets/app_bar.dart';
import '../../widgets/bottom_nav_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WPAppBar(
        title: 'Profile',
      ),
      body: Container(),
      bottomNavigationBar: BottomNavBar(currentIndex: 4),
    );
  }
}