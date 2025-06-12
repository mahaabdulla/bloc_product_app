import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/constant/route_name.dart';
import 'package:product_app/feature/cubits/favorite_cubit/favorite.dart';
import 'package:product_app/feature/cubits/products/product_cubit.dart';
import 'package:product_app/feature/model/product_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Available Products",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial || state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductSuccess) {
            final products = state.products;

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.7,
                        ),
                    itemCount: products.length,
                    itemBuilder: (ctx, index) {
                      final product = products[index];
                      final isFavorite = context
                          .watch<FavoriteCubit>()
                          .isFavorite(product);

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PRODUCT,
                            arguments: product.id,
                          );
                        },
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                    child: Image.network(
                                      product.image ?? '',
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                                height: 120,
                                                color: Colors.grey[300],
                                                child: const Center(
                                                  child: Icon(Icons.error),
                                                ),
                                              ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      icon: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:
                                            isFavorite
                                                ? Colors.red
                                                : Colors.grey,
                                      ),
                                      onPressed: () {
                                        context
                                            .read<FavoriteCubit>()
                                            .toggleFavorite(product);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.title ?? 'لا يوجد عنوان',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      product.description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "\$${product.price?.toStringAsFixed(2) ?? 'N/A'}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () {
                      final favoriteProducts =
                          context.read<FavoriteCubit>().state;
                      Navigator.pushNamed(
                        context,
                        FAVORITE,
                        //arguments: favoriteProducts,
                      );
                    },
                    backgroundColor: Colors.teal,
                    child: const Icon(Icons.favorite),
                  ),
                ),
              ],
            );
          } else if (state is ProductFailur) {
            return Center(child: Text('خطأ: ${state.message}'));
          } else {
            return const Text('حدث خطأ غير متوقع');
          }
        },
      ),
    );
  }
}
