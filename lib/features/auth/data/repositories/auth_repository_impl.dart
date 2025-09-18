import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/common/constants/constants.dart';
import 'package:test_app/core/error/exceptions.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo connectionChecker;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, UserCredential?>> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return getUser(
      () async => await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, UserCredential?>> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return getUser(
      () async => await authRemoteDataSource.logInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, UserCredential?>> getUser(
    Future<UserCredential?> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }

      final user = await fn();
      return right(user!);
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }

  @override
  Future<Either<Failure, String>> logOut() async {
    try {
      if (!await connectionChecker.isConnected()) {
        return left(Failure(503, Constant.networkErrorMessage));
      }

      await authRemoteDataSource.logOut();
      return right("Logout Success");
    } on ServerException catch (e) {
      return left(Failure(e.statusCode, e.message));
    }
  }
}
