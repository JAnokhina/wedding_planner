import 'package:flutter/material.dart';
import 'package:wedding_planner/screens/home/calendar.dart';
import 'package:wedding_planner/widgets/chips_selector.dart';
import 'package:wedding_planner/widgets/heading.dart';
import 'package:wedding_planner/widgets/submit_button.dart';
import 'package:wedding_planner/widgets/text_buttom_custom.dart';
import 'package:wedding_planner/widgets/text_form_entry.dart';

import '../../firebase_services/user_details_service.dart';
import '../../widgets/app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late FocusNode focusNode;
  TextEditingController name1Controller = TextEditingController();
  TextEditingController surname1Controller = TextEditingController();
  TextEditingController name2Controller = TextEditingController();
  TextEditingController surname2Controller = TextEditingController();
  String status1 = '';
  String status2 = '';

  @override
  void initState() {
    super.initState();
    FocusNode focusNode = FocusNode();
    focusNode.addListener(() {});
  }

  List<String> _choices = ['Bride', 'Groom', 'Partner'];

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    DateTime weddingDate;
    return Focus(
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          setState(() {
            // borderColour = ColorPalette.primary;
          });
        } else {
          setState(() {
            // borderColour = ColorPalette.secondary;
          });
        }
      },
      child: Scaffold(
        appBar: WPAppBar(
          title: 'Profile',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    const Heading(heading: 'Your Name'),
                    TextFormEntry(
                        hintText: 'Name',
                        keyboardType: TextInputType.name,
                        textController: name1Controller),
                    TextFormEntry(
                        hintText: 'Surname',
                        keyboardType: TextInputType.name,
                        textController: surname1Controller),
                    ChipSelector(
                      choices: _choices,
                      onSelected: (index, isSelected) {
                        print('Selected: $isSelected');
                        if (isSelected) {
                          status1 = _choices[index];
                        } else {
                          (status1 = _choices[0]);
                        }
                      },
                    ),
                    const Heading(heading: 'Your Partner\'s Name'),
                    TextFormEntry(
                        hintText: 'Name',
                        keyboardType: TextInputType.name,
                        textController: name2Controller),
                    TextFormEntry(
                        hintText: 'Surname',
                        keyboardType: TextInputType.name,
                        textController: surname2Controller),
                    ChipSelector(
                      choices: _choices,
                      onSelected: (index, isSelected) {
                        if (isSelected) {
                          status2 = _choices[index];
                        } else {
                          (status2 = _choices[0]);
                        }
                      },
                    ),
                    CustomTextButton(
                      onPressed: () {
                        calendarPopUp(context);
                        print('From CAllendar popup');
                      },
                      buttonName: 'Your wedding date',
                      icon: Icons.calendar_month,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SubmitButton(
              buttonName: 'Save',
              onPressedFunction: () {
                if (validateName(name1Controller.text) == null &&
                    validateName(surname1Controller.text) == null &&
                    validateName(name2Controller.text) == null &&
                    validateName(name2Controller.text) == null) {
                  UserService(
                    fullName:
                        '${name1Controller.text} ${surname1Controller.text}',
                    status: (status1.isEmpty) ? _choices[0] : status1,
                    partnerName:
                        '${name2Controller.text} ${surname2Controller.text}',
                    partnerStatus: (status2.isEmpty) ? _choices[0] : status2,
                    //Todo I don't know how to return the date from calendar :(
                    // weddingDate: DateTime.utc(2022, 12, 3)
                  ).addProfileDetails();
                } else if (validateName(name1Controller.text) != null ||
                    validateName(surname1Controller.text) != null ||
                    validateName(name2Controller.text) != null ||
                    validateName(surname2Controller.text) != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill in all fields')),
                  );
                }
              }),
        ),
      ),
    );
  }

  String? validateName(String value) {
    if (value.length < 3) {
      return 'Name must be more than 3 characters';
    } else {
      return null;
    }
  }

  String? validateMobile(String value) {
//SA Mobile numbers are of 10 digit only
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }
}