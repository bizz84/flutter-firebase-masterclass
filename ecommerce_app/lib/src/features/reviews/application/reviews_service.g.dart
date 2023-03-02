// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewsServiceHash() => r'b321038da884120210faac9a6506f8f1215e3391';

/// See also [reviewsService].
@ProviderFor(reviewsService)
final reviewsServiceProvider = AutoDisposeProvider<ReviewsService>.internal(
  reviewsService,
  name: r'reviewsServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reviewsServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ReviewsServiceRef = AutoDisposeProviderRef<ReviewsService>;
String _$userReviewFutureHash() => r'98a78f997bf77c9b2cb80da2ddb23242c933893f';

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

typedef UserReviewFutureRef = AutoDisposeFutureProviderRef<Review?>;

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewFuture].
@ProviderFor(userReviewFuture)
const userReviewFutureProvider = UserReviewFutureFamily();

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewFuture].
class UserReviewFutureFamily extends Family<AsyncValue<Review?>> {
  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewFuture].
  const UserReviewFutureFamily();

  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewFuture].
  UserReviewFutureProvider call(
    String productId,
  ) {
    return UserReviewFutureProvider(
      productId,
    );
  }

  @override
  UserReviewFutureProvider getProviderOverride(
    covariant UserReviewFutureProvider provider,
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
  String? get name => r'userReviewFutureProvider';
}

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewFuture].
class UserReviewFutureProvider extends AutoDisposeFutureProvider<Review?> {
  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewFuture].
  UserReviewFutureProvider(
    this.productId,
  ) : super.internal(
          (ref) => userReviewFuture(
            ref,
            productId,
          ),
          from: userReviewFutureProvider,
          name: r'userReviewFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userReviewFutureHash,
          dependencies: UserReviewFutureFamily._dependencies,
          allTransitiveDependencies:
              UserReviewFutureFamily._allTransitiveDependencies,
        );

  final String productId;

  @override
  bool operator ==(Object other) {
    return other is UserReviewFutureProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$userReviewStreamHash() => r'929c44de465ca195cb9f12203943b7bb4bdfda26';
typedef UserReviewStreamRef = AutoDisposeStreamProviderRef<Review?>;

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewStream].
@ProviderFor(userReviewStream)
const userReviewStreamProvider = UserReviewStreamFamily();

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewStream].
class UserReviewStreamFamily extends Family<AsyncValue<Review?>> {
  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewStream].
  const UserReviewStreamFamily();

  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewStream].
  UserReviewStreamProvider call(
    String productId,
  ) {
    return UserReviewStreamProvider(
      productId,
    );
  }

  @override
  UserReviewStreamProvider getProviderOverride(
    covariant UserReviewStreamProvider provider,
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
  String? get name => r'userReviewStreamProvider';
}

/// Check if a product was previously reviewed by the user
///
/// Copied from [userReviewStream].
class UserReviewStreamProvider extends AutoDisposeStreamProvider<Review?> {
  /// Check if a product was previously reviewed by the user
  ///
  /// Copied from [userReviewStream].
  UserReviewStreamProvider(
    this.productId,
  ) : super.internal(
          (ref) => userReviewStream(
            ref,
            productId,
          ),
          from: userReviewStreamProvider,
          name: r'userReviewStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userReviewStreamHash,
          dependencies: UserReviewStreamFamily._dependencies,
          allTransitiveDependencies:
              UserReviewStreamFamily._allTransitiveDependencies,
        );

  final String productId;

  @override
  bool operator ==(Object other) {
    return other is UserReviewStreamProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
