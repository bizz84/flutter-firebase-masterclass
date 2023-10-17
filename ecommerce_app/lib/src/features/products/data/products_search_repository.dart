import 'dart:async';

import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_search_repository.g.dart';

/// Class used to search products using the Algolia Dart Client
class ProductsSearchRepository {
  // TODO: Add Algolia as a dependency
  const ProductsSearchRepository();

  /// Search for the given text an return a list of products
  Future<List<Product>> search(String text) async {
    // TODO: Implement
    throw UnimplementedError();
  }
}

@Riverpod(keepAlive: true)
ProductsSearchRepository productsSearchRepository(
    ProductsSearchRepositoryRef ref) {
  // TODO: Initialize the Algolia client with the API keys
  return const ProductsSearchRepository();
}

@riverpod
Future<List<Product>> productsListSearch(
    ProductsListSearchRef ref, String query) async {
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the timer
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
  // TODO: use ProductsSearchRepository instead
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.search(query);
}
