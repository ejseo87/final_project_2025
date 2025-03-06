import 'dart:async';

import 'package:final_project_2025/features/authentication/repos/authentication_repo.dart';
import 'package:final_project_2025/features/users/view_models/users_view_model.dart';
import 'package:final_project_2025/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = AsyncValue.loading();
    final users = ref.read(usersProvider.notifier);
    final form = ref.read(signUpForm);
    state = await AsyncValue.guard(() async {
      final UserCredential userCredential = await _repository.signUp(
        email: form["email"],
        password: form["password"],
      );
      await users.createProfile(credential: userCredential, context: context);
    });
    if (state.hasError) {
      showFirebaseErrorSnack(context: context, error: state.error);
    } else {
      context.go("/home");
    }
  }
}

final signUpForm = StateProvider((ref) => {});
final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
