import 'package:ecommerce_app/src/features/checkout/domain/checkout_session_platform.dart';

/// Model class used to represent a Firestore document at this location:
/// 'stripe_customers/$uid/checkout_sessions/$sessionId'
class CheckoutSession {
  const CheckoutSession({
    required this.amount,
    required this.currency,
    this.platformData,
  });
  final int amount;
  final String currency;
  // nullable since this data is missing until it is written by the Stripe
  // extension
  final CheckoutSessionPlatformData? platformData;

  factory CheckoutSession.fromMap(Map<String, dynamic> map) {
    final client = map['client'];
    final amount = map['amount'];
    final currency = map['currency'];

    // * parse different fields depending on whether we're on mobile or web
    if (client == 'mobile') {
      final paymentIntentClientSecret = map['paymentIntentClientSecret'];
      final ephemeralKeySecret = map['ephemeralKeySecret'];
      final customer = map['customer'];
      if (paymentIntentClientSecret != null &&
          ephemeralKeySecret != null &&
          customer != null) {
        return CheckoutSession(
          amount: amount,
          currency: currency,
          platformData: CheckoutSessionMobileData(
            customer: customer,
            paymentIntentClientSecret: paymentIntentClientSecret,
            ephemeralKeySecret: ephemeralKeySecret,
          ),
        );
      }
    } else if (client == 'web') {
      final url = map['url'];
      final successUrl = map['success_url'];
      final cancelUrl = map['cancel_url'];
      if (url != null && successUrl != null && cancelUrl != null) {
        return CheckoutSession(
          amount: amount,
          currency: currency,
          platformData: CheckoutSessionWebData(
            url: url,
            successUrl: successUrl,
            cancelUrl: cancelUrl,
          ),
        );
      }
    }
    // if the mobile or web data is not available yet, return this:
    return CheckoutSession(
      amount: amount,
      currency: currency,
    );
  }

  Map<String, dynamic> toMap() {
    // use pattern matching to decide which properties to write back
    return switch (platformData) {
      // mobile
      CheckoutSessionMobileData(
        :final paymentIntentClientSecret,
        :final ephemeralKeySecret,
        :final customer,
      ) =>
        {
          'client': 'mobile',
          'amount': amount,
          'currency': currency,
          'paymentIntentClientSecret': paymentIntentClientSecret,
          'ephemeralKeySecret': ephemeralKeySecret,
          'customer': customer,
        },
      // web
      CheckoutSessionWebData(
        :final url,
        :final successUrl,
        :final cancelUrl,
      ) =>
        {
          'client': 'web',
          'amount': amount,
          'currency': currency,
          'url': url,
          'success_url': successUrl,
          'cancel_url': cancelUrl,
        },
      // no data yet
      _ => {
          'amount': amount,
          'currency': currency,
        },
    };
  }
}
