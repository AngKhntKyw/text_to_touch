import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class UpdateCategory implements Usecase<CategoryModel, UpdateCategoryParams> {
  final CategoryRepository categoryRepository;
  const UpdateCategory(this.categoryRepository);

  @override
  Future<Either<Failure, CategoryModel>> call(
    UpdateCategoryParams params,
  ) async {
    return await categoryRepository.updateCategory(category: params.category);
  }
}

class UpdateCategoryParams {
  final CategoryModel category;
  const UpdateCategoryParams({required this.category});
}
