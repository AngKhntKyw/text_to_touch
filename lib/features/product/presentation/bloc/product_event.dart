part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class GetProductsEvent extends ProductEvent {
  final String categoryId;
  GetProductsEvent({required this.categoryId});
}

final class AddNewProductEvent extends ProductEvent {
  final String categoryId;
  final ProductModel productModel;
  final Uint8List image;
  AddNewProductEvent({
    required this.categoryId,
    required this.productModel,
    required this.image,
  });
}

final class UpdateProductEvent extends ProductEvent {
  final String categoryId;
  final ProductModel productModel;
  final Uint8List image;
  UpdateProductEvent({
    required this.categoryId,
    required this.productModel,
    required this.image,
  });
}

final class DeleteProductEvent extends ProductEvent {
  final String categoryId;
  final String productId;
  DeleteProductEvent({required this.categoryId, required this.productId});
}
