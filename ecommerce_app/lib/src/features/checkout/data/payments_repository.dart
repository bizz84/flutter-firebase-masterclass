import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/checkout/domain/payment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payments_repository.g.dart';

/// Class used to read data from the payments documents at:
/// 'stripe_customers/$uid/payments/$paymentId'
/// This data is written by the Firebase Stripe extension
class PaymentsRepository {
  const PaymentsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String paymentPath(UserID uid, String paymentId) =>
      'stripe_customers/$uid/payments/$paymentId';

  Stream<Payment?> watchPayment(UserID uid, String paymentId) {
    final ref = _paymentRef(uid, paymentId);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  DocumentReference<Payment?> _paymentRef(UserID uid, String paymentId) =>
      _firestore.doc(paymentPath(uid, paymentId)).withConverter(
            fromFirestore: (doc, _) {
              final data = doc.data();
              return data != null ? Payment.fromMap(data) : null;
            },
            toFirestore: (payment, _) => payment?.toMap() ?? {},
          );
}

@riverpod
PaymentsRepository paymentsRepository(PaymentsRepositoryRef ref) {
  return PaymentsRepository(FirebaseFirestore.instance);
}
