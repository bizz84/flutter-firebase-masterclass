import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class CheckoutService {
  Future<void> placeOrder();
}

final checkoutServiceProvider = Provider<CheckoutService>((ref) {
  throw UnimplementedError();
});
