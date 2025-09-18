import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class Login implements Usecase<UserCredential?, LoginParams> {
  final AuthRepository authRepository;
  const Login(this.authRepository);

  @override
  Future<Either<Failure, UserCredential?>> call(LoginParams params) async {
    return await authRepository.logInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;
  const LoginParams({required this.email, required this.password});
}
