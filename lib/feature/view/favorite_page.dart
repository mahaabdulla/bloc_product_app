import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/feature/cubits/favorite_cubit/favorite.dart';
import 'package:product_app/feature/model/product_model.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'المفضلة',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: BlocBuilder<FavoriteCubit, List<ProductModel>>(
        builder: (context, favoriteProducts) {
          if (favoriteProducts.isEmpty) {
            return const Center(child: Text('لا توجد منتجات مفضلة'));
          }

          return ListView.builder(
            itemCount: favoriteProducts.length,
            itemBuilder: (ctx, index) {
              final product = favoriteProducts[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    leading: Image.network(
                      product.image ?? '',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.title ?? 'بدون عنوان'),
                    subtitle: Text(
                      "\$${product.price?.toStringAsFixed(2) ?? 'N/A'}",
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<FavoriteCubit>().toggleFavorite(product);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
