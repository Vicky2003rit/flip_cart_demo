import 'package:equatable/equatable.dart';
import 'package:flip_cart_demo/features/dashboard/domain/entities/product_entity.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

/// 🔹 Initial (no data yet)
class ProductInitial extends ProductState {}

/// 🔹 Loading state
class ProductLoading extends ProductState {}

/// 🔹 Loaded single product
class ProductLoaded extends ProductState {
  final ProductEntity product;

  const ProductLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

/// 🔹 Loaded multiple products
class ProductsLoaded extends ProductState {
  final List<ProductEntity> products;

  const ProductsLoaded({required this.products});

  @override
  List<Object?> get props => [products];
}

/// 🔹 Error state
class ProductError extends ProductState {
  final String message;

  const ProductError({required this.message});

  @override
  List<Object?> get props => [message];
}
