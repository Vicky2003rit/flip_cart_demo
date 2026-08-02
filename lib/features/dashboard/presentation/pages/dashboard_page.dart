import 'package:flip_cart_demo/features/categories/presentation/pages/category_lisitng.dart';
import 'package:flip_cart_demo/features/dashboard/presentation/pages/product_page.dart';
import 'package:flutter/widgets.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: [
        // Expanded(child: Text("Header Section")),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: CategoryListWidget(),
            )),
        Expanded(flex: 4, child: ProductPage()),
      ],
    );
  }
}
