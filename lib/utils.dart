import 'package:final_project_2025/constants/sizes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool isDartMode(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.dark;
}

void showFirebaseErrorSnack({
  required BuildContext context,
  required Object? error,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      //showCloseIcon: true,
      //closeIconColor: Theme.of(context).primaryColor,
      action: SnackBarAction(label: "OK", onPressed: () {}),
      content: Text(
        (error as FirebaseException).message ?? "Something went wrong.",
      ),
    ),
  );
}

void showInfoSnackBar({required String title, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.size10),
      ),
      duration: Duration(milliseconds: 2000),
      content: Text(title),
      action: SnackBarAction(label: "Ok", onPressed: () {}),
    ),
  );
}

String makeDateTimeDifference(int createdAt) {
  final createdDateTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
  final currentDateTime = DateTime.now();
  final diffMins = currentDateTime.difference(createdDateTime).inMinutes;
  final diffHours = currentDateTime.difference(createdDateTime).inHours;
  final diffDays = currentDateTime.difference(createdDateTime).inDays;

  if (diffMins < 60) {
    if (diffMins == 1 || diffMins == 0) {
      return "$diffMins minute ago";
    } else {
      return "$diffMins minutes ago";
    }
  } else if (diffMins > 59 && diffMins < 1440) {
    if (diffHours == 1) {
      return "$diffHours hour ago";
    } else {
      return "$diffHours hours ago";
    }
  } else {
    if (diffDays == 1) {
      return "$diffDays day ago";
    } else {
      return "$diffDays days ago";
    }
  }
}
