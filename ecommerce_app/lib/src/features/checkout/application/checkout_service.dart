import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'checkout_service.g.dart';

class CheckoutService {
  CheckoutService(this._ref);
  final Ref _ref;

  Future<void> placeOrder() {
    // TODO: Implement with Firebase
    throw UnimplementedError();
  }
}

@riverpod
CheckoutService checkoutService(Ref ref) {
  return CheckoutService(ref);
}
