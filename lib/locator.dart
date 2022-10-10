import 'package:get_it/get_it.dart';
import 'package:wedding_planner/firebase_services/profile_service.dart';

import 'firebase_services/auth_service.dart';
import 'firebase_state_management/auth_state.dart';
import 'firebase_state_management/profile_state.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // Services (Lazy)
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => ProfileService());

  // Store (Lazy)
  locator.registerLazySingleton(() => AuthState());
}