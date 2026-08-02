import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flip_cart_demo/core/connection/network_info.dart';
import 'package:flip_cart_demo/core/databases/api/dio_consumer.dart';
import 'package:flip_cart_demo/core/databases/cache/cache_helper.dart';
import 'package:flip_cart_demo/core/params/params.dart';
import 'package:flip_cart_demo/features/user/data/datasources/user_local_data_source.dart';
import 'package:flip_cart_demo/features/user/data/datasources/user_remote_data_source.dart';
import 'package:flip_cart_demo/features/user/data/repositories/user_repository_impl.dart';
import 'package:flip_cart_demo/features/user/domain/usecases/get_user.dart';
import 'package:flip_cart_demo/features/user/presentation/cubit/user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  eitherFailureOrUser(int id) async {
    emit(GetUserLoading());
    final failureOrUser = await GetUser(
      repository: UserRepositoryImpl(
          remoteDataSource: UserRemoteDataSource(api: DioConsumer(dio: Dio())),
          localDataSource: UserLocalDataSource(cache: CacheHelper()),
          networkInfo: NetworkInfoImpl(DataConnectionChecker())),
    ).call(
      params: UserParams(
        id: id.toString(),
      ),
    );

    failureOrUser.fold(
      (failure) => emit(GetUserFailure(errMessage: failure.errMessage)),
      (user) => emit(GetUserSuccessfully(user: user)),
    );
  }
}
