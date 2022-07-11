import 'package:flutter/material.dart';
import 'package:wedding_planner/main.dart';

import '../themes.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton(
      {Key? key, required this.buttonName, required this.onPressedFunction})
      : super(key: key);
  final String buttonName;
  final Function() onPressedFunction;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(displayWidth(context), 45),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
        onPressed: widget.onPressedFunction,
        child: Text(widget.buttonName),
      ),
    );
  }
}