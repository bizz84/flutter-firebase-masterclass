import 'dart:io';

import 'package:ecommerce_app/env.dart';
import 'package:ecommerce_app/src/app_bootstrap.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

extension AppBootstrapStripe on AppBootstrap {
  Future<void> setupStripe() async {
    if (kIsWeb || Platform.isIOS || Platform.isAndroid) {
      Stripe.publishableKey = Env.stripePublishableKey;
      // https://stripe.com/gb/resources/more/merchant-id
      Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
      // https://stripe.com/docs/payments/mobile/accept-payment?platform=ios&ui=payment-sheet#ios-set-up-return-url
      Stripe.urlScheme = 'flutterstripe';
      await Stripe.instance.applySettings();
    }
  }
}
