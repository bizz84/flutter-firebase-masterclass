import 'package:equatable/equatable.dart';

/// * The product identifier is an important concept and can have its own type.
typedef ProductID = String;

/// Class representing a product.
class Product extends Equatable {
  const Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.availableQuantity,
    this.avgRating = 0,
    this.numRatings = 0,
  });

  /// Unique product id
  final ProductID id;
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int availableQuantity;
  final double avgRating;
  final int numRatings;

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      imageUrl: map['imageUrl'] as String,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      availableQuantity: map['availableQuantity']?.toInt() ?? 0,
      avgRating: map['avgRating']?.toDouble() ?? 0.0,
      numRatings: map['numRatings']?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
        'price': price,
        'availableQuantity': availableQuantity,
        'avgRating': avgRating,
        'numRatings': numRatings,
      };

  Product copyWith({
    ProductID? id,
    String? imageUrl,
    String? title,
    String? description,
    double? price,
    int? availableQuantity,
    double? avgRating,
    int? numRatings,
  }) {
    return Product(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      availableQuantity: availableQuantity ?? this.availableQuantity,
      avgRating: avgRating ?? this.avgRating,
      numRatings: numRatings ?? this.numRatings,
    );
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        title,
        description,
        price,
        availableQuantity,
        avgRating,
        numRatings
      ];

  @override
  bool? get stringify => true;
}
