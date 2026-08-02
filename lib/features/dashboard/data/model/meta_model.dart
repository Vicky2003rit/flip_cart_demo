

import 'package:flip_cart_demo/features/dashboard/data/api_constants/response_params.dart';
import 'package:flip_cart_demo/features/dashboard/domain/entities/meta_entity.dart';

class MetaModel extends MetaEntity {
  const MetaModel({
    required super.createdAt,
    required super.updatedAt,
    required super.barcode,
    required super.qrCode,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      createdAt: DateTime.tryParse(json[ResponseParams.createdAt] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json[ResponseParams.updatedAt] ?? '') ?? DateTime.now(),
      barcode: json[ResponseParams.barcode] ?? '',
      qrCode: json[ResponseParams.qrCode] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ResponseParams.createdAt: createdAt.toIso8601String(),
      ResponseParams.updatedAt: updatedAt.toIso8601String(),
      ResponseParams.barcode: barcode,
      ResponseParams.qrCode: qrCode,
    };
  }
}
