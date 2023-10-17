// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsRepositoryHash() =>
    r'6bb9aac84882ffe94981da5617a35df0343457a6';

/// See also [productsRepository].
@ProviderFor(productsRepository)
final productsRepositoryProvider = Provider<ProductsRepository>.internal(
  productsRepository,
  name: r'productsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsRepositoryRef = ProviderRef<ProductsRepository>;
String _$productsListStreamHash() =>
    r'22462209e383d9cb6a76936536ec6a6993ce872a';

/// See also [productsListStream].
@ProviderFor(productsListStream)
final productsListStreamProvider =
    AutoDisposeStreamProvider<List<Product>>.internal(
  productsListStream,
  name: r'productsListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsListStreamRef = AutoDisposeStreamProviderRef<List<Product>>;
String _$productsListFutureHash() =>
    r'742610200192d5593bc85a891d018f70898e048a';

/// See also [productsListFuture].
@ProviderFor(productsListFuture)
final productsListFutureProvider =
    AutoDisposeFutureProvider<List<Product>>.internal(
  productsListFuture,
  name: r'productsListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsListFutureRef = AutoDisposeFutureProviderRef<List<Product>>;
String _$productStreamHash() => r'a1b468bcbc42b7c8e9a8989f913d1582c50af9aa';

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

/// See also [productStream].
@ProviderFor(productStream)
const productStreamProvider = ProductStreamFamily();

/// See also [productStream].
class ProductStreamFamily extends Family<AsyncValue<Product?>> {
  /// See also [productStream].
  const ProductStreamFamily();

  /// See also [productStream].
  ProductStreamProvider call(
    String id,
  ) {
    return ProductStreamProvider(
      id,
    );
  }

  @override
  ProductStreamProvider getProviderOverride(
    covariant ProductStreamProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'productStreamProvider';
}

/// See also [productStream].
class ProductStreamProvider extends AutoDisposeStreamProvider<Product?> {
  /// See also [productStream].
  ProductStreamProvider(
    String id,
  ) : this._internal(
          (ref) => productStream(
            ref as ProductStreamRef,
            id,
          ),
          from: productStreamProvider,
          name: r'productStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productStreamHash,
          dependencies: ProductStreamFamily._dependencies,
          allTransitiveDependencies:
              ProductStreamFamily._allTransitiveDependencies,
          id: id,
        );

  ProductStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Product?> Function(ProductStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductStreamProvider._internal(
        (ref) => create(ref as ProductStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Product?> createElement() {
    return _ProductStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductStreamProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductStreamRef on AutoDisposeStreamProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductStreamProviderElement
    extends AutoDisposeStreamProviderElement<Product?> with ProductStreamRef {
  _ProductStreamProviderElement(super.provider);

  @override
  String get id => (origin as ProductStreamProvider).id;
}

String _$productFutureHash() => r'59e38e74159692b0215458b7adf2d9594ac460bc';

/// See also [productFuture].
@ProviderFor(productFuture)
const productFutureProvider = ProductFutureFamily();

/// See also [productFuture].
class ProductFutureFamily extends Family<AsyncValue<Product?>> {
  /// See also [productFuture].
  const ProductFutureFamily();

  /// See also [productFuture].
  ProductFutureProvider call(
    String id,
  ) {
    return ProductFutureProvider(
      id,
    );
  }

  @override
  ProductFutureProvider getProviderOverride(
    covariant ProductFutureProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'productFutureProvider';
}

/// See also [productFuture].
class ProductFutureProvider extends AutoDisposeFutureProvider<Product?> {
  /// See also [productFuture].
  ProductFutureProvider(
    String id,
  ) : this._internal(
          (ref) => productFuture(
            ref as ProductFutureRef,
            id,
          ),
          from: productFutureProvider,
          name: r'productFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productFutureHash,
          dependencies: ProductFutureFamily._dependencies,
          allTransitiveDependencies:
              ProductFutureFamily._allTransitiveDependencies,
          id: id,
        );

  ProductFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<Product?> Function(ProductFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductFutureProvider._internal(
        (ref) => create(ref as ProductFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Product?> createElement() {
    return _ProductFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductFutureProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductFutureRef on AutoDisposeFutureProviderRef<Product?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductFutureProviderElement
    extends AutoDisposeFutureProviderElement<Product?> with ProductFutureRef {
  _ProductFutureProviderElement(super.provider);

  @override
  String get id => (origin as ProductFutureProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
