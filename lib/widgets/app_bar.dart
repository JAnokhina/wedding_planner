import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WPAppBar extends StatelessWidget implements PreferredSizeWidget {
  WPAppBar({Key? key, required this.title, this.actions, this.showBackButton})
      : super(key: key);
  final String title;
  List<Widget>? actions = [];
  bool? showBackButton = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // leading: (showBackButton == true)
        //     ?
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            context.pop();
          },
        ),
        // : null,
        title: Text(
          title,
          style: const TextStyle(fontFamily: 'Mellony'),
        ),
        actions: actions);
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(50);
  }
}