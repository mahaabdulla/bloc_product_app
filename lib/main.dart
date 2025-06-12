import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/constant/route.dart';
import 'package:product_app/constant/route_name.dart';
import 'package:product_app/cubit/product_cubit.dart';
import 'package:product_app/repo/product_repo.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ProductCubit(ProductRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      onGenerateRoute: generateRoute,
      initialRoute: '/',
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchProducts();
  }

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
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (ctx, index) {
                  final product = state.products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        PRODUCT,
                        arguments: state.products[index].id,
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.image ?? '',
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder:
                                    (context, error, stackTrace) => Container(
                                      height: 180,
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: Icon(Icons.error),
                                      ),
                                    ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              product.title ?? 'لا يوجد عنوان',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description ?? '',
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "\$${product.price?.toStringAsFixed(2) ?? 'N/A'}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is ProductFailur) {
            return Center(child: Text('خطأ: ${state.message}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
