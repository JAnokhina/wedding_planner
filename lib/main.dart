import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wedding_planner/firebase_state_management/guest_state.dart';
import 'package:wedding_planner/firebase_state_management/profile_state.dart';
import 'package:wedding_planner/firebase_state_management/venue_state.dart';
import 'package:wedding_planner/firebase_state_management/budget_state.dart';
import 'package:wedding_planner/themes.dart';

import 'controller/router.dart';
import 'firebase_state_management/auth_state.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: locator<AuthState>()),
          ChangeNotifierProvider<ProfileState>(
              create: (context) => ProfileState()),
          ChangeNotifierProvider<GuestState>(create: (context) => GuestState()),
          ChangeNotifierProvider<VenueState>(create: (context) => VenueState()),
          ChangeNotifierProvider<BudgetState>(
              create: (context) => BudgetState()),
          Provider<MyRouter>(
            lazy: false,
            create: (BuildContext createContext) => MyRouter(),
          ),
        ],
        child: Builder(
          builder: (BuildContext context) {
            final router = Provider.of<MyRouter>(context, listen: false).router;
            Provider.of<ProfileState>(context, listen: false)
                .refreshProfileData();
            return MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              routeInformationProvider: router.routeInformationProvider,
              routerDelegate: router.routerDelegate,
              debugShowCheckedModeBanner: false,
              theme: Themes.lightTheme,
              darkTheme: Themes.darkTheme,
              themeMode: ThemeMode.system,
            );
          },
        ));
  }
}

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return displaySize(context).height;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}