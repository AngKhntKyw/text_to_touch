import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class SignUp implements Usecase<UserCredential?, SignUpParams> {
  final AuthRepository authRepository;
  const SignUp(this.authRepository);

  @override
  Future<Either<Failure, UserCredential?>> call(SignUpParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String name;
  const SignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
