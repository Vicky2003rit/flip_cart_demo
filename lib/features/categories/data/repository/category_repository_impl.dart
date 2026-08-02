import 'package:dartz/dartz.dart';

import 'package:flip_cart_demo/core/errors/failure.dart';
import 'package:flip_cart_demo/core/errors/expentions.dart';

import 'package:flip_cart_demo/core/connection/network_info.dart';
import 'package:flip_cart_demo/features/categories/data/datasource/category_remote_data_source.dart';
import 'package:flip_cart_demo/features/categories/domain/entities/category_entity.dart';
import 'package:flip_cart_demo/features/categories/domain/repository/category_repository_impl.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remote;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final categories = await remote.getCategories();
        return Right(categories);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }
}
