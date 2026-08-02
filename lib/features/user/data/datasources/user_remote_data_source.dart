import 'package:flip_cart_demo/core/databases/api/api_consumer.dart';
import 'package:flip_cart_demo/core/databases/api/end_points.dart';
import 'package:flip_cart_demo/core/params/params.dart';
import 'package:flip_cart_demo/features/user/data/models/user_model.dart';

class UserRemoteDataSource {
  final ApiConsumer api;

  UserRemoteDataSource({required this.api});
  Future<UserModel> getUser(UserParams params) async {
    final response = await api.get("${EndPoints.user}/${params.id}");
    return UserModel.fromJson(response);
  }
}
