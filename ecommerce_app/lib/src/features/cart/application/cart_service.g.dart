// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartServiceHash() => r'3cce4494cab5efe7a277c7c1ee4ca850839745e6';

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

typedef CartServiceRef = AutoDisposeProviderRef<CartService>;
String _$cartHash() => r'93c5bc4fd89471ade34d73d50a3aff12d52a7655';

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

typedef CartRef = AutoDisposeStreamProviderRef<Cart>;
String _$cartItemsCountHash() => r'7801d6af4f77311621f7628b30b2dd656c410fae';

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

typedef CartItemsCountRef = AutoDisposeProviderRef<int>;
String _$cartTotalHash() => r'620fa13b324b41b44713aede70cb19b607f395cb';

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

typedef CartTotalRef = AutoDisposeProviderRef<double>;
String _$itemAvailableQuantityHash() =>
    r'bf8ea212feaa0322b97753a9a241cbd1da278c2f';

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

typedef ItemAvailableQuantityRef = AutoDisposeProviderRef<int>;

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
    this.product,
  ) : super.internal(
          (ref) => itemAvailableQuantity(
            ref,
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
        );

  final Product product;

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
