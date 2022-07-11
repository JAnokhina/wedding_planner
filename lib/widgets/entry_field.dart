import 'package:flutter/material.dart';
import 'package:wedding_planner/themes.dart';

class EntryField extends StatefulWidget {
  const EntryField({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<EntryField> createState() => _EntryFieldState();
}

class _EntryFieldState extends State<EntryField> {
  var borderColour = AppColours.primary;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
                color: borderColour, style: BorderStyle.solid, width: 1)),
        child: widget.child);
  }
}