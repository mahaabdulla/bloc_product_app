import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/feature/model/product_model.dart';

class FavoriteCubit extends Cubit<List<ProductModel>> {
  FavoriteCubit() : super([]);

  void toggleFavorite(ProductModel product) {
    final isExist = state.any((item) => item.id == product.id);

    if (isExist) {
      emit(state.where((item) => item.id != product.id).toList());
    } else {
      emit([...state, product]);
    }
  }

  bool isFavorite(ProductModel product) {
    return state.any((item) => item.id == product.id);
  }
}
