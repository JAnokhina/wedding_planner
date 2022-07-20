import 'package:go_router/go_router.dart';
import 'package:wedding_planner/screens/home/home_page.dart';
import 'package:wedding_planner/screens/login_and_registration/login_page.dart';
import 'package:wedding_planner/screens/login_and_registration/registration_page.dart';

class MyRouter {
  late final router = GoRouter(
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegistrationPage(),
      ),
    ],
    initialLocation: '/login',
  );
}