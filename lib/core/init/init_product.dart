import 'package:test_app/features/product/data/datasources/product_remote_datasource.dart';
import 'package:test_app/features/product/data/repositories/product_repository_impl.dart';
import 'package:test_app/features/product/domain/repositories/product_repository.dart';
import 'package:test_app/features/product/domain/usecases/add_new_product.dart';
import 'package:test_app/features/product/domain/usecases/delete_product.dart';
import 'package:test_app/features/product/domain/usecases/get_products.dart';
import 'package:test_app/features/product/domain/usecases/update_product.dart';
import 'package:test_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:test_app/init_dependencies.dart';

void initProduct() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<ProductRemoteDatasource>(
      () => ProductRemoteDatasourceImpl(
        fireStore: serviceLocator(),
        firebaseStorage: serviceLocator(),
        firebaseAuth: serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<ProductRepository>(
      () => ProductRepositoryImpl(
        productRemoteDatasource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    //Usecase
    ..registerFactory(() => GetProducts(serviceLocator()))
    ..registerFactory(() => AddNewProduct(serviceLocator()))
    ..registerFactory(() => UpdateProduct(serviceLocator()))
    ..registerFactory(() => DeleteProduct(serviceLocator()))
    //Bloc
    ..registerFactory(
      () => ProductBloc(
        getProducts: serviceLocator(),
        addNewProduct: serviceLocator(),
        updateProduct: serviceLocator(),
        deleteProduct: serviceLocator(),
      ),
    );
}
