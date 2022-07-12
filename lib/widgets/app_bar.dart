import 'package:flutter/material.dart';
import 'package:wedding_planner/main.dart';

class WPAppBar extends StatelessWidget implements PreferredSizeWidget {
  WPAppBar({Key? key, required this.title, this.actions}) : super(key: key);
  final String title;
  List<Widget>? actions = [];

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          title,
          style: TextStyle(fontFamily: 'Mellony'),
        ),
        actions: actions);
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(50);
  }
}