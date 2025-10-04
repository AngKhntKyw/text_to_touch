import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/features/category/data/models/category_model.dart';

abstract interface class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
  Future<Either<Failure, CategoryModel>> addNewCategory({required String name});
  Future<Either<Failure, CategoryModel>> updateCategory({
    required CategoryModel category,
  });
  Future<Either<Failure, bool>> deleteCategory({required String categoryId});
}
