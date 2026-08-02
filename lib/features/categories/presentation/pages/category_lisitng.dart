import 'package:flip_cart_demo/features/categories/presentation/bloc/category_bloc.dart';
import 'package:flip_cart_demo/features/categories/presentation/bloc/category_event.dart';
import 'package:flip_cart_demo/features/categories/presentation/bloc/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flip_cart_demo/features/categories/presentation/pages/category_card.dart';

class CategoryListWidget extends StatefulWidget {
  const CategoryListWidget({super.key});

  @override
  State<CategoryListWidget> createState() => _CategoryListWidgetState();
}

class _CategoryListWidgetState extends State<CategoryListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(GetCategoriesEvent()); // 🔥 correct place
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      buildWhen: (previous, current) =>
          current is CategoryLoading ||
          current is CategoryError ||
          current is CategoryLoaded ||
          current is CategoryInitial,
      builder: (context, state) {
        // 🔄 Loading UI
        if (state is CategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // ❌ Error UI
        if (state is CategoryError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          );
        }

        // 🟢 Loaded Successfully
        if (state is CategoryLoaded) {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            // padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.categories.length,
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: .0),
                child: CategoryCard(
                  category: category,
                  onTap: () {
                    // 🔥 Open product list for selected category
                    // Navigator.push(context, MaterialPageRoute(
                    //   builder: (_) => CategoryProductsPage(slug: category.slug),
                    // ));
                  },
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 20);
            },
          );
        }

        // Default empty state
        return const Center(child: Text("No categories found"));
      },
    );
  }
}
