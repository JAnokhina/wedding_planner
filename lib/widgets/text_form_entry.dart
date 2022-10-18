import 'package:flutter/material.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/themes.dart';

class TextFormEntry extends StatefulWidget {
  const TextFormEntry(
      {Key? key,
      required this.hintText,
      required this.keyboardType,
      this.textController})
      : super(key: key);
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? textController;

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
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
          // key: _formKey,
          controller: widget.textController,
          cursorColor: AppColours.primary,
          autofocus: false,
          keyboardType: widget.keyboardType,
          validator: (value) {
            //   if (value == null || value.isEmpty) {
            //     return 'Please enter some text';
            //   }
            //   return null;
          },
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(color: AppColours.pink, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: AppColours.primary,
                width: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}