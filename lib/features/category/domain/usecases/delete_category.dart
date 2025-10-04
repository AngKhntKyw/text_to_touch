import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class DeleteCategory implements Usecase<bool, DeleteCategoryParams> {
  final CategoryRepository categoryRepository;
  const DeleteCategory(this.categoryRepository);

  @override
  Future<Either<Failure, bool>> call(DeleteCategoryParams params) async {
    return await categoryRepository.deleteCategory(
      categoryId: params.categoryId,
    );
  }
}

class DeleteCategoryParams {
  final String categoryId;
  const DeleteCategoryParams({required this.categoryId});
}
