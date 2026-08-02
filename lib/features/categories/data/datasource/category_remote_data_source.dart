import 'package:flip_cart_demo/core/databases/api/api_consumer.dart';
import 'package:flip_cart_demo/features/categories/data/model/category_model.dart';
import 'package:flip_cart_demo/features/categories/domain/entities/category_entity.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryEntity>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final ApiConsumer api;

  CategoryRemoteDataSourceImpl({required this.api});

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final response = await api.get("https://dummyjson.com/products/categories");
    // final response = await api.get(EndPoints.categories);

    // response type: List<Map<String, dynamic>> (based on API you shared)
    final List<dynamic> data = response;

    return data.map((json) => CategoryModel.fromJson(json)).toList();
  }
}
