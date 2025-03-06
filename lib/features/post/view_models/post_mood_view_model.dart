import 'dart:async';

import 'package:final_project_2025/features/authentication/repos/authentication_repo.dart';
import 'package:final_project_2025/features/post/models/mood_model.dart';
import 'package:final_project_2025/features/post/repos/mood_repo.dart';
import 'package:final_project_2025/features/users/repos/users_repo.dart';
import 'package:final_project_2025/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PostMoodViewModel extends AsyncNotifier<void> {
  late final MoodRepository _moodRepository;
  late final UsersRepository _usersRepository;
  @override
  FutureOr<void> build() {
    _moodRepository = ref.read(moodRepo);
    _usersRepository = ref.read(usersRepo);
  }

  Future<void> postMood({
    required BuildContext context,
    required String mood,
    required String icon,
  }) async {
    final userId = ref.read(authRepo).user!.uid;

    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final MoodModel moodData = MoodModel(
        // users moodid  Tadft6fcl0vCPukEOIAa
        // moods moodid qChiccUJ1U4BZjrSWQL7
        moodId: "",
        creatorUid: userId,
        mood: mood,
        emoticon: icon,
        createAt: DateTime.now().millisecondsSinceEpoch,
      );
      final String moodId = await _moodRepository.saveMood(moodData);
      final newMoodData = moodData.copyWith(moodId: moodId);
      await _usersRepository.saveUsersMood(newMoodData);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context: context, error: state.error);
    } else {
      context.pushReplacement("/home");
    }
  }

  Future<bool> checkOwnership({
    required String moodOwnerId,
    required BuildContext context,
  }) async {
    final userId = ref.read(authRepo).user!.uid;
    if (moodOwnerId == userId) return true;
    return false;
  }

  Future<bool> deleteMood({
    required MoodModel moodData,
    required BuildContext context,
  }) async {
    final userId = ref.read(authRepo).user!.uid;
    if (moodData.creatorUid != userId) {
      return false;
    }
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _moodRepository.deleteMood(moodData);
      await _usersRepository.deleteUsersMood(moodData);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context: context, error: state.error);
      return false;
    } else {
      return true;
    }
  }
}

final postMoodProvider = AsyncNotifierProvider<PostMoodViewModel, void>(
  () => PostMoodViewModel(),
);
