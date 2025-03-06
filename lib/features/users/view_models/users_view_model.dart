import 'dart:async';

import 'package:final_project_2025/features/authentication/repos/authentication_repo.dart';
import 'package:final_project_2025/features/users/models/user_profile_model.dart';
import 'package:final_project_2025/features/users/repos/users_repo.dart';
import 'package:final_project_2025/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UsersRepository _usersRepository;
  late final AuthenticationRepository _authRepository;

  @override
  FutureOr<UserProfileModel> build() async {
    _usersRepository = ref.read(usersRepo);
    _authRepository = ref.read(authRepo);

    if (_authRepository.isLoggedIn) {
      final profile = await _usersRepository.findProfile(
        _authRepository.user!.uid,
      );
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile({
    required UserCredential credential,
    required BuildContext context,
  }) async {
    if (credential.user == null) {
      throw Exception("Account not created");
    }
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final profile = UserProfileModel(
        uid: credential.user!.uid,
        email: credential.user!.email ?? "anon@anon.com",
        createAt: DateTime.now().millisecondsSinceEpoch,
      );
      await _usersRepository.createUserProfile(profile);
      return profile;
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context: context, error: state.error);
    }
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
