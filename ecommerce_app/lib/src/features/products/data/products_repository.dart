import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_repository.g.dart';

class ProductsRepository {
  const ProductsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // TODO: Implement all methods using Cloud Firestore
  Future<List<Product>> fetchProductsList() {
    return Future.value([]);
  }

  Stream<List<Product>> watchProductsList() {
    return Stream.value([]);
  }

  Stream<Product?> watchProduct(ProductID id) {
    final ref = _firestore.doc('products/$id').withConverter(
          fromFirestore: (doc, _) => Product.fromMap(doc.data()!),
          toFirestore: (product, _) => product.toMap(),
        );
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<List<Product>> searchProducts(String query) {
    return Future.value([]);
  }

  Future<void> createProduct(ProductID id, String imageUrl) {
    return _firestore.doc('products/$id').set(
      {
        'id': id,
        'imageUrl': imageUrl,
      },
      // use merge: true to keep old fields (if any)
      SetOptions(merge: true),
    );
  }
}

@Riverpod(keepAlive: true)
ProductsRepository productsRepository(ProductsRepositoryRef ref) {
  return ProductsRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Product>> productsListStream(ProductsListStreamRef ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProductsList();
}

@riverpod
Future<List<Product>> productsListFuture(ProductsListFutureRef ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProductsList();
}

@riverpod
Stream<Product?> product(ProductRef ref, ProductID id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
}

@riverpod
Future<List<Product>> productsListSearch(
    ProductsListSearchRef ref, String query) async {
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.searchProducts(query);
}
