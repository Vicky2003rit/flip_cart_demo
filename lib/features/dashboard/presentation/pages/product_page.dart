// import 'package:flip_cart_demo/features/dashboard/data/params/product_params.dart';
// import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_bloc.dart';
// import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_event.dart';
// import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// class ProductPage extends StatelessWidget {
//   const ProductPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("Products Test Page"),
//       //   centerTitle: true,
//       //   backgroundColor: Colors.blueAccent,
//       // ),
//       body: BlocConsumer<ProductBloc, ProductState>(
//         listener: (context, state) {
//           if (state is ProductError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.message)),
//             );
//           }
//         },
//         builder: (context, state) {
//           if (state is ProductInitial) {
//             // Trigger event automatically once UI builds
//             context.read<ProductBloc>().add(
//                   GetAllProductsEvent(
//                     params: ProductListParams(limit: 10, skip: 0),
//                   ),
//                 );
//             return const Center(child: Text("Loading products..."));
//           } else if (state is ProductLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is ProductsLoaded) {
//             return ListView.builder(
//               itemCount: state.products.length,
//               itemBuilder: (context, index) {
//                 final product = state.products[index];
//                 return Card(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   elevation: 2,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   child: ListTile(
//                     leading: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Image.network(
//                         product.thumbnail,
//                         fit: BoxFit.cover,
//                         width: 60,
//                         height: 60,
//                         errorBuilder: (_, __, ___) =>
//                             const Icon(Icons.image_not_supported),
//                       ),
//                     ),
//                     title: Text(
//                       product.title,
//                       style: const TextStyle(
//                           fontWeight: FontWeight.bold, fontSize: 14),
//                     ),
//                     subtitle: Text(
//                       product.description,
//                       maxLines: 4,
//                       overflow: TextOverflow.visible,
//                       style: const TextStyle(fontSize: 12),
//                     ),
//                     trailing: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "₹${product.price.toString()}",
//                           style: const TextStyle(
//                               color: Colors.green,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 13),
//                         ),
//                         Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             const Icon(Icons.star,
//                                 color: Colors.orange, size: 14),
//                             Text(
//                               product.rating.toStringAsFixed(1),
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           } else if (state is ProductError) {
//             return Center(
//                 child: Text(
//               "Error: ${state.message}",
//               style: const TextStyle(color: Colors.red),
//             ));
//           } else {
//             return const Center(child: Text("Unexpected state"));
//           }
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           context.read<ProductBloc>().add(
//                 GetAllProductsEvent(
//                   params: ProductListParams(limit: 10, skip: 0),
//                 ),
//               );
//         },
//         child: const Icon(Icons.refresh),
//       ),
//     );
//   }
// }
import 'package:flip_cart_demo/features/dashboard/data/params/product_params.dart';
import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_bloc.dart';
import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_event.dart';
import 'package:flip_cart_demo/features/dashboard/presentation/bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ProductInitial) {
          context.read<ProductBloc>().add(
                GetAllProductsEvent(
                  params: ProductListParams(limit: 10, skip: 0),
                ),
              );
          return const Center(child: Text("Loading products..."));
        } else if (state is ProductLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProductsLoaded) {
          return ListView.builder(
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                  title: Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    product.description,
                    maxLines: 4,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "₹${product.price}",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 14,
                          ),
                          Text(
                            product.rating.toStringAsFixed(1),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state is ProductError) {
          return Center(
            child: Text(
              "Error: ${state.message}",
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const Center(child: Text("Unexpected state"));
      },
    );
  }
}
