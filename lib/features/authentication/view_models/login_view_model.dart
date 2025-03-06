import 'dart:async';

import 'package:final_project_2025/features/authentication/repos/authentication_repo.dart';
import 'package:final_project_2025/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;
  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => _repository.signIn(email: email, password: password),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context: context, error: state.error);
    } else {
      context.go("/home");
    }
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
