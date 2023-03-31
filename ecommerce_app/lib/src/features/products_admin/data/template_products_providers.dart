import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'template_products_providers.g.dart';

// A provider that returns the FakeProductsRepository
// (used to load template products data)
@riverpod
ProductsRepository templateProductsRepository(
    TemplateProductsRepositoryRef ref) {
  return FakeProductsRepository(addDelay: false);
}

/// * A [StreamProvider] to return only the template products to be shown in the
/// * [AdminProductsAddScreen] widget
@riverpod
Stream<List<Product>> templateProductsList(TemplateProductsListRef ref) {
  final templateProductsStream =
      ref.watch(templateProductsRepositoryProvider).watchProductsList();
  final existingProductsStream =
      ref.watch(productsRepositoryProvider).watchProductsList();
  return Rx.combineLatest2(templateProductsStream, existingProductsStream,
      (template, existing) {
    // return only the template products that have not been uploaded yet
    final existingProductIds = existing.map((product) => product.id).toList();
    return template
        .where((product) => !existingProductIds.contains(product.id))
        .toList();
  });
}

@riverpod
Stream<Product?> templateProduct(TemplateProductRef ref, ProductID id) {
  return ref.watch(templateProductsRepositoryProvider).watchProduct(id);
}
