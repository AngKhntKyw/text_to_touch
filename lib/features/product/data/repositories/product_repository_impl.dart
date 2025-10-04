import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/common/constants/constants.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource productRemoteDatasource;
  final NetworkInfo connectionChecker;

  ProductRepositoryImpl({
    required this.productRemoteDatasource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required String categoryId,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }
      final result = await productRemoteDatasource.getProducts(
        categoryId: categoryId,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> addNewProduct({
    required String categoryId,
    required ProductModel product,
    required Uint8List image,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }
      final result = await productRemoteDatasource.addNewProduct(
        categoryId: categoryId,
        product: product,
        image: image,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProduct({
    required String categoryId,
    required String productId,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }
      final result = await productRemoteDatasource.deleteProduct(
        categoryId: categoryId,
        productId: productId,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }

  @override
  Future<Either<Failure, ProductModel>> updateProduct({
    required String categoryId,
    required ProductModel product,
    required Uint8List image,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }
      final result = await productRemoteDatasource.updateProduct(
        categoryId: categoryId,
        product: product,
        image: image,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }
}
