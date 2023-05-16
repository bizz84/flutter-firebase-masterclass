import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

sealed class AppException implements Exception {
  // Auth
  const factory AppException.emailAlreadyInUse() = _EmailAlreadyInUse;
  const factory AppException.weakPassword() = _WeakPassword;
  const factory AppException.wrongPassword() = _WrongPassword;
  const factory AppException.userNotFound() = _UserNotFound;
  // Orders
  const factory AppException.parseOrderFailure(String status) =
      _ParseOrderFailure;
}

final class _EmailAlreadyInUse implements AppException {
  const _EmailAlreadyInUse();
}

final class _WeakPassword implements AppException {
  const _WeakPassword();
}

final class _WrongPassword implements AppException {
  const _WrongPassword();
}

final class _UserNotFound implements AppException {
  const _UserNotFound();
}

final class _ParseOrderFailure implements AppException {
  const _ParseOrderFailure(this.status);
  final String status;
}

extension AppExceptionDetails on AppException {
  ({String code, String message}) get details {
    return switch (this) {
      _EmailAlreadyInUse() => (
          code: 'email-already-in-use',
          message: 'Email already in use'.hardcoded,
        ),
      _WeakPassword() => (
          code: 'weak-password',
          message: 'Password is too weak'.hardcoded,
        ),
      _WrongPassword() => (
          code: 'wrong-password',
          message: 'Wrong password'.hardcoded,
        ),
      _UserNotFound() => (
          code: 'user-not-found',
          message: 'User not found'.hardcoded,
        ),
      // Orders
      _ParseOrderFailure(status: final status) => (
          code: 'parse-order-failure',
          message: 'Could not parse order status: $status'.hardcoded,
        ),
    };
  }
}
