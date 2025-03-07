import 'package:final_project_2025/constants/gaps.dart';
import 'package:final_project_2025/constants/sizes.dart';
import 'package:final_project_2025/features/authentication/repos/authentication_repo.dart';
import 'package:final_project_2025/features/authentication/views/sign_up_screen.dart';
import 'package:final_project_2025/features/settings/view_models/settings_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  static const String routeName = "settings";
  static const String routeURL = "/settings";

  const SettingsScreen({super.key});

  void _onBackPressed(BuildContext context) {
    context.pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(settingsProvider).darkmode;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () => _onBackPressed(context),
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.chevronLeft,
                size: Sizes.size16,
                color: isDark ? Colors.white : Colors.black,
              ),
              Gaps.h5,
              Text(
                "Back",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: isDark,
            onChanged:
                (value) =>
                    ref.read(settingsProvider.notifier).setDarkmode(value),
            title: const Text("Dark Mode"),
            subtitle: const Text("Light mode by default"),
          ),

          ListTile(
            title: const Text("Log out (IOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder:
                    (context) => CupertinoAlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("Please don't go."),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("No"),
                        ),
                        CupertinoDialogAction(
                          onPressed: () {
                            ref.read(authRepo).signOut(context);
                            context.go(SignUpScreen.routeURL);
                          },
                          isDestructiveAction: true,
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
    );
  }
}
