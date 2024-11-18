// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartServiceHash() => r'39c8f9110000b97aacdb92c65d04e7d467a05feb';

/// See also [cartService].
@ProviderFor(cartService)
final cartServiceProvider = AutoDisposeProvider<CartService>.internal(
  cartService,
  name: r'cartServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartServiceRef = AutoDisposeProviderRef<CartService>;
String _$cartHash() => r'869f594bde7568b7863f4953bd1b763fbc52afb6';

/// See also [cart].
@ProviderFor(cart)
final cartProvider = AutoDisposeStreamProvider<Cart>.internal(
  cart,
  name: r'cartProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartRef = AutoDisposeStreamProviderRef<Cart>;
String _$cartItemsCountHash() => r'691fed458b5c5b8d7a5e9602dfbf29019ffc9175';

/// See also [cartItemsCount].
@ProviderFor(cartItemsCount)
final cartItemsCountProvider = AutoDisposeProvider<int>.internal(
  cartItemsCount,
  name: r'cartItemsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartItemsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartItemsCountRef = AutoDisposeProviderRef<int>;
String _$cartTotalHash() => r'6d6793911f824ffa699d2d1aa904729e05de6756';

/// See also [cartTotal].
@ProviderFor(cartTotal)
final cartTotalProvider = AutoDisposeProvider<double>.internal(
  cartTotal,
  name: r'cartTotalProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cartTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalRef = AutoDisposeProviderRef<double>;
String _$itemAvailableQuantityHash() =>
    r'7862f2c468049a37946711a9e97e8c66b35fe020';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [itemAvailableQuantity].
@ProviderFor(itemAvailableQuantity)
const itemAvailableQuantityProvider = ItemAvailableQuantityFamily();

/// See also [itemAvailableQuantity].
class ItemAvailableQuantityFamily extends Family<int> {
  /// See also [itemAvailableQuantity].
  const ItemAvailableQuantityFamily();

  /// See also [itemAvailableQuantity].
  ItemAvailableQuantityProvider call(
    Product product,
  ) {
    return ItemAvailableQuantityProvider(
      product,
    );
  }

  @override
  ItemAvailableQuantityProvider getProviderOverride(
    covariant ItemAvailableQuantityProvider provider,
  ) {
    return call(
      provider.product,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'itemAvailableQuantityProvider';
}

/// See also [itemAvailableQuantity].
class ItemAvailableQuantityProvider extends AutoDisposeProvider<int> {
  /// See also [itemAvailableQuantity].
  ItemAvailableQuantityProvider(
    Product product,
  ) : this._internal(
          (ref) => itemAvailableQuantity(
            ref as ItemAvailableQuantityRef,
            product,
          ),
          from: itemAvailableQuantityProvider,
          name: r'itemAvailableQuantityProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$itemAvailableQuantityHash,
          dependencies: ItemAvailableQuantityFamily._dependencies,
          allTransitiveDependencies:
              ItemAvailableQuantityFamily._allTransitiveDependencies,
          product: product,
        );

  ItemAvailableQuantityProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final Product product;

  @override
  Override overrideWith(
    int Function(ItemAvailableQuantityRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ItemAvailableQuantityProvider._internal(
        (ref) => create(ref as ItemAvailableQuantityRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _ItemAvailableQuantityProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ItemAvailableQuantityProvider && other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ItemAvailableQuantityRef on AutoDisposeProviderRef<int> {
  /// The parameter `product` of this provider.
  Product get product;
}

class _ItemAvailableQuantityProviderElement
    extends AutoDisposeProviderElement<int> with ItemAvailableQuantityRef {
  _ItemAvailableQuantityProviderElement(super.provider);

  @override
  Product get product => (origin as ItemAvailableQuantityProvider).product;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
