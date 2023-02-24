import 'dart:async';

import 'package:ecommerce_app/src/features/products/data/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

class FakeProductsRepository implements ProductsRepository {
  FakeProductsRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload with the default list of products when the app starts
  final _products = InMemoryStore<List<Product>>(List.from(kTestProducts));

  /// Get a product by ID.
  /// This method is only used by some of the "fake" services in the app.
  /// In real-world apps, remote data can only be obtained asynchronously.
  Product? getProduct(ProductID id) {
    return _getProduct(_products.value, id);
  }

  // Retrieve the products list as a [Future] (one-time read)
  @override
  Future<List<Product>> fetchProductsList() async {
    return Future.value(_products.value);
  }

  // Retrieve the products list as a [Stream] (for realtime updates)
  @override
  Stream<List<Product>> watchProductsList() {
    return _products.stream;
  }

  // Retrieve a specific product by ID
  @override
  Stream<Product?> watchProduct(String id) {
    return watchProductsList().map((products) => _getProduct(products, id));
  }

  /// Update product or add a new one
  Future<void> setProduct(Product product) async {
    await delay(addDelay);
    final products = _products.value;
    final index = products.indexWhere((p) => p.id == product.id);
    if (index == -1) {
      // if not found, add as a new product
      products.add(product);
    } else {
      // else, overwrite previous product
      products[index] = product;
    }
    _products.value = products;
  }

  /// Search for products where the title contains the search query
  @override
  Future<List<Product>> searchProducts(String query) async {
    assert(
      _products.value.length <= 100,
      'Client-side search should only be performed if the number of products is small. '
      'Consider doing server-side search for larger datasets.',
    );
    // Get all products
    final productsList = await fetchProductsList();
    // Match all products where the title contains the query
    return productsList
        .where((product) =>
            product.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static Product? _getProduct(List<Product> products, String id) {
    // * This can also be implemented with [firstWhereOrNull] from this package:
    // * https://api.flutter.dev/flutter/package-collection_collection/IterableExtension/firstWhereOrNull.html
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
