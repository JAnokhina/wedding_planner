import 'package:flutter/material.dart';
import 'package:wedding_planner/firebase_services/guest_service.dart';
import 'package:wedding_planner/firebase_services/user_details_service.dart';
import 'package:wedding_planner/main.dart';
import 'package:wedding_planner/themes.dart';
import 'package:wedding_planner/widgets/dropdown_menu.dart';
import 'package:wedding_planner/widgets/heading.dart';
import 'package:wedding_planner/widgets/submit_button.dart';
import 'package:wedding_planner/widgets/text_form_entry.dart';
import '../../widgets/app_bar.dart';

class GuestsPage extends StatefulWidget {
  const GuestsPage({Key? key}) : super(key: key);

  @override
  State<GuestsPage> createState() => _GuestsPageState();
}

enum Relationship { family, weddingParty, friend, familyFriend }

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
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController cellController = TextEditingController();
    String dropdownSelection = 'Nothing';
    return ListView(children: [
      TextFormEntry(
          hintText: 'Name',
          keyboardType: TextInputType.name,
          textController: nameController),
      TextFormEntry(
          hintText: 'Surname',
          keyboardType: TextInputType.name,
          textController: surnameController),
      TextFormEntry(
          hintText: 'Email address',
          keyboardType: TextInputType.emailAddress,
          textController: emailController),
      TextFormEntry(
          hintText: 'Cell',
          keyboardType: TextInputType.phone,
          textController: cellController),
      const Heading(heading: 'Relationship to you'),
      const DropdownMenu(),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: SubmitButton(
            buttonName: 'Submit',
            onPressedFunction: () {
              GuestService().addGuest(
                  name: '${nameController.text} ${surnameController.text}',
                  email: emailController.text,
                  cell: cellController.text,
                  relationship: dropdownSelection);
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
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController cellController = TextEditingController();
    return Column(
      children: [
        Heading(heading: 'Person $guestNumber'),
        TextFormEntry(
            hintText: 'Name',
            keyboardType: TextInputType.name,
            textController: nameController),
        TextFormEntry(
          hintText: 'Surname',
          keyboardType: TextInputType.name,
          textController: surnameController,
        ),
        TextFormEntry(
          hintText: 'Email address',
          keyboardType: TextInputType.emailAddress,
          textController: emailController,
        ),
        TextFormEntry(
            hintText: 'Cell',
            keyboardType: TextInputType.phone,
            textController: cellController),
      ],
    );
  }
}