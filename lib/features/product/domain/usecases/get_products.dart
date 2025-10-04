import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/product/data/models/product_model.dart';
import 'package:test_app/features/product/domain/repositories/product_repository.dart';

class GetProducts implements Usecase<List<ProductModel>, GetProductsParams> {
  final ProductRepository productRepository;
  const GetProducts(this.productRepository);

  @override
  Future<Either<Failure, List<ProductModel>>> call(
    GetProductsParams params,
  ) async {
    return await productRepository.getProducts(categoryId: params.categoryId);
  }
}

class GetProductsParams {
  final String categoryId;
  const GetProductsParams({required this.categoryId});
}
