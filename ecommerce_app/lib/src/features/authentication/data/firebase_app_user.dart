import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAppUser implements AppUser {
  final User _user;

  const FirebaseAppUser(this._user);

  @override
  UserID get uid => _user.uid;

  @override
  String? get email => _user.email;

  @override
  bool get emailVerified => _user.emailVerified;

  // * Note: after calling this method, [emailVerified] isn't updated until the
  // * next time an ID token is generated for the user.
  @override
  Future<void> sendEmailVerification() => _user.sendEmailVerification();
}
