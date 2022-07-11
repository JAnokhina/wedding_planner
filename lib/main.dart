import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wedding_planner/screens/error_screen.dart';
import 'package:wedding_planner/screens/loading_screen.dart';
import 'package:wedding_planner/screens/login_and_registration/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wedding_planner/themes.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      darkTheme: Themes.darkTheme,
      themeMode: ThemeMode.system,
      home: const LoginPage(),
    );
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
