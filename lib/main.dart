import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/constant/route.dart';
import 'package:product_app/core/constant/route_name.dart';
import 'package:product_app/feature/cubits/favorite_cubit/favorite.dart';
import 'package:product_app/feature/cubits/products/product_cubit.dart';
import 'package:product_app/feature/cubits/repo/product_repo.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit(ProductRepository())),
        BlocProvider(create: (context) => FavoriteCubit()),
      ],
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
      initialRoute: HOME,
    );
  }
}
