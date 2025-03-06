import 'package:final_project_2025/common/main_navigation/main_navigation_screen.dart';
import 'package:final_project_2025/features/authentication/repos/authentication_repo.dart';
import 'package:final_project_2025/features/authentication/views/login_screen.dart';
import 'package:final_project_2025/features/authentication/views/sign_up_screen.dart';
import 'package:final_project_2025/features/settings/views/settings_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoginIn = ref.read(authRepo).isLoggedIn;
      if (!isLoginIn) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: SignUpScreen.routeName,
        path: SignUpScreen.routeURL,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routeURL,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        name: SettingsScreen.routeName,
        path: SettingsScreen.routeURL,
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        path: "/:tab(home|post)",
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.params["tab"]!;
          return MainNavigationScreen(tab: tab);
        },
      ),
    ],
  );
});
