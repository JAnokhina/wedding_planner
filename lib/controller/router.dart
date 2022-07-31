import 'package:go_router/go_router.dart';
import 'package:wedding_planner/notes/notes.dart';
import 'package:wedding_planner/screens/budget/budget.dart';
import 'package:wedding_planner/screens/home/home_page.dart';
import 'package:wedding_planner/screens/login_and_registration/login_page.dart';
import 'package:wedding_planner/screens/login_and_registration/registration_page.dart';
import 'package:wedding_planner/screens/venue/venue.dart';
import 'package:wedding_planner/widgets/Settings.dart';
import '../screens/guests/guests.dart';
import '../screens/ideas/ideas.dart';
import '../screens/profile/profile.dart';
import '../screens/to-dos/to_dos.dart';
import '../screens/vendors/vendors.dart';

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
      GoRoute(
        path: '/venue',
        builder: (context, state) => const Venue(),
      ),
      GoRoute(
        path: '/budget',
        builder: (context, state) => const Budget(),
      ),
      GoRoute(
        path: '/guests',
        builder: (context, state) => const GuestsPage(),
      ),
      GoRoute(
        path: '/to-dos',
        builder: (context, state) => const ToDos(),
      ),
      GoRoute(
        path: '/vendors',
        builder: (context, state) => const Vendors(),
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => const Notes(),
      ),
      GoRoute(
        path: '/ideas',
        builder: (context, state) => const Ideas(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const Profile(),
      ),
    ],
    initialLocation: '/login',
  );
}