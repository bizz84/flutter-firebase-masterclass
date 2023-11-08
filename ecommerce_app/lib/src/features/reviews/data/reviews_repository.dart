import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reviews_repository.g.dart';

class ReviewsRepository {
  const ReviewsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  /// Single review for a given product given by a specific user
  /// Emits non-null values if the user has reviewed the product
  Stream<Review?> watchUserReview(ProductID id, UserID uid) {
    // TODO: Implement
    return Stream.value(null);
  }

  /// Single review for a given product given by a specific user
  /// Returns a non-null value if the user has reviewed the product
  Future<Review?> fetchUserReview(ProductID id, UserID uid) {
    // TODO: Implement
    return Future.value(null);
  }

  /// All reviews for a given product from all users
  Stream<List<Review>> watchReviews(ProductID id) {
    // TODO: Implement
    return Stream.value([]);
  }

  /// All reviews for a given product from all users
  Future<List<Review>> fetchReviews(ProductID id) {
    // TODO: Implement
    return Future.value([]);
  }

  /// Submit a new review or update an existing review for a given product
  /// - [productId] is the product identifier.
  /// - [uid] is the identifier of the user who is leaving the review
  /// - [review] is the review information to be written
  Future<void> setReview({
    required ProductID productId,
    required UserID uid,
    required Review review,
  }) {
    // TODO: Implement
    throw UnimplementedError();
  }
}

@Riverpod(keepAlive: true)
ReviewsRepository reviewsRepository(ReviewsRepositoryRef ref) {
  return ReviewsRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Review>> productReviews(
    ProductReviewsRef ref, ProductID productId) {
  return ref.watch(reviewsRepositoryProvider).watchReviews(productId);
}
