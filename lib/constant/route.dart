import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/constant/route_name.dart';
import 'package:product_app/cubit/product_cubit.dart';
import 'package:product_app/main.dart';
import 'package:product_app/view/pages/product_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  final args = settings.arguments;

  switch (settings.name) {
    case '/':
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

    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text("لا توجد صفحة"))),
      );
  }
}
