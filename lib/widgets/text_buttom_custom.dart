import 'package:flutter/material.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/themes.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key, required this.onPressed, required this.buttonName, this.icon})
      : super(key: key);
  final VoidCallback? onPressed;
  final String buttonName;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: displayWidth(context),
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColours.primary,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            primary: AppColours.primary,
            shadowColor: AppColours.pink,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttonName,
              style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontFamily: ThemeData().textTheme.bodyMedium?.fontFamily),
            ),
            Icon(
              icon,
              color: AppColours.primary,
            )
          ],
        ),
      ),
    );
  }
}