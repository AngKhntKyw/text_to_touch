import 'package:test_app/features/category/data/datasources/category_remote_datasource.dart';
import 'package:test_app/features/category/data/repositories/category_repository_impl.dart';
import 'package:test_app/features/category/domain/repositories/category_repository.dart';
import 'package:test_app/features/category/domain/usecases/add_new_category.dart';
import 'package:test_app/features/category/domain/usecases/delete_category.dart';
import 'package:test_app/features/category/domain/usecases/get_categories.dart';
import 'package:test_app/features/category/domain/usecases/update_category.dart';
import 'package:test_app/features/category/presentation/bloc/category_bloc.dart';
import 'package:test_app/init_dependencies.dart';

void initCategory() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<CategoryRemoteDatasource>(
      () => CategoryRemoteDatasourceImpl(fireStore: serviceLocator()),
    )
    //Repository
    ..registerFactory<CategoryRepository>(
      () => CategoryRepositoryImpl(
        categoryRemoteDatasource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    //Usecase
    ..registerFactory(() => GetCategories(serviceLocator()))
    ..registerFactory(() => AddNewCategory(serviceLocator()))
    ..registerFactory(() => UpdateCategory(serviceLocator()))
    ..registerFactory(() => DeleteCategory(serviceLocator()))
    //Bloc
    ..registerFactory(
      () => CategoryBloc(
        getCategories: serviceLocator(),
        addNewCategory: serviceLocator(),
        updateCategory: serviceLocator(),
        deleteCategory: serviceLocator(),
      ),
    );
}
