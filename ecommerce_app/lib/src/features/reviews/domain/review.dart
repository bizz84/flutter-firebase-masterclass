import 'package:equatable/equatable.dart';

/// Product review data
class Review extends Equatable {
  const Review({
    required this.rating,
    required this.comment,
    required this.date,
  });
  final double rating; // from 1 to 5
  final String comment;
  final DateTime date;

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      rating: map['rating']?.toDouble() ?? 0.0,
      comment: map['comment'] ?? '',
      date: DateTime.parse(map['date']),
    );
  }

  Map<String, dynamic> toMap() => {
        'rating': rating,
        'comment': comment,
        // * When parsing from Firestore, we should use a serverTimestamp:
        // * https://github.com/bizz84/flutter-tips-and-tricks/blob/main/tips/0089-server-timestamp/index.md
        'date': date.toIso8601String(),
      };

  @override
  List<Object?> get props => [rating, comment, date];

  @override
  bool? get stringify => true;
}
