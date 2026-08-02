import 'package:flip_cart_demo/features/dashboard/data/api_constants/response_params.dart';
import 'package:flip_cart_demo/features/dashboard/data/model/dimention_model.dart';
import 'package:flip_cart_demo/features/dashboard/data/model/meta_model.dart';
import 'package:flip_cart_demo/features/dashboard/data/model/review_model.dart';
import 'package:flip_cart_demo/features/dashboard/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.discountPercentage,
    required super.rating,
    required super.stock,
    required super.brand,
    required super.sku,
    required super.weight,
    required super.dimensions,
    required super.warrantyInformation,
    required super.shippingInformation,
    required super.availabilityStatus,
    required super.reviews,
    required super.returnPolicy,
    required super.minimumOrderQuantity,
    required super.meta,
    required super.images,
    required super.thumbnail,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[ResponseParams.id],
      title: json[ResponseParams.title] ?? '',
      description: json[ResponseParams.description] ?? '',
      category: json[ResponseParams.category] ?? '',
      price: (json[ResponseParams.price] ?? 0).toDouble(),
      discountPercentage:
          (json[ResponseParams.discountPercentage] ?? 0).toDouble(),
      rating: (json[ResponseParams.rating] ?? 0).toDouble(),
      stock: json[ResponseParams.stock] ?? 0,
      brand: json[ResponseParams.brand] ?? '',
      sku: json[ResponseParams.sku] ?? '',
      weight: json[ResponseParams.weight] ?? 0,
      dimensions: DimensionModel.fromJson(json[ResponseParams.dimensions]),
      warrantyInformation: json[ResponseParams.warrantyInformation] ?? '',
      shippingInformation: json[ResponseParams.shippingInformation] ?? '',
      availabilityStatus: json[ResponseParams.availabilityStatus] ?? '',
      reviews: (json[ResponseParams.reviews] as List)
          .map((e) => ReviewModel.fromJson(e))
          .toList(),
      returnPolicy: json[ResponseParams.returnPolicy] ?? '',
      minimumOrderQuantity: json[ResponseParams.minimumOrderQuantity] ?? 0,
      meta: MetaModel.fromJson(json[ResponseParams.meta]),
      images: List<String>.from(json[ResponseParams.images] ?? []),
      thumbnail: json[ResponseParams.thumbnail] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ResponseParams.id: id,
      ResponseParams.title: title,
      ResponseParams.description: description,
      ResponseParams.category: category,
      ResponseParams.price: price,
      ResponseParams.discountPercentage: discountPercentage,
      ResponseParams.rating: rating,
      ResponseParams.stock: stock,
      ResponseParams.brand: brand,
      ResponseParams.sku: sku,
      ResponseParams.weight: weight,
      ResponseParams.dimensions: (dimensions as DimensionModel).toJson(),
      ResponseParams.warrantyInformation: warrantyInformation,
      ResponseParams.shippingInformation: shippingInformation,
      ResponseParams.availabilityStatus: availabilityStatus,
      ResponseParams.reviews:
          reviews.map((r) => (r as ReviewModel).toJson()).toList(),
      ResponseParams.returnPolicy: returnPolicy,
      ResponseParams.minimumOrderQuantity: minimumOrderQuantity,
      ResponseParams.meta: (meta as MetaModel).toJson(),
      ResponseParams.images: images,
      ResponseParams.thumbnail: thumbnail,
    };
  }
}
