import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/domain/repositories/product_repository.dart';

class AddNewProduct implements Usecase<ProductModel, AddNewProductParams> {
  final ProductRepository productRepository;
  const AddNewProduct(this.productRepository);

  @override
  Future<Either<Failure, ProductModel>> call(AddNewProductParams params) async {
    return await productRepository.addNewProduct(
      categoryId: params.categoryId,
      product: params.product,
      image: params.image,
    );
  }
}

class AddNewProductParams {
  final String categoryId;
  final ProductModel product;
  final Uint8List image;
  const AddNewProductParams({
    required this.categoryId,
    required this.product,
    required this.image,
  });
}
