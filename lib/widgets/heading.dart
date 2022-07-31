import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading({Key? key, required this.heading}) : super(key: key);
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        heading,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}