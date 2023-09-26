// Helper classes and types for the [CheckoutSession] type

enum CheckoutSessionPlatform { mobile, web }

// * The checkout session data contains different fields for mobile and web
// * These are best represented with a sealed union and two subclasses
sealed class CheckoutSessionPlatformData {
  CheckoutSessionPlatformData({required this.platform});
  final CheckoutSessionPlatform platform;
}

class CheckoutSessionMobileData extends CheckoutSessionPlatformData {
  CheckoutSessionMobileData({
    required this.paymentIntentClientSecret,
    required this.ephemeralKeySecret,
    required this.customer,
  }) : super(platform: CheckoutSessionPlatform.mobile);
  final String paymentIntentClientSecret;
  final String ephemeralKeySecret;
  final String customer;
}

class CheckoutSessionWebData extends CheckoutSessionPlatformData {
  CheckoutSessionWebData({
    required this.url,
    required this.successUrl,
    required this.cancelUrl,
  }) : super(platform: CheckoutSessionPlatform.web);
  final String url;
  final String successUrl;
  final String cancelUrl;
}
