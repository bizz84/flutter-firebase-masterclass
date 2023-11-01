import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:ecommerce_app/env.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_search_repository.g.dart';

/// Class used to search products using the Algolia Dart Client
class ProductsSearchRepository {
  const ProductsSearchRepository(this._searcher);
  final HitsSearcher _searcher;

  /// Search for the given text an return a list of products
  Future<List<Product>> search(String text) async {
    // * Set the search query
    _searcher.query(text);
    // * The first event that is emitted by the stream will contain the results
    final response = await _searcher.responses.first;
    return response.hits
        .map((hit) => Product.fromMap(Map.fromEntries(hit.entries)))
        .toList();
  }
}

@Riverpod(keepAlive: true)
ProductsSearchRepository productsSearchRepository(Ref ref) {
  final algolia = HitsSearcher(
    applicationID: Env.algoliaAppId,
    apiKey: Env.algoliaSearchKey,
    // * Use the index name that is configured in the Algolia dashboard
    // * https://dashboard.algolia.com/apps/APP_ID/explorer/browse
    indexName: 'products_index',
  );
  return ProductsSearchRepository(algolia);
}

@riverpod
Future<List<Product>> productsListSearch(Ref ref, String query) async {
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
  final searchRepository = ref.watch(productsSearchRepositoryProvider);
  return searchRepository.search(query);
}
