import 'package:equatable/equatable.dart';
import 'package:flip_cart_demo/features/dashboard/data/params/product_params.dart';
import 'package:flip_cart_demo/features/dashboard/domain/usecase/get_all_product_use_case.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

/// 🔹 Fetch a single product by ID
class GetProductEvent extends ProductEvent {
  final ProductParams params;

  const GetProductEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

/// 🔹 Fetch all products with pagination
class GetAllProductsEvent extends ProductEvent {
  final ProductListParams params;

  const GetAllProductsEvent({required this.params});

  @override
  List<Object?> get props => [params];
}
