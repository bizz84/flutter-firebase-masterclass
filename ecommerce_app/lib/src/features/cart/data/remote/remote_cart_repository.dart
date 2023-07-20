import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_cart_repository.g.dart';

/// API for reading, watching and writing cart data for a specific user ID
class RemoteCartRepository {
  RemoteCartRepository(this._firestore);
  final FirebaseFirestore _firestore;

  Future<Cart> fetchCart(UserID uid) async {
    final ref = _cartRef(uid);
    final snapshot = await ref.get();
    return snapshot.data() ?? const Cart();
  }

  Stream<Cart> watchCart(UserID uid) {
    final ref = _cartRef(uid);
    return ref.snapshots().map((snapshot) => snapshot.data() ?? const Cart());
  }

  Future<void> setCart(UserID uid, Cart cart) async {
    final ref = _cartRef(uid);
    await ref.set(cart);
  }

  DocumentReference<Cart> _cartRef(UserID uid) =>
      _firestore.doc('cart/$uid').withConverter(
            fromFirestore: (doc, _) => Cart.fromMap(doc.data()!),
            toFirestore: (cart, _) => cart.toMap(),
          );
}

@Riverpod(keepAlive: true)
RemoteCartRepository remoteCartRepository(RemoteCartRepositoryRef ref) {
  return RemoteCartRepository(FirebaseFirestore.instance);
}
