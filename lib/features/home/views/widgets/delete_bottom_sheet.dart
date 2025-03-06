import 'package:final_project_2025/constants/gaps.dart';
import 'package:final_project_2025/constants/sizes.dart';
import 'package:final_project_2025/features/post/models/mood_model.dart';
import 'package:final_project_2025/features/post/view_models/post_mood_view_model.dart';
import 'package:final_project_2025/features/settings/view_models/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteBottomSheet extends ConsumerWidget {
  final MoodModel moodData;
  const DeleteBottomSheet(this.moodData, {super.key});

  void _onDeleteTap({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    ref
        .read(postMoodProvider.notifier)
        .deleteMood(moodData: moodData, context: context);
    Navigator.pop(context);
  }

  void _onCancelTap(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(settingsProvider).darkmode;
    final size = MediaQuery.of(context).size;
    return Container(
      height: 250,
      width: size.width,
      margin: EdgeInsets.only(bottom: Sizes.size14),
      decoration: BoxDecoration(color: Colors.transparent),

      child: Column(
        children: [
          Container(
            width: size.width * 0.94,
            padding: EdgeInsets.symmetric(vertical: Sizes.size12),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade800 : Color(0xFFD6D6CE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Sizes.size14),
                topRight: Radius.circular(Sizes.size14),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Delete mood",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gaps.v16,
                Text(
                  "Are you sure you want to do this?",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: isDark ? Colors.grey.shade300 : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _onDeleteTap(context: context, ref: ref),
            child: Container(
              width: size.width * 0.94,
              padding: EdgeInsets.symmetric(vertical: Sizes.size22),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade800 : Color(0xFFD6D6CE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.size14),
                  bottomRight: Radius.circular(Sizes.size14),
                ),
                border: Border(
                  top: BorderSide(
                    color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: Sizes.size24,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Gaps.v5,
          GestureDetector(
            onTap: () => _onCancelTap(context),
            child: Container(
              width: size.width * 0.94,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: Sizes.size22),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey.shade700 : Colors.white,
                borderRadius: BorderRadius.circular(Sizes.size14),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
