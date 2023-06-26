import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Wrapper for the [User] class inside the firebase_auth package
class FirebaseAppUser implements AppUser {
  const FirebaseAppUser(this._user);
  final User _user;

  @override
  UserID get uid => _user.uid;

  @override
  String? get email => _user.email;

  @override
  bool get emailVerified => _user.emailVerified;

  // * Note: after calling this method, [emailVerified] isn't updated until the
  // * next time an ID token is generated for the user.
  // * Read this for more info: https://stackoverflow.com/a/63258198/436422
  @override
  Future<void> sendEmailVerification() => _user.sendEmailVerification();

  /// Check if the user is an admin by fetching the Firebase ID token and
  /// checking the custom claims inside it.
  @override
  Future<bool> isAdmin() async {
    // * Note: when a Firebase user is first created, the custom claim is not
    // * set until [setCustomUserClaims] is called in the
    // * [makeAdminIfWhitelisted] cloud function.
    // * There are two workarounds for this:
    // * 1. Sign out and sign in again (since this will force a token refresh)
    // * 2. Force refresh the token programmatically
    final idTokenResult = await _user.getIdTokenResult();
    final claims = idTokenResult.claims;
    if (claims != null) {
      return claims['admin'] == true;
    }
    return false;
  }

  @override
  Future<void> forceRefreshIdToken() => _user.getIdToken(true);
}
