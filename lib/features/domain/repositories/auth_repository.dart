import 'package:dartz/dartz.dart';
import 'package:project_zero/core/failures_and_exceptions.dart';
import 'package:project_zero/features/domain/entities/auth/login_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login(
      {required String email, required String password});
}
