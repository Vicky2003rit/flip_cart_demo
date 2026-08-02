import 'package:flip_cart_demo/core/databases/api/api_consumer.dart';
import 'package:flip_cart_demo/core/databases/api/end_points.dart';
import 'package:flip_cart_demo/core/params/params.dart';
import 'package:flip_cart_demo/features/dashboard/data/model/product_model.dart';
import 'package:flip_cart_demo/features/dashboard/data/params/product_params.dart';

class ProductRemoteDataSource {
  final ApiConsumer api;

  ProductRemoteDataSource({required this.api});

  /// 🔹 Fetch a single product by ID
  Future<ProductModel> getProduct(ProductParams params) async {
    final response = await api.get("${EndPoints.products}/${params.id}");
    return ProductModel.fromJson(response);
  }

  /// 🔹 Fetch multiple products (supports pagination)
  Future<List<ProductModel>> getAllProducts(ProductListParams params) async {
    final response = await api.get(
      EndPoints.products,
      queryParameters: {
        "limit": params.limit,
        "skip": params.skip,
      },
    );

    final List<dynamic> productsJson = response["products"] ?? [];
    return productsJson.map((json) => ProductModel.fromJson(json)).toList();
  }
}
