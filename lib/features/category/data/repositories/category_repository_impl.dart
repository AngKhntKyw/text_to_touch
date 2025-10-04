import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/common/constants/constants.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/features/category/data/datasources/category_remote_datasource.dart';
import 'package:test_app/features/category/data/models/category_model.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDatasource categoryRemoteDatasource;
  final NetworkInfo connectionChecker;

  CategoryRepositoryImpl({
    required this.categoryRemoteDatasource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, CategoryModel>> addNewCategory({
    required String name,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }
      final result = await categoryRemoteDatasource.addNewCategory(name: name);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }

  @override
  Future<Either<Failure, CategoryModel>> updateCategory({
    required CategoryModel category,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }

      final result = await categoryRemoteDatasource.updateCategory(
        category: category,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }

      final result = await categoryRemoteDatasource.getCategories();
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteCategory({
    required String categoryId,
  }) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }

      final result = await categoryRemoteDatasource.deleteCategory(
        categoryId: categoryId,
      );
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }
}
