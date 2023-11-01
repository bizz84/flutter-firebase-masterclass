import 'package:envied/envied.dart';

part 'env.g.dart';

// * To configure this, follow these steps.
// * 1. grab the API keys from here:
// * https://dashboard.stripe.com/test/apikeys
// * https://dashboard.algolia.com/account/api-keys
// * 2. create a `.env` file and add your keys:
// STRIPE_PUBLISHABLE_KEY=pk_test_YOUR_STRIPE_PUBLISHABLE_KEY
// ALGOLIA_APP_ID=YOUR_ALGOLIA_APP_ID
// ALGOLIA_SEARCH_KEY=YOUR_ALGOLIA_SEARCH_KEY
// * 3. run the generator:
// dart run build_runner build -d

@Envied()
final class Env {
  @EnviedField(varName: 'STRIPE_PUBLISHABLE_KEY', obfuscate: true)
  static final String stripePublishableKey = _Env.stripePublishableKey;

  @EnviedField(varName: 'ALGOLIA_APP_ID', obfuscate: true)
  static final String algoliaAppId = _Env.algoliaAppId;

  @EnviedField(varName: 'ALGOLIA_SEARCH_KEY', obfuscate: true)
  static final String algoliaSearchKey = _Env.algoliaSearchKey;
}
