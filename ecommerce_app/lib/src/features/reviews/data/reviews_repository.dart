import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reviews_repository.g.dart';

class ReviewsRepository {
  const ReviewsRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String reviewPath(ProductID id, UserID uid) =>
      'products/$id/reviews/$uid';
  static String reviewsPath(ProductID id) => 'products/$id/reviews';

  /// Single review for a given product given by a specific user
  /// Emits non-null values if the user has reviewed the product
  Stream<Review?> watchUserReview(ProductID id, UserID uid) {
    final ref = _reviewRef(id, uid);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  /// Single review for a given product given by a specific user
  /// Returns a non-null value if the user has reviewed the product
  Future<Review?> fetchUserReview(ProductID id, UserID uid) async {
    final ref = _reviewRef(id, uid);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  /// All reviews for a given product from all users
  Stream<List<Review>> watchReviews(ProductID id) {
    final ref = _reviewsRef(id);
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  /// All reviews for a given product from all users
  Future<List<Review>> fetchReviews(ProductID id) async {
    final ref = _reviewsRef(id);
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
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
    final ref = _reviewRef(productId, uid);
    return ref.set(review);
  }

  DocumentReference<Review?> _reviewRef(ProductID id, UserID uid) =>
      _firestore.doc(reviewPath(id, uid)).withConverter(
            fromFirestore: (doc, _) =>
                doc.exists ? Review.fromMap(doc.data()!) : null,
            toFirestore: (review, _) => review != null ? review.toMap() : {},
          );

  Query<Review> _reviewsRef(ProductID id) => _firestore
      .collection(reviewsPath(id))
      .orderBy('date', descending: true)
      .withConverter(
        fromFirestore: (doc, _) => Review.fromMap(doc.data()!),
        toFirestore: (review, _) => review.toMap(),
      );
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
