/// Model class used to represent a Firestore document at this location:
/// 'stripe_customers/$uid/payments/$paymentId'
class Payment {
  const Payment({required this.succeeded});
  final bool succeeded;

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(succeeded: map['status'] == 'succeeded');
  }

  Map<String, dynamic> toMap() {
    return {
      if (succeeded) 'status': 'succeeded',
    };
  }
}
