import 'package:dartz/dartz.dart';
import 'package:flip_cart_demo/core/errors/failure.dart';
import 'package:flip_cart_demo/features/categories/domain/entities/category_entity.dart';
import 'package:flip_cart_demo/features/categories/domain/repository/category_repository_impl.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<Either<Failure, List<CategoryEntity>>> call() {
    return repository.getCategories();
  }
}
