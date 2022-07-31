import 'package:flutter/material.dart';
import 'package:wedding_planner/themes.dart';

class GridItem extends StatelessWidget {
  const GridItem({Key? key, required this.icon, required this.name})
      : super(key: key);
  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: AppColours.lightPink,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            icon,
            size: 40,
            color: AppColours.primary,
          ),
          Text(
            name,
            style: const TextStyle(color: AppColours.pink),
          ),
        ],
      ),
    );
  }
}