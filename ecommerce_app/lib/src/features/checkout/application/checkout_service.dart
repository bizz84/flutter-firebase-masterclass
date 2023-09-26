import 'dart:async';

import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/application/cart_service.dart';
import 'package:ecommerce_app/src/features/checkout/data/checkout_sessions_repository.dart';
import 'package:ecommerce_app/src/features/checkout/data/payment_sheet_repository.dart';
import 'package:ecommerce_app/src/features/checkout/data/payments_repository.dart';
import 'package:ecommerce_app/src/features/checkout/domain/checkout_session_platform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkout_service.g.dart';

/// Class used to place an order (checkout)
class CheckoutService {
  CheckoutService(this._ref);
  final Ref _ref;

  /// listen to checkout session updates with this subscription
  StreamSubscription<void>? _checkoutSessionSubscription;

  /// listen to payment updates with this subscription
  StreamSubscription<void>? _paymentSubscription;

  /// used to tell the pay method when the listener has completed
  late Completer _completer;

  /// Public method to place an order
  Future<void> pay({
    required bool isWeb,
    String? windowUrl,
    void Function(String)? webUrlCallback,
  }) async {
    final user = _ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      throw UserNotSignedInException();
    }

    // * create completer and cancel the previous subscription (if any)
    _completer = Completer();
    _checkoutSessionSubscription?.cancel();

    // * calculate cart total
    final cartTotal = await _ref.read(cartTotalProvider.future);
    // https://stripe.com/docs/api/payment_intents/object#payment_intent_object-amount
    final paymentAmount = (cartTotal * 100).round();

    // * get all the products in the cart along with their quantity
    final productsInCart = await _ref.read(productsInCartProvider.future);

    // * get the cancel and success URLs from the windowUrl
    final cancelUrl = windowUrl;
    final successUrl = () {
      if (cancelUrl != null) {
        // keep the same host, update the path
        final uri = Uri.parse(cancelUrl);
        return cancelUrl.replaceAll(uri.path, '/orders');
      } else {
        return cancelUrl;
      }
    }();

    // * write the checkout session
    final sessionId = await _ref
        .read(checkoutSessionsRepositoryProvider)
        .writeCheckoutSession(
          uid: user.uid,
          amount: paymentAmount,
          productsInCart: productsInCart,
          isWeb: isWeb,
          cancelUrl: cancelUrl,
          successUrl: successUrl,
        );

    // * Once we've written the checkout session, Stripe will process it and
    // * write the paymentIntentClientSecret, ephemeralKeySecret, and customer
    // * back to it.
    // * So here we listen for changes and once we have a payment intent object,
    // * we use it to show the appropriate payment UI depending on the platform
    _checkoutSessionSubscription = _ref
        .read(checkoutSessionsRepositoryProvider)
        .watchCheckoutSession(user.uid, sessionId)
        .listen((session) async {
      final sessionData = session.platformData;
      if (sessionData is CheckoutSessionMobileData) {
        // subscription is no longer needed once we get the session data
        _checkoutSessionSubscription?.cancel();
        // show the payment sheet
        await _showPaymentSheet(
          user: user,
          amount: session.amount,
          currencyCode: session.currency,
          sessionData: sessionData,
        );
      } else if (sessionData is CheckoutSessionWebData) {
        // subscription is no longer needed once we get the session data
        _checkoutSessionSubscription?.cancel();
        // complete so the pay method can return
        _completer.complete(null);
        // call the web callback to show the Stripe checkout page
        webUrlCallback?.call(sessionData.url);
      }
    });
    return _completer.future;
  }

  /// show the payment sheet (mobile-only)
  Future<void> _showPaymentSheet({
    required AppUser user,
    required int amount,
    required String currencyCode,
    required CheckoutSessionMobileData sessionData,
  }) async {
    try {
      await _ref.read(paymentSheetRepositoryProvider).initPaymentSheet(
            email: user.email!,
            amount: amount,
            currencyCode: currencyCode,
            session: sessionData,
          );

      // Present payment sheet
      final success =
          await _ref.read(paymentSheetRepositoryProvider).presentPaymentSheet();
      if (success) {
        // the paymentIntentClientSecret looks like this in Firebase:
        // Example: pi_3NpTonFM8wJkf9qo1S88cFMY_secret_R7ogsCVPaAprESUdAUnSOhOY5
        // but we're interested in the paymentIntent only
        final components = sessionData.paymentIntentClientSecret.split('_');
        final paymentIntent = '${components[0]}_${components[1]}';
        // listen and wait until the payment has been completed
        _paymentSubscription = _ref
            .read(paymentsRepositoryProvider)
            .watchPayment(user.uid, paymentIntent)
            .listen((payment) {
          if (payment != null) {
            _paymentSubscription?.cancel();
            _completer.complete(null);
          }
        });
      } else {
        // if the user has canceled the purchase, complete
        _completer.complete(null);
      }
    } catch (e, st) {
      _paymentSubscription?.cancel();
      _completer.completeError(e, st);
    }
  }

  // cleanup
  void dispose() {
    _checkoutSessionSubscription?.cancel();
    _paymentSubscription?.cancel();
  }
}

@Riverpod(keepAlive: true)
CheckoutService checkoutService(CheckoutServiceRef ref) {
  final service = CheckoutService(ref);
  ref.onDispose(service.dispose);
  return service;
}
