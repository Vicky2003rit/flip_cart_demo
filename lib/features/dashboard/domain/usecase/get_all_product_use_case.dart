import 'package:dartz/dartz.dart';
import 'package:flip_cart_demo/core/errors/failure.dart';
import 'package:flip_cart_demo/features/dashboard/data/params/product_params.dart';
import 'package:flip_cart_demo/features/dashboard/domain/entities/product_entity.dart';
import 'package:flip_cart_demo/features/dashboard/domain/repository/product_repository.dart';

class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts({required this.repository});

  Future<Either<Failure, List<ProductEntity>>> call(
      {required ProductListParams params}) {
    return repository.getAllProducts(params: params);
  }
}

