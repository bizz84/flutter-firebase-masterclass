import 'package:ecommerce_app/src/features/products/data/products_search_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_search_query_notifier.g.dart';

/// A simple notifier class to keep track of the search query
@riverpod
class ProductsSearchQueryNotifier extends _$ProductsSearchQueryNotifier {
  /// By default, return an empty query
  @override
  String build() => '';

  void setQuery(String query) => state = query;
}

/// A provider that returns the search results for the current search query
@riverpod
Future<List<Product>> productsSearchResults(ProductsSearchResultsRef ref) {
  final searchQuery = ref.watch(productsSearchQueryNotifierProvider);
  return ref.watch(productsListSearchProvider(searchQuery).future);
}
