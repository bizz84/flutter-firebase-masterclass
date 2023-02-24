import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkout_service.g.dart';

abstract class CheckoutService {
  Future<void> placeOrder();
}

@riverpod
CheckoutService checkoutService(CheckoutServiceRef ref) {
  throw UnimplementedError();
}
