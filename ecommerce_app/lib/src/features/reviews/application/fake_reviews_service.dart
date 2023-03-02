import 'package:ecommerce_app/src/features/authentication/data/auth_repository.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:ecommerce_app/src/features/reviews/application/reviews_service.dart';
import 'package:ecommerce_app/src/features/reviews/data/reviews_repository.dart';
import 'package:ecommerce_app/src/features/reviews/domain/review.dart';
import 'package:ecommerce_app/src/localization/string_hardcoded.dart';

class FakeReviewsService implements ReviewsService {
  const FakeReviewsService({
    required this.fakeProductsRepository,
    required this.authRepository,
    required this.reviewsRepository,
  });
  // * since this is a "fake" reviews service, it relies on some methods that
  // * are only implemented in the [FakeProductsRepository], but not on the
  // * [ProductsRepository] base class
  final FakeProductsRepository fakeProductsRepository;
  final AuthRepository authRepository;
  final ReviewsRepository reviewsRepository;

  @override
  Future<void> submitReview({
    required ProductID productId,
    required Review review,
  }) async {
    final user = authRepository.currentUser;
    // * we should only call this method when the user is signed in
    assert(user != null);
    if (user == null) {
      throw AssertionError(
          'Can\'t submit a review if the user is not signed in'.hardcoded);
    }
    await reviewsRepository.setReview(
      productId: productId,
      uid: user.uid,
      review: review,
    );
    // * Note: this should be done on the backend
    // * At this stage the review is already submitted
    // * and we don't need to await for the product rating to also be updated
    _updateProductRating(productId);
  }

  Future<void> _updateProductRating(ProductID productId) async {
    final reviews = await reviewsRepository.fetchReviews(productId);
    final avgRating = _avgReviewScore(reviews);
    final product = fakeProductsRepository.getProduct(productId);
    if (product == null) {
      throw StateError('Product not found with id: $productId.'.hardcoded);
    }
    final updated = product.copyWith(
      avgRating: avgRating,
      numRatings: reviews.length,
    );
    await fakeProductsRepository.setProduct(updated);
  }

  double _avgReviewScore(List<Review> reviews) {
    if (reviews.isNotEmpty) {
      var total = 0.0;
      for (var review in reviews) {
        total += review.rating;
      }
      return total / reviews.length;
    } else {
      return 0.0;
    }
  }
}
