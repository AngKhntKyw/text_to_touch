import 'package:fpdart/fpdart.dart';
import 'package:test_app/core/error/failure.dart';
import 'package:test_app/core/usecase/usecase.dart';
import 'package:test_app/features/auth/domain/repositories/auth_repository.dart';

class LogOut implements Usecase<String, NoParams> {
  final AuthRepository authRepository;
  const LogOut(this.authRepository);

  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await authRepository.logOut();
  }
}
