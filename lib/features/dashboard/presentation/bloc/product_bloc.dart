import 'package:flip_cart_demo/features/dashboard/domain/usecase/get_all_product_use_case.dart';
import 'package:flip_cart_demo/features/dashboard/domain/usecase/get_product_use_case.dart';
import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_event.dart';
import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flip_cart_demo/core/di/init_dependencies.dart'; // ✅ access GetIt instance

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProduct _getProductUseCase = sl<GetProduct>();
  final GetAllProducts _getAllProductsUseCase = sl<GetAllProducts>();

  ProductBloc() : super(ProductInitial()) {
    on<GetProductEvent>(_onGetProduct);
    on<GetAllProductsEvent>(_onGetAllProducts);
  }

  Future<void> _onGetProduct(
      GetProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await _getProductUseCase(params: event.params);
    result.fold(
      (failure) => emit(ProductError(message: failure.errMessage)),
      (product) => emit(ProductLoaded(product: product)),
    );
  }

  Future<void> _onGetAllProducts(
      GetAllProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await _getAllProductsUseCase(params: event.params);
    result.fold(
      (failure) => emit(ProductError(message: failure.errMessage)),
      (products) => emit(ProductsLoaded(products: products)),
    );
  }
}
