import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:equatable/equatable.dart';

/// A product along with a quantity that can be added to an order/cart
class Item extends Equatable {
  const Item({
    required this.productId,
    required this.quantity,
  });
  final ProductID productId;
  final int quantity;

  @override
  List<Object?> get props => [productId, quantity];

  @override
  bool? get stringify => true;
}
