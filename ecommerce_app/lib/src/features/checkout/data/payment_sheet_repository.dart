import 'package:ecommerce_app/src/features/checkout/domain/checkout_session_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_sheet_repository.g.dart';

/// Class used to initialize and present the payment sheet (mobile-only)
class PaymentSheetRepository {
  PaymentSheetRepository(this._stripe);
  final Stripe _stripe;

  /// initialize the payment sheet with all the data from Firebase
  Future<void> initPaymentSheet({
    required String email,
    required int amount,
    required String currencyCode,
    required CheckoutSessionMobileData session,
  }) async {
    await _stripe.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Main params
        paymentIntentClientSecret: session.paymentIntentClientSecret,
        merchantDisplayName: 'eCommerce Store Demo',
        intentConfiguration: IntentConfiguration(
          mode: IntentMode(
            currencyCode: currencyCode,
            amount: amount,
          ),
        ),
        // Customer params
        customerId: session.customer,
        customerEphemeralKeySecret: session.ephemeralKeySecret,
        // Extra params
        applePay: const PaymentSheetApplePay(merchantCountryCode: 'GB'),
        googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'GB', testEnv: true),
        style: ThemeMode.dark,
        billingDetails: BillingDetails(
          email: email,
          // * If desired, the address can be entered in the UI and passed as an
          // * argument here
        ),
      ),
    );
  }

  /// Present the payment sheet
  Future<bool> presentPaymentSheet() async {
    try {
      await _stripe.presentPaymentSheet();
      return true;
    } on StripeException catch (e) {
      // * rethrow exception if something went wrong but not if the user
      // * canceled the purchase
      if (e.error.code != FailureCode.Canceled) {
        rethrow;
      }
      return false;
    }
  }
}

@riverpod
PaymentSheetRepository paymentSheetRepository(PaymentSheetRepositoryRef ref) {
  return PaymentSheetRepository(Stripe.instance);
}
