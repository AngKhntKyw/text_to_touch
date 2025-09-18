import 'package:test_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:test_app/features/auth/domain/usecases/log_out.dart';
import 'package:test_app/features/auth/domain/usecases/login.dart';
import 'package:test_app/features/auth/domain/usecases/sign_up.dart';
import 'package:test_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:test_app/init_dependencies.dart';

void initAuth() {
  //RemoteDataSource
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        fireAuth: serviceLocator(),
        fireMessage: serviceLocator(),
        fireStore: serviceLocator(),
      ),
    )
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
        connectionChecker: serviceLocator(),
      ),
    )
    //Usecase
    ..registerFactory(() => SignUp(serviceLocator()))
    ..registerFactory(() => Login(serviceLocator()))
    ..registerFactory(() => LogOut(serviceLocator()))
    //Bloc
    ..registerFactory(
      () => AuthBloc(
        signUpWithEmailAndPassword: serviceLocator(),
        logInWithEmailAndPassword: serviceLocator(),
        logOut: serviceLocator(),
      ),
    );
}
