import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:product_app/core/helper/dio_exption.dart';
import 'package:product_app/feature/model/product_model.dart';
import 'package:product_app/feature/cubits/repo/product_repo.dart';
import 'dart:developer' as dev;
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository repo;

  ProductCubit(this.repo) : super(ProductInitial()) {}

  void resetState() {
    emit(ProductInitial());
  }

  Future fetchProducts() async {
    try {
      emit(ProductLoading());
      final products = await repo.fetchProducts();
      dev.log(products.toString());
      emit(ProductSuccess(products));
    } on DioException catch (e) {
      final message = DioExceptionHandler.instance.handle(e);
      dev.log('Dio Error: $message');
      emit(ProductFailur(message));
    } catch (e, s) {
      dev.log('Unknown error', error: e, stackTrace: s);
      emit(ProductFailur('حدث خطأ غير متوقع'));
    }
  }

  Future getProduct(int id) async {
    try {
      emit(ProductLoading());
      final singleProduct = await repo.getProduct(id);
      emit(ProductSingleSuccess(singleProduct));
      dev.log(singleProduct.toString());
    } on DioException catch (e) {
      final message = DioExceptionHandler.instance.handle(e);
      dev.log('Dio Error: $message');
      emit(ProductFailur(message));
    } catch (e, s) {
      dev.log('Unknown error', error: e, stackTrace: s);
      emit(ProductFailur('حدث خطأ غير متوقع'));
    }
  }
}
