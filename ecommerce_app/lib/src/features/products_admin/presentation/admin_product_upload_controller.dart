import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/products_admin/application/image_upload_service.dart';
import 'package:ecommerce_app/src/routing/app_router.dart';
import 'package:ecommerce_app/src/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admin_product_upload_controller.g.dart';

@riverpod
class AdminProductUploadController extends _$AdminProductUploadController
    with NotifierMounted {
  @override
  FutureOr<void> build() {
    ref.onDispose(setUnmounted);
    // no-op
  }

  Future<void> upload(Product product) async {
    try {
      state = const AsyncLoading();
      // delegate product upload to the service class
      await ref.read(imageUploadServiceProvider).uploadProduct(product);
      // On success, go to the product edit page
      ref.read(goRouterProvider).goNamed(
        AppRoute.adminEditProduct.name,
        pathParameters: {'id': product.id},
      );
    } catch (e, st) {
      if (mounted) {
        state = AsyncError(e, st);
      }
    }
  }
}
