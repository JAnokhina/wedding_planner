import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/firebase_models/guest_model.dart';
import 'package:wedding_planner/firebase_state_management/guest_state.dart';
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
  final singleGuestFormKey = GlobalKey<FormBuilderState>();
  final coupleGuestFormKey = GlobalKey<FormBuilderState>();
  final familyGuestFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: WPAppBar(
        title: 'Guests',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DefaultTabController(
          length: 4,
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
                    Tab(icon: Icon(Icons.list), child: Text('guests')),
                    Tab(
                        icon: Icon(Icons.person_outline),
                        child: Text('single')),
                    Tab(
                        icon: Icon(Icons.people_outline),
                        child: Text('couple')),
                    Tab(
                        icon: Icon(Icons.family_restroom_outlined),
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
                  yourGuests(),
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

  Widget yourGuests() {
    List<GuestModel> guests = [
      GuestModel(
          id: '123',
          name: 'name',
          email: 'email',
          cell: 'cell',
          relationship: Relationship.family.toString(),
          rsvpStatus: false),
      GuestModel(
          id: '123',
          name: 'name',
          email: 'email',
          cell: 'cell',
          relationship: Relationship.family.toString(),
          rsvpStatus: false),
      GuestModel(
          id: '123',
          name: 'name',
          email: 'email',
          cell: 'cell',
          relationship: Relationship.family.toString(),
          rsvpStatus: false),
    ];
    return ListView(children: [
      guest(name: guests.first.name, rsvpStatus: guests.first.rsvpStatus),
      guest(name: guests.first.name, rsvpStatus: guests.first.rsvpStatus)
    ]);
  }

  Widget guest({required String name, required bool rsvpStatus}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          rsvpStatus.toString(),
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }

  Widget singleGuestForm() {
    final guestState = Provider.of<GuestState>(context);

    return SingleChildScrollView(
        child: FormBuilder(
      key: singleGuestFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FormBuilderTextField(
              name: "name",
              // validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                  hintText: "Enter name",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: AppColours.pink, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: AppColours.primary,
                      width: 1.0,
                    ),
                  ),
                  focusColor: AppColours.pink,
                  labelStyle: const TextStyle(color: AppColours.primary),
                  labelText: "Name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FormBuilderTextField(
              name: "surname",
              // validators: [FormBuilderValidators.required()],
              decoration: InputDecoration(
                  hintText: "Enter surname",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: AppColours.pink, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: AppColours.primary,
                      width: 1.0,
                    ),
                  ),
                  focusColor: AppColours.pink,
                  labelStyle: const TextStyle(color: AppColours.primary),
                  labelText: "Surname"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FormBuilderTextField(
              name: "email",
              // validators: [FormBuilderValidators.required(), FormBuilderValidators.email()],
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: "Enter your email",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: AppColours.pink, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: AppColours.primary,
                      width: 1.0,
                    ),
                  ),
                  focusColor: AppColours.pink,
                  labelStyle: const TextStyle(color: AppColours.primary),
                  labelText: "Email"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: FormBuilderTextField(
              name: "cell",
              // validators: [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
              decoration: InputDecoration(
                  hintText: "Enter your cell no",
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide:
                        const BorderSide(color: AppColours.pink, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(
                      color: AppColours.primary,
                      width: 1.0,
                    ),
                  ),
                  focusColor: AppColours.pink,
                  labelStyle: const TextStyle(color: AppColours.primary),
                  labelText: "Cell No"),
            ),
          ),
          FormBuilderDropdown(
            name: 'relationship',
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            elevation: 16,
            style: const TextStyle(color: AppColours.primary),
            items: <String>[
              'Select...',
              'Family',
              'Wedding Party',
              'Friend',
              'Family Friend'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SubmitButton(
            buttonName: 'Submit',
            onPressedFunction: () {
              singleGuestFormKey.currentState!.save();
              guestState.addGuests(guests: [
                GuestModel(
                    name:
                        '${singleGuestFormKey.currentState?.fields['name']?.value} ${singleGuestFormKey.currentState?.fields['surname']?.value}',
                    email:
                        '${singleGuestFormKey.currentState?.fields['email']?.value}',
                    cell:
                        '${singleGuestFormKey.currentState?.fields['cell']?.value}',
                    relationship:
                        '${singleGuestFormKey.currentState?.fields['relationship']?.value}',
                    rsvpStatus: false)
              ]);
              singleGuestFormKey.currentState?.reset();

              //Todo add validation that the call actually worked
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Guest added successfully'),
              ));
            },
          ),
        ],
      ),
    ));
  }

  Widget coupleGuestForm() {
    final guestState = Provider.of<GuestState>(context);
    return SingleChildScrollView(
        child: FormBuilder(
      key: coupleGuestFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (int i = 1; i <= 2; i++) dynamicForm(i),
          FormBuilderDropdown(
            name: 'relationship',
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            elevation: 16,
            style: const TextStyle(color: AppColours.primary),
            items: <String>[
              'Select...',
              'Family',
              'Wedding Party',
              'Friend',
              'Family Friend'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SubmitButton(
            buttonName: 'Submit',
            onPressedFunction: () {
              coupleGuestFormKey.currentState?.save();
              List<GuestModel> guestsToAdd = [];

              for (int i = 1; i <= 2; i++) {
                guestsToAdd.add(GuestModel(
                    name:
                        '${coupleGuestFormKey.currentState?.fields['name$i']?.value} ${coupleGuestFormKey.currentState?.fields['surname$i']?.value}',
                    email:
                        '${coupleGuestFormKey.currentState?.fields['email$i']?.value}',
                    cell:
                        '${coupleGuestFormKey.currentState?.fields['cell$i']?.value}',
                    relationship:
                        '${coupleGuestFormKey.currentState?.fields['relationship']?.value}',
                    rsvpStatus: false));
              }

              guestState.addGuestsssss(guests: guestsToAdd);
              coupleGuestFormKey.currentState?.reset();

              //Todo add validation that the call actually worked
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Guest added successfully'),
              ));
            },
          ),
        ],
      ),
    ));
  }

  int familyCount = 1;
  Widget familyGuestForm() {
    final guestState = Provider.of<GuestState>(context);

    return SingleChildScrollView(
        child: FormBuilder(
      key: familyGuestFormKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          for (int i = 1; i <= familyCount; i++) dynamicForm(i),
          InkWell(
            onTap: () {
              setState(() {
                familyCount++;
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
            ),
          ),
          if (familyCount >= 2) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: () {
                  setState(() {
                    familyCount--;
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
                ),
              ),
            ),
          ],
          FormBuilderDropdown(
            name: 'relationship',
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            elevation: 16,
            style: const TextStyle(color: AppColours.primary),
            items: <String>[
              'Select...',
              'Family',
              'Wedding Party',
              'Friend',
              'Family Friend'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SubmitButton(
            buttonName: 'Submit',
            onPressedFunction: () {
              familyGuestFormKey.currentState?.save();
              List<GuestModel> guestsToAdd = [];

              for (int i = 1; i <= familyCount; i++) {
                guestsToAdd.add(GuestModel(
                    name:
                        '${familyGuestFormKey.currentState?.fields['name$i']?.value} ${familyGuestFormKey.currentState?.fields['surname$i']?.value}',
                    email:
                        '${familyGuestFormKey.currentState?.fields['email$i']?.value}',
                    cell:
                        '${familyGuestFormKey.currentState?.fields['cell$i']?.value}',
                    relationship:
                        '${familyGuestFormKey.currentState?.fields['relationship']?.value}',
                    rsvpStatus: false));
              }

              guestState.addGuestsssss(guests: guestsToAdd);
              // familyGuestFormKey.currentState?.reset();

              //Todo add validation that the call actually worked
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Guest added successfully'),
              ));
            },
          ),
        ],
      ),
    ));

    // return ListView(
    //   children: [
    //     guestDetails(1),
    //     for (int i = 1; i <= guestForms.length; i++) ...[
    //       guestDetails(i + 1),
    //     ],
    //     TextButton(
    //         onPressed: () {
    //           setState(() {
    //             guestForms.add(guestDetails(guestForms.length + 1));
    //           });
    //         },
    //         child: Row(
    //           children: const [
    //             Icon(
    //               Icons.add,
    //               color: AppColours.primary,
    //             ),
    //             Text(
    //               'Add family member',
    //               style: TextStyle(color: AppColours.primary),
    //             )
    //           ],
    //         )),
    //     if (guestForms.length >= 1) ...[
    //       TextButton(
    //           onPressed: () {
    //             setState(() {
    //               guestForms.removeAt(guestForms.length - 1);
    //             });
    //           },
    //           child: Row(
    //             children: const [
    //               Icon(
    //                 Icons.remove,
    //                 color: AppColours.primary,
    //               ),
    //               Text(
    //                 'Remove family member',
    //                 style: TextStyle(color: AppColours.primary),
    //               )
    //             ],
    //           )),
    //     ],
    //     const Center(
    //       child: Heading(heading: 'Relationship to you'),
    //     ),
    //     const DropdownMenu(),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 16),
    //       child: SubmitButton(buttonName: 'Submit', onPressedFunction: () {}),
    //     )
    //   ],
    // );
  }
  //
  // Widget guestDetails(int guestNumber) {
  //   TextEditingController nameController = TextEditingController();
  //   TextEditingController surnameController = TextEditingController();
  //   TextEditingController emailController = TextEditingController();
  //   TextEditingController cellController = TextEditingController();
  //   return Column(
  //     children: [
  //       Heading(heading: 'Person $guestNumber'),
  //       TextFormEntry(
  //           hintText: 'Name',
  //           keyboardType: TextInputType.name,
  //           textController: nameController),
  //       TextFormEntry(
  //         hintText: 'Surname',
  //         keyboardType: TextInputType.name,
  //         textController: surnameController,
  //       ),
  //       TextFormEntry(
  //         hintText: 'Email address',
  //         keyboardType: TextInputType.emailAddress,
  //         textController: emailController,
  //       ),
  //       TextFormEntry(
  //           hintText: 'Cell',
  //           keyboardType: TextInputType.phone,
  //           textController: cellController),
  //     ],
  //   );
  // }

  Widget dynamicForm(int guestNr) {
    return Column(children: [
      Heading(heading: 'Person $guestNr'),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: FormBuilderTextField(
          name: "name$guestNr",
          // validators: [FormBuilderValidators.required()],
          decoration: InputDecoration(
              hintText: "Enter name",
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
              focusColor: AppColours.pink,
              labelStyle: const TextStyle(color: AppColours.primary),
              labelText: "Name"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: FormBuilderTextField(
          name: "surname$guestNr",
          // validators: [FormBuilderValidators.required()],
          decoration: InputDecoration(
              hintText: "Enter surname",
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
              focusColor: AppColours.pink,
              labelStyle: const TextStyle(color: AppColours.primary),
              labelText: "Surname"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: FormBuilderTextField(
          name: "email$guestNr",
          // validators: [FormBuilderValidators.required(), FormBuilderValidators.email()],
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
              hintText: "Enter your email",
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
              focusColor: AppColours.pink,
              labelStyle: const TextStyle(color: AppColours.primary),
              labelText: "Email"),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: FormBuilderTextField(
          name: "cell$guestNr",
          // validators: [FormBuilderValidators.required(), FormBuilderValidators.numeric()],
          decoration: InputDecoration(
              hintText: "Enter your cell no",
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
              focusColor: AppColours.pink,
              labelStyle: const TextStyle(color: AppColours.primary),
              labelText: "Cell No"),
        ),
      ),
    ]);
  }
}