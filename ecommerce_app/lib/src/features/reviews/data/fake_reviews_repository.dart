import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/data/reviews_repository.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/utils/delay.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';

/// A repository used to store all user reviews for all products
class FakeReviewsRepository implements ReviewsRepository {
  FakeReviewsRepository({this.addDelay = true});
  final bool addDelay;

  /// Reviews Store
  /// key: [ProductID]
  /// value: map of [Review] values for each user ID
  final _reviews = InMemoryStore<Map<ProductID, Map<String, Review>>>({});

  /// Single review for a given product given by a specific user
  /// Emits non-null values if the user has reviewed the product
  @override
  Stream<Review?> watchUserReview(ProductID id, String uid) {
    return _reviews.stream.map((reviewsData) {
      // access nested maps by productId, then uid
      return reviewsData[id]?[uid];
    });
  }

  /// Single review for a given product given by a specific user
  /// Returns a non-null value if the user has reviewed the product
  @override
  Future<Review?> fetchUserReview(ProductID id, String uid) async {
    // access nested maps by productId, then uid
    return Future.value(_reviews.value[id]?[uid]);
  }

  /// All reviews for a given product from all users
  @override
  Stream<List<Review>> watchReviews(ProductID id) {
    return _reviews.stream.map((reviewsData) {
      // access nested maps by productId, then uid
      final reviews = reviewsData[id];
      if (reviews == null) {
        return [];
      } else {
        return reviews.values.toList();
      }
    });
  }

  /// All reviews for a given product from all users
  @override
  Future<List<Review>> fetchReviews(ProductID id) {
    // access nested maps by productId, then uid
    final reviews = _reviews.value[id];
    if (reviews == null) {
      return Future.value([]);
    } else {
      return Future.value(reviews.values.toList());
    }
  }

  /// Submit a new review or update an existing review for a given product
  /// - [productId] is the product identifier.
  /// - [uid] is the identifier of the user who is leaving the review
  /// - [review] is the review information to be written
  @override
  Future<void> setReview({
    required ProductID productId,
    required String uid,
    required Review review,
  }) async {
    await delay(addDelay);
    final allReviews = _reviews.value;
    final reviews = allReviews[productId];
    if (reviews != null) {
      // reviews already exist: set the new review for the given uid
      reviews[uid] = review;
    } else {
      // reviews do not exist: create a new map with the new review
      allReviews[productId] = {uid: review};
    }
    _reviews.value = allReviews;
  }
}
