import 'package:flutter/material.dart';
import '../../domain/entities/category_entity.dart';

class CategoryCard extends StatelessWidget {
  final CategoryEntity category;
  final VoidCallback? onTap;

  const CategoryCard({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 150,
      // Material must be an ancestor of InkWell
      child: Material(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(8),
        // elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Column(
            // spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // ✅ important

            children: [
              // Image area
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(8)),
                  child: SizedBox(
                    height: 75,
                    width: double.infinity,
                    child: Image.network(
                      category.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (ctx, err, st) =>
                          const Center(child: Icon(Icons.image_not_supported)),
                      loadingBuilder: (ctx, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2));
                      },
                    ),
                  ),
                ),
              ),

              // Title
              Text(
                category.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
