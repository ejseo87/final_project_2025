import 'package:final_project_2025/constants/sizes.dart';
import 'package:final_project_2025/features/settings/repos/settings_repo.dart';
import 'package:final_project_2025/features/settings/view_models/settings_view_model.dart';
import 'package:final_project_2025/firebase_options.dart';
import 'package:final_project_2025/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final preferences = await SharedPreferences.getInstance();
  final repository = SettingsRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        settingsProvider.overrideWith(() => SettingsViewModel(repository)),
      ],
      child: FinalProject2025(),
    ),
  );
}

class FinalProject2025 extends ConsumerWidget {
  const FinalProject2025({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      title: 'Final Project 2025',
      themeMode:
          ref.watch(settingsProvider).darkmode
              ? ThemeMode.dark
              : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: Typography.blackMountainView,
        scaffoldBackgroundColor: Color(0xFFECE6C2),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Color(0xFFECE6C2),
          surfaceTintColor: Color(0xFFECE6C2),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w800,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          elevation: 2,
          color: Color(0xFFECE6C2),
        ),
        primaryColor: const Color(0xFFFEA6F6),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFFEA6F6),
        ),
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
        ),
        listTileTheme: const ListTileThemeData(iconColor: Colors.black),
        useMaterial3: false,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: Typography.whiteMountainView,
        scaffoldBackgroundColor: Colors.grey.shade900,
        appBarTheme: AppBarTheme(
          foregroundColor: Color(0xFFECE6C2),
          backgroundColor: Colors.grey.shade900,
          surfaceTintColor: Colors.grey.shade900,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Color(0xFFECE6C2),
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(color: Color(0xFFECE6C2)),
          iconTheme: IconThemeData(color: Color(0xFFECE6C2)),
        ),
        bottomAppBarTheme: BottomAppBarTheme(color: Colors.grey.shade900),
        primaryColor: const Color(0xFFFEA6F6),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFFEA6F6),
        ),
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade500,
        ),
        useMaterial3: false,
      ),
    );
  }
}
