import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/feature/cubits/products/product_cubit.dart';

class SingleProductPage extends StatefulWidget {
  final int id;
  const SingleProductPage({Key? key, required this.id}) : super(key: key);

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  @override
  void initState() {
    super.initState();

    context.read<ProductCubit>().getProduct(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل المنتج'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<ProductCubit>().resetState();
            context.read<ProductCubit>().fetchProducts();
            Navigator.pop(context);
          },
        ),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductSingleSuccess) {
            final product = state.product;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.image != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.image!,
                        height: 250,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Container(
                              height: 250,
                              color: Colors.grey[300],
                              child: const Center(child: Icon(Icons.error)),
                            ),
                      ),
                    ),
                  const SizedBox(height: 12),
                  Text(
                    product.title ?? 'لا يوجد عنوان',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? 'لا يوجد وصف',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "\$${product.price?.toStringAsFixed(2) ?? 'N/A'}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProductFailur) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('حدث خطأ غير معروف'));
          }
        },
      ),
    );
  }
}
