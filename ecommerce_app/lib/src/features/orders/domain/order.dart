import 'package:ecommerce_app/src/exceptions/app_exception.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:equatable/equatable.dart';

/// Order status
enum OrderStatus { confirmed, shipped, delivered }

/// Helper method to get the order status from String
extension OrderStatusString on OrderStatus {
  static OrderStatus fromString(String string) {
    if (string == 'confirmed') return OrderStatus.confirmed;
    if (string == 'shipped') return OrderStatus.shipped;
    if (string == 'delivered') return OrderStatus.delivered;
    throw ParseOrderFailureException(string);
  }
}

/// * The order identifier is an important concept and can have its own type.
typedef OrderID = String;

/// Model class representing an order placed by the user.
class Order extends Equatable {
  const Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.productIds,
    required this.orderStatus,
    required this.orderDate,
    required this.total,
  });

  /// Unique order ID
  final OrderID id;

  /// ID of the user who made the order
  final String userId;

  /// List of items in that order
  final Map<ProductID, int> items;

  /// List of all product IDs in the order - useful for Firestore queries
  final List<ProductID> productIds;
  final OrderStatus orderStatus;
  final DateTime orderDate;
  final double total;

  factory Order.fromMap(Map<String, dynamic> map, OrderID id) {
    return Order(
      id: id,
      userId: map['userId'],
      items: Map<String, int>.from(map['items']),
      productIds: List<String>.from(map['productIds']),
      orderStatus: OrderStatusString.fromString(map['orderStatus']),
      orderDate: DateTime.parse(map['orderDate']),
      total: (map['total'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'items': items,
        'productIds': productIds,
        'orderStatus': orderStatus.name,
        'orderDate': orderDate.toIso8601String(),
        'total': total,
      };

  @override
  List<Object?> get props =>
      [id, userId, items, productIds, orderStatus, orderDate, total];

  @override
  bool? get stringify => true;
}
