

import 'package:flip_cart_demo/features/dashboard/data/api_constants/response_params.dart';
import 'package:flip_cart_demo/features/dashboard/domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.rating,
    required super.comment,
    required super.date,
    required super.reviewerName,
    required super.reviewerEmail,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json[ResponseParams.rating] ?? 0,
      comment: json[ResponseParams.comment] ?? '',
      date: DateTime.tryParse(json[ResponseParams.date] ?? '') ?? DateTime.now(),
      reviewerName: json[ResponseParams.reviewerName] ?? '',
      reviewerEmail: json[ResponseParams.reviewerEmail] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ResponseParams.rating: rating,
      ResponseParams.comment: comment,
      ResponseParams.date: date.toIso8601String(),
      ResponseParams.reviewerName: reviewerName,
      ResponseParams.reviewerEmail: reviewerEmail,
    };
  }
}
