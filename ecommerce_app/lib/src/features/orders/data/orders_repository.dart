import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/orders/domain/order.dart';
import 'package:ecommerce_app/src/features/orders/domain/user_order.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'orders_repository.g.dart';

class OrdersRepository {
  OrdersRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String ordersPath() => 'orders';
  static String userOrderPath(UserID uid, String id) => 'users/$uid/orders/$id';
  static String latestOrdersPath(UserID uid) => 'latest_orders/$uid';

  /// Get all the orders made by the given user
  /// If a productId is passed, only the orders that contain that productId
  /// will be returned
  Stream<List<Order>> watchUserOrders(UserID uid, {ProductID? productId}) {
    final ref = _userOrdersRef(uid, productId: productId);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  /// Get the latest order ID for the given user
  Stream<UserOrderID> watchLatestUserOrderId(UserID uid) {
    final ref = _firestore.doc(latestOrdersPath(uid));
    return ref.snapshots().map((snapshot) {
      final data = snapshot.data();
      return (
        uid: uid,
        orderId: data != null ? data['orderId'] : null,
      );
    });
  }

  /// Using a collection group makes it possible to perform two distinct
  /// operations that would not both be possible with a regular subcollection:
  /// - fetching all orders for a given user (by UID)
  /// - fetching all orders for all users (useful for admin purposes)
  /// For more details, read this:
  /// https://firebase.blog/posts/2019/06/understanding-collection-group-queries
  Query<Order> _userOrdersRef(String uid, {ProductID? productId}) {
    var query = _firestore
        .collectionGroup(ordersPath())
        .where('userId', isEqualTo: uid);
    if (productId != null) {
      query = query.where('productIds', arrayContains: productId);
    }
    return query.orderBy('orderDate', descending: true).withConverter(
          fromFirestore: (doc, _) => Order.fromMap(doc.data()!, doc.id),
          toFirestore: (Order order, options) => order.toMap(),
        );
  }
}

@Riverpod(keepAlive: true)
OrdersRepository ordersRepository(OrdersRepositoryRef ref) {
  return OrdersRepository(FirebaseFirestore.instance);
}
