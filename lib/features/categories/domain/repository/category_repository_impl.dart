import 'package:dartz/dartz.dart';
import 'package:flip_cart_demo/core/errors/failure.dart';
import 'package:flip_cart_demo/features/categories/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
