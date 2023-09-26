import 'package:envied/envied.dart';

part 'env.g.dart';

// * To configure this, follow these steps.
// * 1. grab an API key from here:
// * https://dashboard.stripe.com/test/apikeys
// * 2. create a `.env` file and add your key:
// STRIPE_PUBLISHABLE_KEY=pk_test_YOUR_STRIPE_PUBLISHABLE_KEY
// * 3. run the generator:
// dart run build_runner build -d

@Envied()
final class Env {
  @EnviedField(varName: 'STRIPE_PUBLISHABLE_KEY', obfuscate: true)
  static final String stripePublishableKey = _Env.stripePublishableKey;
}
