import 'package:dartz/dartz.dart';
import 'package:flip_cart_demo/core/connection/network_info.dart';
import 'package:flip_cart_demo/core/errors/expentions.dart';
import 'package:flip_cart_demo/core/errors/failure.dart';
import 'package:flip_cart_demo/core/params/params.dart';
import 'package:flip_cart_demo/features/dashboard/data/datasource/product_remote_data_source.dart';
import 'package:flip_cart_demo/features/dashboard/data/params/product_params.dart';
import 'package:flip_cart_demo/features/dashboard/domain/entities/product_entity.dart';
import 'package:flip_cart_demo/features/dashboard/domain/repository/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final NetworkInfo networkInfo;
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ProductEntity>> getProduct({
    required ProductParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteProduct = await remoteDataSource.getProduct(params);
        return Right(remoteProduct);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      } catch (e) {
        return Left(Failure(errMessage: e.toString()));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts({
    required ProductListParams params,
  }) async {
    if (await networkInfo.isConnected!) {
      try {
        final remoteProducts = await remoteDataSource.getAllProducts(params);
        return Right(remoteProducts);
      } on ServerException catch (e) {
        return Left(Failure(errMessage: e.errorModel.errorMessage));
      } catch (e) {
        return Left(Failure(errMessage: e.toString()));
      }
    } else {
      return Left(Failure(errMessage: "No Internet Connection"));
    }
  }
}
