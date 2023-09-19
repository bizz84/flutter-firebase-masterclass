import 'package:envied/envied.dart';

part 'env.g.dart';

// * To configure this, create the `ecommerce_app/.env` file and add your key:
// STRIPE_PUBLISHABLE_KEY=pk_test_YOUR_STRIPE_PUBLISHABLE_KEY
// * Then, run the generator:
// dart run build_runner build -d

@Envied()
final class Env {
  @EnviedField(varName: 'STRIPE_PUBLISHABLE_KEY', obfuscate: true)
  static final String stripePublishableKey = _Env.stripePublishableKey;
}
