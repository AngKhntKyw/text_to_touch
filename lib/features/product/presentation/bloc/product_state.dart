part of 'product_bloc.dart';

@immutable
sealed class ProductState {
  const ProductState();
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  const ProductLoaded({required this.products});
}

final class ProductAdded extends ProductState {
  final ProductModel product;
  final List<ProductModel> products;
  const ProductAdded({required this.product, required this.products});
}

final class ProductUpdated extends ProductState {
  final ProductModel product;
  final List<ProductModel> products;
  const ProductUpdated({required this.product, required this.products});
}

final class ProductDeleted extends ProductState {
  final List<ProductModel> products;
  const ProductDeleted({required this.products});
}

final class ProductFailure extends ProductState {
  final Failure failure;
  const ProductFailure({required this.failure});
}
