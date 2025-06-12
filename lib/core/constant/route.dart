import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/core/constant/route_name.dart';
import 'package:product_app/feature/cubits/products/product_cubit.dart';
import 'package:product_app/home.dart';
import 'package:product_app/main.dart';
import 'package:product_app/feature/model/product_model.dart';
import 'package:product_app/feature/view/favorite_page.dart';
import 'package:product_app/feature/view/pages/product_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case '/home':
      return MaterialPageRoute(builder: (_) => HomePage());
    case PRODUCT:
      final productId = settings.arguments as int;
      return MaterialPageRoute(
        builder:
            (context) => BlocProvider.value(
              value: BlocProvider.of<ProductCubit>(context),
              child: SingleProductPage(id: productId),
            ),
      );
    case FAVORITE:
      final favoriteProducts = settings.arguments as List<ProductModel>;
      return MaterialPageRoute(
        builder:
            (context) => BlocProvider.value(
              value: BlocProvider.of<ProductCubit>(context),
              child: FavoritePage(),
            ),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text("لا توجد صفحة"))),
      );
  }
}
