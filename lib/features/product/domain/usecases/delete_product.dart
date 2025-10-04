import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/product/domain/repositories/product_repository.dart';

class DeleteProduct implements Usecase<bool, DeleteProductParams> {
  final ProductRepository productRepository;
  const DeleteProduct(this.productRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteProductParams params) async {
    return await productRepository.deleteProduct(
      categoryId: params.categoryId,
      productId: params.productId,
    );
  }
}

class DeleteProductParams {
  final String categoryId;
  final String productId;
  const DeleteProductParams({
    required this.categoryId,
    required this.productId,
  });
}
