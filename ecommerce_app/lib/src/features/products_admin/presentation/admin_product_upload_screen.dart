import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/common_widgets/error_message_widget.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/constants/breakpoints.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/products_admin/data/template_products_providers.dart';
import 'package:ecommerce_app/src/features/products_admin/presentation/admin_product_upload_controller.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Used to upload a product to cloud storage
class AdminProductUploadScreen extends StatelessWidget {
  const AdminProductUploadScreen({super.key, required this.productId});
  final ProductID productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload a product'.hardcoded),
      ),
      body: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: AdminProductUpload(productId: productId),
      ),
    );
  }
}

class AdminProductUpload extends ConsumerWidget {
  const AdminProductUpload({super.key, required this.productId});
  final ProductID productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      adminProductUploadControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    // State of the upload operation
    final state = ref.watch(adminProductUploadControllerProvider);
    final isLoading = state.isLoading;
    // Product to be uploaded
    final templateProductValue = ref.watch(templateProductProvider(productId));
    return AsyncValueWidget<Product?>(
      value: templateProductValue,
      data: (templateProduct) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (templateProduct != null) ...[
                CustomImage(imageUrl: templateProduct.imageUrl),
                gapH16,
                PrimaryButton(
                  text: 'Upload'.hardcoded,
                  isLoading: isLoading,
                  onPressed: isLoading
                      ? null
                      : () => ref
                          .read(adminProductUploadControllerProvider.notifier)
                          .upload(templateProduct),
                ),
              ] else
                ErrorMessageWidget(
                    'Product template not found for ID: $productId'),
            ],
          ),
        ),
      ),
    );
  }
}
