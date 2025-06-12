import 'package:dio/dio.dart';
import 'package:product_app/core/constant/api_url.dart';
import 'package:product_app/feature/model/product_model.dart';
import 'dart:developer' as dev;

class ProductRepository {
  final Dio _dio = Dio();

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await _dio.get(ApiUrl.getALLProduct);
      dev.log('Response status: ${response.statusCode}');
      dev.log('Response data: ${response.data}');

      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'فشل في جلب المنتجات',
        );
      }

      List list = response.data;
      return list.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      dev.log('Dio Error in fetchProducts: ${e.message}');
      rethrow;
    } catch (e) {
      dev.log('Unknown error in fetchProducts: $e');
      rethrow;
    }
  }

  Future<ProductModel> getProduct(int id) async {
    try {
      final response = await _dio.get(ApiUrl.getSingleProduct(id));
      dev.log('Response status: ${response.statusCode}');
      dev.log('Response data: ${response.data}');

      if (response.statusCode != 200) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'فشل في جلب تفاصيل المنتج',
        );
      }

      return ProductModel.fromJson(response.data);
    } on DioException catch (e) {
      dev.log('Dio Error in getProduct: ${e.message}');
      rethrow;
    } catch (e) {
      dev.log('Unknown error in getProduct: $e');
      rethrow;
    }
  }
}
