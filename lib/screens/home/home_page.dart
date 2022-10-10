import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedding_planner/screens/home/calendar.dart';
import 'package:wedding_planner/widgets/gridItem.dart';
import 'package:wedding_planner/widgets/sign_out_button.dart';
import '../../main.dart';
import '../../themes.dart';
import '../../widgets/app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final weddingDate = UserService().getWeddingDate();
    print('On PAge');
    // print(weddingDate.toString());
    return Scaffold(
      appBar: WPAppBar(
        title: 'Home',
        showBackButton: false,
        actions: const [SignOutButton()],
      ),
      body: Container(
        width: displayWidth(context),
        height: displayHeight(context),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColours.primary, Color.fromRGBO(255, 255, 255, 1)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: displayWidth(context),
              height: 150,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color.fromRGBO(172, 26, 61, 1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          calendarPopUp(context);
                        },
                        icon: const Icon(
                          Icons.calendar_month,
                        ),
                        color: Colors.white,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Amount Days',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        'Until Your Big Day',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: displayWidth(context),
              height: displayHeight(context) * 0.6,
              padding: EdgeInsets.only(top: 50),
              child: buildGrid(context),
            ),
          ],
        ),
      ),
    );
  }

  buildGrid(BuildContext context) {
    List<IconData> icons = [
      Icons.location_on_outlined,
      Icons.attach_money,
      Icons.email_outlined,
      Icons.checklist_rounded,
      Icons.house_outlined,
      Icons.note_add_outlined,
      Icons.photo_size_select_actual_outlined,
      Icons.settings,
      Icons.perm_identity_outlined
    ];
    List<String> itemNames = [
      'Venue',
      'Budget',
      'Guests',
      'I-Do\'s',
      'Vendors',
      'Notes',
      'Ideas',
      'Settings',
      'Profile'
    ];
    List<String> navigateToRoute = [
      '/venue',
      '/budget',
      '/guests',
      '/to-dos',
      '/vendors',
      '/notes',
      '/ideas',
      '/settings',
      '/profile'
    ];

    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(9, (index) {
        return InkWell(
          onTap: () {
            context.push(navigateToRoute[index]);
            // Navigator.push(context, navigateToRoute[index]);
          },
          child: Center(
            child: GridItem(icon: icons[index], name: itemNames[index]),
          ),
        );
      }),
    );
  }
}