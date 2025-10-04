import 'dart:typed_data';
import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/features/product/data/models/product_model.dart';

abstract interface class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required String categoryId,
  });
  Future<Either<Failure, ProductModel>> addNewProduct({
    required String categoryId,
    required ProductModel product,
    required Uint8List image,
  });
  Future<Either<Failure, ProductModel>> updateProduct({
    required String categoryId,
    required ProductModel product,
    required Uint8List image,
  });
  Future<Either<Failure, bool>> deleteProduct({
    required String categoryId,
    required String productId,
  });
}
