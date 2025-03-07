import 'dart:ui';

import 'package:final_project_2025/constants/gaps.dart';
import 'package:final_project_2025/constants/sizes.dart';
import 'package:final_project_2025/features/home/view_models/timeline_view_model.dart';
import 'package:final_project_2025/features/home/views/widgets/delete_bottom_sheet.dart';
import 'package:final_project_2025/features/post/models/mood_model.dart';
import 'package:final_project_2025/features/post/view_models/post_mood_view_model.dart';
import 'package:final_project_2025/features/settings/view_models/settings_view_model.dart';
import 'package:final_project_2025/features/settings/views/settings_screen.dart';
import 'package:final_project_2025/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeName = "home";
  static const String routeURL = "/home";
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController = ScrollController();
  bool _isOnlyMine = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onGearTap(BuildContext context) {
    context.pushNamed(SettingsScreen.routeName);
  }

  void _onMoodTileTap({
    required int index,
    required MoodModel moodData,
    required BuildContext context,
  }) async {
    final bool isOwner = await ref
        .read(postMoodProvider.notifier)
        .checkOwnership(moodOwnerId: moodData.creatorUid, context: context);
    if (isOwner) {
      print("This mood will be deleted.");
      await showModalBottomSheet(
        isDismissible: false,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) => DeleteBottomSheet(moodData),
      );
    } else {
      showInfoSnackBar(
        title: "This mood is not yours. Cann't delete!",
        context: context,
      );
    }
  }

  void _onPressed() {
    setState(() {
      _isOnlyMine = !_isOnlyMine;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ref
        .watch(timelineProvider(_isOnlyMine))
        .when(
          loading: () => Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) =>
                  Center(child: Text("Could not load moods : $error")),
          data: (data) {
            final isDark = ref.watch(settingsProvider).darkmode;

            return SafeArea(
              child: Scaffold(
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                body: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      centerTitle: true,
                      leadingWidth: 100,
                      leading: TextButton(
                        onPressed: _onPressed,
                        child:
                            _isOnlyMine
                                ? Text("Everyone's Moods")
                                : Text("My Moods"),
                      ),
                      title: Text("🔥 Mood 🔥".toUpperCase()),

                      actions: [
                        GestureDetector(
                          onTap: () => _onGearTap(context),
                          child: Container(
                            height: (kToolbarHeight),
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: Sizes.size20),
                            child: FaIcon(
                              FontAwesomeIcons.gear,
                              size: Sizes.size18,
                              color:
                                  isDark
                                      ? Colors.grey.shade400
                                      : Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SliverToBoxAdapter(child: Gaps.v32),
                    SliverList.separated(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final moodData = data[index];

                        return GestureDetector(
                          onLongPress:
                              () => _onMoodTileTap(
                                index: index,
                                moodData: moodData,
                                context: context,
                              ),
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width * 0.85,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Sizes.size20,
                                    vertical: Sizes.size8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF74BDA8),
                                    border: Border.all(
                                      width: Sizes.size2,
                                      color:
                                          isDark
                                              ? Colors.grey.shade600
                                              : Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      Sizes.size20,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            isDark
                                                ? Colors.grey.shade500
                                                : Colors.black,
                                        offset: Offset(-2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mood: ${moodData.emoticon}",
                                        style: TextStyle(
                                          fontSize: Sizes.size16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        moodData.mood,
                                        style: TextStyle(
                                          fontSize: Sizes.size16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Gaps.v10,
                                Text(
                                  makeDateTimeDifference(moodData.createAt),
                                  style: TextStyle(
                                    fontSize: Sizes.size14,
                                    color:
                                        isDark
                                            ? Colors.grey.shade400
                                            : Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v20,
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}
