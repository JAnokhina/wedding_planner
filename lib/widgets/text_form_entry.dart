import 'package:flutter/material.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/themes.dart';

class TextFormEntry extends StatefulWidget {
  const TextFormEntry(
      {Key? key, required this.hintText, required this.keyboardType})
      : super(key: key);
  final String hintText;
  final TextInputType keyboardType;

  @override
  State<TextFormEntry> createState() => _TextFormEntryState();
}

class _TextFormEntryState extends State<TextFormEntry> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context),
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        key: _formKey,
        cursorColor: AppColours.primary,
        autofocus: true,
        keyboardType: widget.keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: AppColours.pink,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: AppColours.primary,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}