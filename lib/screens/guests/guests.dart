import 'package:flutter/material.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/themes.dart';
import 'package:wedding_planner/widgets/dropdown_menu.dart';
import 'package:wedding_planner/widgets/heading.dart';
import 'package:wedding_planner/widgets/submit_button.dart';
import 'package:wedding_planner/widgets/text_form_entry.dart';
import '../../firebase_models/profile_model.dart';
import '../../firebase_services/profile_service.dart';
import '../../widgets/app_bar.dart';

class GuestsPage extends StatefulWidget {
  const GuestsPage({Key? key}) : super(key: key);

  @override
  State<GuestsPage> createState() => _GuestsPageState();
}

class _GuestsPageState extends State<GuestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WPAppBar(
        title: 'Guest List',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DefaultTabController(
          length: 3,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: displayWidth(context),
                height: 70,
                child: const TabBar(
                  indicatorColor: AppColours.pink,
                  unselectedLabelColor: AppColours.primary,
                  labelColor: AppColours.pink,
                  tabs: [
                    Tab(
                        icon: Icon(Icons.person_outline),
                        child: Text('single')),
                    Tab(
                        icon: Icon(Icons.people_outline),
                        child: Text('couple')),
                    Tab(
                        icon: Icon(Icons.family_restroom_rounded),
                        child: Text('family')),
                  ],
                ),
              ),
              Container(
                width: displayWidth(context),
                height: displayHeight(context) * 0.81,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: TabBarView(children: [
                  singleGuestForm(),
                  coupleGuestForm(),
                  familyGuestForm(),
                ]),
              ),
            ],
          ),
        ),
      ),
      extendBody: true,
      // bottomNavigationBar: const BottomNavBar(currentIndex: 2),
    );
  }

  Widget singleGuestForm() {
    return ListView(children: [
      const TextFormEntry(hintText: 'Name', keyboardType: TextInputType.name),
      const TextFormEntry(
          hintText: 'Surname', keyboardType: TextInputType.name),
      const TextFormEntry(
          hintText: 'Email address', keyboardType: TextInputType.emailAddress),
      const TextFormEntry(hintText: 'Cell', keyboardType: TextInputType.phone),
      const Heading(heading: 'Relationship to you'),
      const DropdownMenu(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SubmitButton(
            buttonName: 'Submit',
            onPressedFunction: () {
              ProfileService().addProfileDetails(ProfileModel(
                  partner1: Partner(name: 'Julia Anokhina', status: 'Bride'),
                  partner2: Partner(name: 'Chris Kruger', status: 'Groom'),
                  weddingDate: DateTime.utc(2022, 12, 3)));
            }),
      )
    ]);
  }

  Widget coupleGuestForm() {
    return ListView(children: [
      guestDetails(1),
      guestDetails(2),
      const Center(
        child: Heading(heading: 'Relationship to you'),
      ),
      const DropdownMenu(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SubmitButton(buttonName: 'Submit', onPressedFunction: () {}),
      )
    ]);
  }

  List<Widget> guestForms = [];
  Widget familyGuestForm() {
    return ListView(
      children: [
        guestDetails(1),
        for (int i = 1; i <= guestForms.length; i++) ...[
          guestDetails(i + 1),
        ],
        TextButton(
            onPressed: () {
              setState(() {
                guestForms.add(guestDetails(guestForms.length + 1));
              });
            },
            child: Row(
              children: const [
                Icon(
                  Icons.add,
                  color: AppColours.primary,
                ),
                Text(
                  'Add family member',
                  style: TextStyle(color: AppColours.primary),
                )
              ],
            )),
        if (guestForms.length >= 1) ...[
          TextButton(
              onPressed: () {
                setState(() {
                  guestForms.removeAt(guestForms.length - 1);
                });
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.remove,
                    color: AppColours.primary,
                  ),
                  Text(
                    'Remove family member',
                    style: TextStyle(color: AppColours.primary),
                  )
                ],
              )),
        ],
        const Center(
          child: Heading(heading: 'Relationship to you'),
        ),
        const DropdownMenu(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SubmitButton(buttonName: 'Submit', onPressedFunction: () {}),
        )
      ],
    );
  }

  Widget guestDetails(int guestNumber) {
    return Column(
      children: [
        Heading(heading: 'Person $guestNumber'),
        const TextFormEntry(hintText: 'Name', keyboardType: TextInputType.name),
        const TextFormEntry(
            hintText: 'Surname', keyboardType: TextInputType.name),
        const TextFormEntry(
            hintText: 'Email address',
            keyboardType: TextInputType.emailAddress),
        const TextFormEntry(
            hintText: 'Cell', keyboardType: TextInputType.phone),
      ],
    );
  }
}