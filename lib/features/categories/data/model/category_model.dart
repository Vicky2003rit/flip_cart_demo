import 'package:flip_cart_demo/features/categories/data/datasource/category_images.dart';
import 'package:flip_cart_demo/features/categories/domain/entities/category_entity.dart';

class CategoryModel extends CategoryEntity {
  CategoryModel({
    required super.slug,
    required super.name,
    required super.url,
    required super.imageUrl,
  });

  /// Convert API JSON → CategoryModel → CategoryEntity
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      slug: json["slug"] ?? "",
      name: json["name"] ?? "",
      url: json["url"] ?? "",
      imageUrl: categoryImages[json["slug"]] ??
          defaultCategoryImage, // 🔥 image mapping
    );
  }

  /// Convert Model back to JSON (Optional)
  Map<String, dynamic> toJson() {
    return {"slug": slug, "name": name, "url": url, "image": imageUrl};
  }
}
