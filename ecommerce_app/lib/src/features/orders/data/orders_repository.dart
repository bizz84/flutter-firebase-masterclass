import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class OrdersRepository {
  Stream<List<Order>> watchUserOrders(UserID uid, {ProductID? productId});
}

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  throw UnimplementedError();
});
