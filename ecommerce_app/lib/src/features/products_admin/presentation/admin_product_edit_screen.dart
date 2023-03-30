import 'package:ecommerce_app/src/common_widgets/action_text_button.dart';
import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/common_widgets/async_value_widget.dart';
import 'package:ecommerce_app/src/common_widgets/custom_image.dart';
import 'package:ecommerce_app/src/common_widgets/custom_text_button.dart';
import 'package:ecommerce_app/src/common_widgets/error_message_widget.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_center.dart';
import 'package:ecommerce_app/src/common_widgets/responsive_two_column_layout.dart';
import 'package:ecommerce_app/src/constants/app_sizes.dart';
import 'package:ecommerce_app/src/features/products/data/products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/products_admin/data/template_products_providers.dart';
import 'package:ecommerce_app/src/features/products_admin/presentation/admin_product_edit_controller.dart';
import 'package:ecommerce_app/src/features/products_admin/presentation/product_validator.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';
import 'package:ecommerce_app/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget screen for updating existing products (edit mode).
/// Products are first created inside [AdminProductUploadScreen].
class AdminProductEditScreen extends ConsumerWidget {
  const AdminProductEditScreen({super.key, required this.productId});
  final ProductID productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productValue = ref.watch(productProvider(productId));
    return AsyncValueWidget<Product?>(
      value: productValue,
      data: (product) => product != null
          ? AdminProductEditScreenContents(product: product)
          : Scaffold(
              appBar: AppBar(
                title: Text('Edit Product'.hardcoded),
              ),
              body: Center(
                child: ErrorMessageWidget('Product not found'.hardcoded),
              ),
            ),
    );
  }
}

/// Widget containing most of the UI for editing a product
class AdminProductEditScreenContents extends ConsumerStatefulWidget {
  const AdminProductEditScreenContents({super.key, required this.product});
  final Product product;

  @override
  ConsumerState<AdminProductEditScreenContents> createState() =>
      _AdminProductScreenContentsState();
}

class _AdminProductScreenContentsState
    extends ConsumerState<AdminProductEditScreenContents> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _availableQuantityController = TextEditingController();

  Product get product => widget.product;

  @override
  void initState() {
    super.initState();
    // Initialize text fields with product data
    _titleController.text = product.title;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();
    _availableQuantityController.text = product.availableQuantity.toString();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _availableQuantityController.dispose();
    super.dispose();
  }

  Future<void> _loadFromTemplate() async {
    final template = await ref.read(templateProductProvider(product.id).future);
    if (template != null) {
      _titleController.text = template.title;
      _descriptionController.text = template.description;
      _priceController.text = template.price.toString();
      _availableQuantityController.text = template.availableQuantity.toString();
      _formKey.currentState!.validate();
    }
  }

  Future<void> _delete() async {
    final delete = await showAlertDialog(
      context: context,
      title: 'Are you sure?'.hardcoded,
      cancelActionText: 'Cancel'.hardcoded,
      defaultActionText: 'Delete'.hardcoded,
    );
    if (delete == true) {
      ref
          .read(adminProductEditControllerProvider.notifier)
          .deleteProduct(product);
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final success = await ref
          .read(adminProductEditControllerProvider.notifier)
          .updateProduct(
            product: product,
            title: _titleController.text,
            description: _descriptionController.text,
            price: _priceController.text,
            availableQuantity: _availableQuantityController.text,
          );
      if (success) {
        // Inform the user that the product has been updated
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(
              'Product updated'.hardcoded,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      adminProductEditControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(adminProductEditControllerProvider);
    final isLoading = state.isLoading;
    const autovalidateMode = AutovalidateMode.disabled;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'.hardcoded),
        actions: [
          ActionTextButton(
            text: 'Save'.hardcoded,
            onPressed: isLoading ? null : _submit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveCenter(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Form(
            key: _formKey,
            child: ResponsiveTwoColumnLayout(
              startContent: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: CustomImage(imageUrl: product.imageUrl),
                ),
              ),
              spacing: Sizes.p16,
              endContent: Card(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          label: Text('Title'.hardcoded),
                        ),
                        autovalidateMode: autovalidateMode,
                        validator:
                            ref.read(productValidatorProvider).titleValidator,
                      ),
                      gapH8,
                      TextFormField(
                        controller: _descriptionController,
                        enabled: !isLoading,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          label: Text('Description'.hardcoded),
                        ),
                        autovalidateMode: autovalidateMode,
                        validator: ref
                            .read(productValidatorProvider)
                            .descriptionValidator,
                      ),
                      gapH8,
                      TextFormField(
                        controller: _priceController,
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          label: Text('Price'.hardcoded),
                        ),
                        autovalidateMode: autovalidateMode,
                        validator:
                            ref.read(productValidatorProvider).priceValidator,
                      ),
                      gapH8,
                      TextFormField(
                        controller: _availableQuantityController,
                        enabled: !isLoading,
                        decoration: InputDecoration(
                          label: Text('Available Quantity'.hardcoded),
                        ),
                        autovalidateMode: autovalidateMode,
                        validator: ref
                            .read(productValidatorProvider)
                            .availableQuantityValidator,
                      ),
                      gapH16,
                      const Divider(),
                      gapH8,
                      EditProductOptions(
                        onLoadFromTemplate:
                            isLoading ? null : _loadFromTemplate,
                        onDelete: isLoading ? null : _delete,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Responsive widget with options to preload product data and delete a product
class EditProductOptions extends StatelessWidget {
  const EditProductOptions(
      {super.key, required this.onLoadFromTemplate, required this.onDelete});
  final VoidCallback? onLoadFromTemplate;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ResponsiveTwoColumnLayout(
      rowMainAxisAlignment: MainAxisAlignment.center,
      startContent: CustomTextButton(
        text: 'Load from Template'.hardcoded,
        style: Theme.of(context).textTheme.titleSmall,
        onPressed: onLoadFromTemplate,
      ),
      endContent: CustomTextButton(
        text: 'Delete Product'.hardcoded,
        style:
            Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.red),
        onPressed: onDelete,
      ),
      spacing: Sizes.p8,
    );
  }
}
