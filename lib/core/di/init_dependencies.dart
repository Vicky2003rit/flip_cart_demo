// import 'package:flutter/foundation.dart'; // for kIsWeb
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:data_connection_checker_tv/data_connection_checker.dart';

// import 'package:flip_cart_demo/core/connection/network_info.dart';
// import 'package:flip_cart_demo/core/databases/api/api_consumer.dart';
// import 'package:flip_cart_demo/core/databases/api/dio_consumer.dart';
// import 'package:flip_cart_demo/features/dashboard/data/datasource/product_remote_data_source.dart';
// import 'package:flip_cart_demo/features/dashboard/data/repository/product_repository_impl.dart';
// import 'package:flip_cart_demo/features/dashboard/domain/repository/product_repository.dart';
// import 'package:flip_cart_demo/features/dashboard/domain/usecase/get_all_product_use_case.dart';
// import 'package:flip_cart_demo/features/dashboard/domain/usecase/get_product_use_case.dart';

// final sl = GetIt.instance;

// Future<void> initDependencies() async {
//   //! Core
//   sl.registerLazySingleton<Dio>(() => Dio());
//   sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

//   //! ✅ Network Info (Web-safe setup)
//   if (kIsWeb) {
//     // Web doesn’t support socket lookup
//     sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
//   } else {
//     sl.registerLazySingleton(() => DataConnectionChecker());
//     sl.registerLazySingleton<NetworkInfo>(
//       () => NetworkInfoImpl(sl<DataConnectionChecker>()),
//     );
//   }

//   //! Data Sources
//   sl.registerLazySingleton<ProductRemoteDataSource>(
//     () => ProductRemoteDataSource(api: sl()),
//   );

//   //! Repository
//   sl.registerLazySingleton<ProductRepository>(
//     () => ProductRepositoryImpl(
//       remoteDataSource: sl(),
//       networkInfo: sl(),
//     ),
//   );

//   //! Use Cases
//   sl.registerLazySingleton(() => GetProduct(repository: sl()));
//   sl.registerLazySingleton(() => GetAllProducts(repository: sl()));

//   print('✅ Dependencies registered successfully!');
// }
import 'package:flip_cart_demo/features/categories/data/datasource/category_remote_data_source.dart';
import 'package:flip_cart_demo/features/categories/data/repository/category_repository_impl.dart';
import 'package:flip_cart_demo/features/categories/domain/repository/category_repository_impl.dart';
import 'package:flip_cart_demo/features/categories/domain/usecase/get_categories_use_case.dart';
import 'package:flip_cart_demo/features/categories/presentation/bloc/category_bloc.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:flip_cart_demo/core/connection/network_info.dart';
import 'package:flip_cart_demo/core/databases/api/api_consumer.dart';
import 'package:flip_cart_demo/core/databases/api/dio_consumer.dart';

// ---------------- PRODUCT ----------------
import 'package:flip_cart_demo/features/dashboard/data/datasource/product_remote_data_source.dart';
import 'package:flip_cart_demo/features/dashboard/data/repository/product_repository_impl.dart';
import 'package:flip_cart_demo/features/dashboard/domain/repository/product_repository.dart';
import 'package:flip_cart_demo/features/dashboard/domain/usecase/get_all_product_use_case.dart';
import 'package:flip_cart_demo/features/dashboard/domain/usecase/get_product_use_case.dart';

// ---------------- CATEGORY ----------------

final sl = GetIt.instance;

Future<void> initDependencies() async {
  //! ---------------- CORE ----------------
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));

  if (kIsWeb) {
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  } else {
    sl.registerLazySingleton(() => DataConnectionChecker());
    sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(sl<DataConnectionChecker>()),
    );
  }

  //! -------------- PRODUCT FEATURE --------------
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(api: sl()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetProduct(repository: sl()));
  sl.registerLazySingleton(() => GetAllProducts(repository: sl()));

  //! -------------- CATEGORY FEATURE --------------
  sl.registerLazySingleton<CategoryRemoteDataSource>(
    () => CategoryRemoteDataSourceImpl(api: sl()),
  );

  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(
      remote: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetCategoriesUseCase(repository: sl()));
  sl.registerFactory(() =>
      CategoryBloc(getCategoriesUseCase: sl())); // ⚡ factory for fresh bloc
}
