import 'dart:async';

import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_screen_controller.g.dart';

@riverpod
class AccountScreenController extends _$AccountScreenController {
  @override
  FutureOr<void> build() {
    // nothing to do
  }
  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }

  Future<bool> sendEmailVerification(AppUser user) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => user.sendEmailVerification());
    return state.hasError == false;
  }
}
