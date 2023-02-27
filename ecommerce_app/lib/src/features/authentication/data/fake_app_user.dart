import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';

/// Fake user class used to simulate a user account on the backend
/// * This class is implementation-specific and should only be used by the
/// * [FakeAuthRepository], so it should not belong to the domain layer
class FakeAppUser extends AppUser {
  const FakeAppUser({
    required super.uid,
    required super.email,
    required this.password,
  });
  final String password;
}
