import 'package:dartz/dartz.dart';
import 'package:project_zero/core/failures_and_exceptions.dart';
import 'package:project_zero/core/usecase.dart';
import 'package:project_zero/features/domain/entities/auth/login_entity.dart';
import 'package:project_zero/features/domain/repositories/auth_repository.dart';

class LoginUsecase extends UseCase<LoginEntity, LoginParams> {
  final AuthRepository repo;

  LoginUsecase(this.repo);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParams params) async {
    return await repo.login(email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
