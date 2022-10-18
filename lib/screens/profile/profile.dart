import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/screens/home/calendar.dart';
import 'package:wedding_planner/widgets/chips_selector.dart';
import 'package:wedding_planner/widgets/heading.dart';
import 'package:wedding_planner/widgets/submit_button.dart';
import 'package:wedding_planner/widgets/text_buttom_custom.dart';
import 'package:wedding_planner/widgets/text_form_entry.dart';
import '../../firebase_models/profile_model.dart';
import '../../firebase_state_management/profile_state.dart';
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

  initialise() {
    Provider.of<ProfileState>(context, listen: false).refreshProfileData();
  }

  @override
  void initState() {
    super.initState();
    initialise();
    FocusNode focusNode = FocusNode();
    focusNode.addListener(() {});
  }

  List<String> _choices = ['Bride', 'Groom', 'Partner'];

  void setFocus() {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    final profileState = Provider.of<ProfileState>(context);
    DateTime weddingDate = profileState.weddingDate;
    ProfileModel profile = profileState.profile;
    print('On page wedding time ${profile.partner1.name}');
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
                        hintText: (profile.partner1.name.isNotEmpty)
                            ? profile.partner1.name.split(' ').first
                            : 'Name',
                        keyboardType: TextInputType.name,
                        textController: name1Controller),
                    TextFormEntry(
                        hintText: (profile.partner1.name.isNotEmpty)
                            ? profile.partner1.name.split(' ').last
                            : 'Surname',
                        keyboardType: TextInputType.name,
                        textController: surname1Controller),
                    ChipSelector(
                      choices: _choices,
                      chosenIndex: (profile.partner1.status.isNotEmpty)
                          ? _choices.indexOf(profile.partner1.status)
                          : null,
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
                        hintText: (profile.partner2.name.isNotEmpty)
                            ? profile.partner2.name.split(' ').first
                            : 'Name',
                        keyboardType: TextInputType.name,
                        textController: name2Controller),
                    TextFormEntry(
                        hintText: (profile.partner2.name.isNotEmpty)
                            ? profile.partner2.name.split(' ').last
                            : 'Surname',
                        keyboardType: TextInputType.name,
                        textController: surname2Controller),
                    ChipSelector(
                      choices: _choices,
                      chosenIndex: (profile.partner2.status.isNotEmpty)
                          ? _choices.indexOf(profile.partner2.status)
                          : null,
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
                      },
                      buttonName: (DateFormat('EEE dd - MMM - yyyy')
                                  .format(profile.weddingDate) ==
                              DateFormat('EEE dd - MMM - yyyy')
                                  .format(DateTime.now()))
                          ? 'Your wedding date'
                          : DateFormat('EEE dd - MMM - yyyy')
                              .format(profile.weddingDate),
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
                  Provider.of<ProfileState>(context, listen: false)
                      .editProfileData(ProfileModel(
                          partner1: Partner(
                              name:
                                  '${name1Controller.text} ${surname1Controller.text}',
                              status: status1),
                          partner2: Partner(
                              name:
                                  '${name2Controller.text} ${surname2Controller.text}',
                              status: status2),
                          weddingDate: weddingDate));

                  //TODO fix this validation. alloww to update separate fields without editing others
                } else if ((validateName(name1Controller.text) != null &&
                        profile.partner1.name.isNotEmpty) ||
                    (validateName(surname1Controller.text) != null &&
                        profile.partner1.name.isNotEmpty) ||
                    (validateName(name2Controller.text) != null &&
                        profile.partner2.name.isNotEmpty) ||
                    (validateName(surname2Controller.text) != null &&
                        profile.partner2.name.isNotEmpty)) {
                  Provider.of<ProfileState>(context, listen: false)
                      .editProfileData(ProfileModel(
                          partner1: Partner(
                              name: profile.partner1.name,
                              status: profile.partner1.status),
                          partner2: Partner(
                              name: profile.partner2.name,
                              status: profile.partner2.status),
                          weddingDate: weddingDate));
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