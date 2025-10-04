import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/domain/repositories/product_repository.dart';

class UpdateProduct implements Usecase<ProductModel, UpdateProductParams> {
  final ProductRepository productRepository;
  const UpdateProduct(this.productRepository);

  @override
  Future<Either<Failure, ProductModel>> call(UpdateProductParams params) async {
    return await productRepository.updateProduct(
      categoryId: params.categoryId,
      product: params.product,
      image: params.image,
    );
  }
}

class UpdateProductParams {
  final String categoryId;
  final ProductModel product;
  final Uint8List image;
  const UpdateProductParams({
    required this.categoryId,
    required this.product,
    required this.image,
  });
}
