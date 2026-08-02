import 'package:dartz/dartz.dart';
import 'package:flip_cart_demo/core/errors/failure.dart';
import 'package:flip_cart_demo/core/params/params.dart';
import 'package:flip_cart_demo/features/dashboard/data/params/product_params.dart';
import 'package:flip_cart_demo/features/dashboard/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, ProductEntity>> getProduct({
    required ProductParams params,
  });

  Future<Either<Failure, List<ProductEntity>>> getAllProducts({
    required ProductListParams params,
  });
}
