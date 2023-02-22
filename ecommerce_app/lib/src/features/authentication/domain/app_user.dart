import 'package:equatable/equatable.dart';

typedef UserID = String;

/// Simple class representing the user UID and email.
class AppUser extends Equatable {
  const AppUser({
    required this.uid,
    required this.email,
  });
  final UserID uid;
  final String? email;

  @override
  List<Object?> get props => [uid, email];

  @override
  bool? get stringify => true;
}
