// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewsRepositoryHash() => r'b29b6afc5319899c563deb41116d664b6fda1994';

/// See also [reviewsRepository].
@ProviderFor(reviewsRepository)
final reviewsRepositoryProvider = Provider<ReviewsRepository>.internal(
  reviewsRepository,
  name: r'reviewsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReviewsRepositoryRef = ProviderRef<ReviewsRepository>;
String _$productReviewsHash() => r'7fafee2f2b462fbd7617166d5d8b9e44f4106551';

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

typedef ProductReviewsRef = AutoDisposeStreamProviderRef<List<Review>>;

/// See also [productReviews].
@ProviderFor(productReviews)
const productReviewsProvider = ProductReviewsFamily();

/// See also [productReviews].
class ProductReviewsFamily extends Family<AsyncValue<List<Review>>> {
  /// See also [productReviews].
  const ProductReviewsFamily();

  /// See also [productReviews].
  ProductReviewsProvider call(
    String productId,
  ) {
    return ProductReviewsProvider(
      productId,
    );
  }

  @override
  ProductReviewsProvider getProviderOverride(
    covariant ProductReviewsProvider provider,
  ) {
    return call(
      provider.productId,
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
  String? get name => r'productReviewsProvider';
}

/// See also [productReviews].
class ProductReviewsProvider extends AutoDisposeStreamProvider<List<Review>> {
  /// See also [productReviews].
  ProductReviewsProvider(
    this.productId,
  ) : super.internal(
          (ref) => productReviews(
            ref,
            productId,
          ),
          from: productReviewsProvider,
          name: r'productReviewsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$productReviewsHash,
          dependencies: ProductReviewsFamily._dependencies,
          allTransitiveDependencies:
              ProductReviewsFamily._allTransitiveDependencies,
        );

  final String productId;

  @override
  bool operator ==(Object other) {
    return other is ProductReviewsProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
