import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkout_service.g.dart';

// TODO: Implement with Firebase
abstract class CheckoutService {
  Future<void> placeOrder();
}

@riverpod
CheckoutService checkoutService(CheckoutServiceRef ref) {
  // TODO: create and return service
  throw UnimplementedError();
}
