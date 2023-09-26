import 'package:ecommerce_app/src/features/checkout/presentation/payment/payment_button_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// * a conditional import is required here since on mobile we can't use dart:html
import 'package:ecommerce_app/src/utils/html_window_url_stub.dart'
    if (dart.library.html) 'package:ecommerce_app/src/utils/html_window_url_web.dart'
    if (dart.library.io) 'package:ecommerce_app/src/utils/html_window_url_non_web.dart';

/// Button used to initiate the payment flow.
class PaymentButton extends ConsumerWidget {
  const PaymentButton({super.key});

  Future<void> _pay(BuildContext context, WidgetRef ref) async {
    // * the current window URL will be used to generate the redirect path
    // * for Stripe checkout (web only)
    final windowUrl = getHtmlWindowUrl();
    // * start the payment process
    // * note that this won't work with the Firebase Local Emulator since the
    // * Firebase Stripe extension can only write to the real Firestore backend
    await ref.read(paymentButtonControllerProvider.notifier).pay(
          isWeb: kIsWeb,
          windowUrl: windowUrl,
          webUrlCallback: setHtmlWindowUrl,
        );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      paymentButtonControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(paymentButtonControllerProvider);
    return PrimaryButton(
      text: 'Pay'.hardcoded,
      isLoading: state.isLoading,
      onPressed: state.isLoading ? null : () => _pay(context, ref),
    );
  }
}
