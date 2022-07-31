import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wedding_planner/themes.dart';

import '../main.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  Color unselectedIconColor = AppColours.secondary;
  Color selectedIconColor = AppColours.primary;
  bool selectedItem = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
          onTap: (buttonIndex) {
            switch (buttonIndex) {
              case 0:
                context.go('/home');
                setState(() {
                  _selectedIndex = 0;
                });
                break;
              case 1:
                context.go('/budget');
                setState(() {
                  _selectedIndex = 1;
                });
                break;
              case 2:
                context.go('/guests');
                setState(() {
                  _selectedIndex = 2;
                });
                break;
              case 3:
                context.go('/settings');
                setState(() {
                  _selectedIndex = 3;
                });
                break;
              case 4:
                context.go('/profile');
                setState(() {
                  _selectedIndex = 4;
                });
                break;
            }
          },
          currentIndex: widget.currentIndex,
          backgroundColor: AppColours.lightPink,
          unselectedItemColor: AppColours.primary,
          selectedItemColor: AppColours.pink,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money_outlined), label: 'Budget'),
            BottomNavigationBarItem(
                icon: Icon(Icons.mail_outlined), label: 'Guests'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity), label: 'Account'),
          ]),
    );
  }
}