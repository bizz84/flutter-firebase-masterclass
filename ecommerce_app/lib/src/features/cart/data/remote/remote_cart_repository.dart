import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// API for reading, watching and writing cart data for a specific user ID
abstract class RemoteCartRepository {
  Future<Cart> fetchCart(UserID uid);

  Stream<Cart> watchCart(UserID uid);

  Future<void> setCart(UserID uid, Cart cart);
}

final remoteCartRepositoryProvider = Provider<RemoteCartRepository>((ref) {
  throw UnimplementedError();
});
