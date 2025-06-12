part of 'product_cubit.dart';

@immutable
sealed class ProductState extends Equatable {
  final List<ProductModel> products;

  const ProductState(this.products);
}

final class ProductInitial extends ProductState {
  ProductInitial() : super([]);

  @override
  List<Object?> get props => [];
}

final class ProductLoading extends ProductState {
  ProductLoading() : super([]);

  @override
  List<Object?> get props => [];
}

final class ProductSuccess extends ProductState {
  const ProductSuccess(super.products);

  @override
  List<Object?> get props => [products];
}

final class ProductSingleSuccess extends ProductState {
  final ProductModel product;

  ProductSingleSuccess(this.product) : super([]);

  @override
  List<Object?> get props => [product];
}

final class ProductFailur extends ProductState {
  final String message;
  ProductFailur(this.message) : super([]);

  @override
  List<Object?> get props => [message];
}

// final class ProductFailure extends ProductState {
//   final String message;

//   ProductFailure(List<ProductModel> previousProducts, this.message)
//       : super(previousProducts);

//   @override
//   List<Object?> get props => [products, message];
// }
