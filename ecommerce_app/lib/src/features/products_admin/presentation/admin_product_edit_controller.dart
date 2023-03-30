import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_product_edit_controller.g.dart';

@riverpod
class AdminProductEditController extends _$AdminProductEditController {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<bool> updateProduct({
    required Product product,
    required String title,
    required String description,
    required String price,
    required String availableQuantity,
  }) async {
    final productsRepository = ref.read(productsRepositoryProvider);
    // Parse the input values (already pre-validated)
    final priceValue = double.parse(price);
    final availableQuantityValue = int.parse(availableQuantity);
    // Update product metadata (keep the pre-existing id and imageUrl)
    final updatedProduct = product.copyWith(
      title: title,
      description: description,
      price: priceValue,
      availableQuantity: availableQuantityValue,
    );
    state = const AsyncLoading();
    state = await AsyncValue.guard(
        () => productsRepository.updateProduct(updatedProduct));
    final success = state.hasError == false;
    if (success) {
      // on success, go back to previous screen
      ref.read(goRouterProvider).pop();
    }
    return success;
  }
}
