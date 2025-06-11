import 'package:dio/dio.dart';
import 'package:product_app/model/product_model.dart';

class ProductVm {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('https://fakestoreapi.com/products');

      if (response.statusCode == 200) {
        List<dynamic> data = response.data;

        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception('فشل في تحميل المنتجات');
      }
    } catch (e) {
      throw Exception('خطأ أثناء الاتصال بالسيرفر: $e');
    }
  }
}
