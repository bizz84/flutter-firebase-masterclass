import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_repository.g.dart';

// TODO: Implement with Firebase
abstract class OrdersRepository {
  Stream<List<Order>> watchUserOrders(UserID uid, {ProductID? productId});
}

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(OrdersRepositoryRef ref) {
  // TODO: create and return repository
  throw UnimplementedError();
}
