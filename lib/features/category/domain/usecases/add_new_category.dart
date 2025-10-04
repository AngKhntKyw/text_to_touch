import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class AddNewCategory implements Usecase<CategoryModel, AddNewCategoryParams> {
  final CategoryRepository categoryRepository;
  const AddNewCategory(this.categoryRepository);

  @override
  Future<Either<Failure, CategoryModel>> call(
    AddNewCategoryParams params,
  ) async {
    return await categoryRepository.addNewCategory(name: params.name);
  }
}

class AddNewCategoryParams {
  final String name;
  const AddNewCategoryParams({required this.name});
}
