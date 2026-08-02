

import 'package:flip_cart_demo/features/dashboard/data/api_constants/response_params.dart';
import 'package:flip_cart_demo/features/dashboard/domain/entities/dimention_entity.dart';

class DimensionModel extends DimensionEntity {
  const DimensionModel({
    required super.width,
    required super.height,
    required super.depth,
  });

  factory DimensionModel.fromJson(Map<String, dynamic> json) {
    return DimensionModel(
      width: (json[ResponseParams.width] ?? 0).toDouble(),
      height: (json[ResponseParams.height] ?? 0).toDouble(),
      depth: (json[ResponseParams.depth] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ResponseParams.width: width,
      ResponseParams.height: height,
      ResponseParams.depth: depth,
    };
  }
}
