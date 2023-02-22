import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';

/// Model class representing the shopping cart contents.
class Cart extends Equatable {
  const Cart([this.items = const {}]);

  /// All the items in the shopping cart, where:
  /// - key: product ID
  /// - value: quantity
  final Map<ProductID, int> items;

  // data serialization
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      Map<ProductID, int>.from(map['items']),
    );
  }

  Map<String, dynamic> toMap() => {
        'items': items,
      };

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [items];

  @override
  bool? get stringify => true;
}

extension CartItems on Cart {
  List<Item> toItemsList() {
    return items.entries.map((entry) {
      return Item(
        productId: entry.key,
        quantity: entry.value,
      );
    }).toList();
  }
}
