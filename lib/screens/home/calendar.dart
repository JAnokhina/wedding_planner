import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedding_planner/firebase_services/user_details_service.dart';

import '../../main.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/submit_button.dart';

void calendarPopUp(BuildContext context) {
  DateTime dateT = DateTime.now();
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
                      'Calendar',
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
                      SfDatePicker(onDateTimeChanged: (newDateTime) {
                        dateT = newDateTime;
                      }),
                      SubmitButton(
                          buttonName: 'Submit',
                          onPressedFunction: () {
                            UserService(weddingDate: dateT).addProfileDetails();
                            // context.pop();
                          })
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      });
}