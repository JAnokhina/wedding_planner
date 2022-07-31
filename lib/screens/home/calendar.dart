import 'package:flutter/material.dart';

import '../../main.dart';
import '../../widgets/date_picker.dart';

void calendarPopUp(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return Container(
          width: displayWidth(context),
          height: displayHeight(context) * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Schedule Service',
                      style:
                          TextStyle(fontFamily: 'Roboto-Regular', fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: ThemeData().appBarTheme.iconTheme?.color,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SfDatePicker(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}