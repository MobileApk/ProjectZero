import 'package:dartz/dartz.dart';
import 'package:project_zero/core/failures_and_exceptions.dart';

/// Base class for UseCases
abstract class UseCase<Type, Params> {
  /// Uses dartz pakage to handel the response success and failure as "Either"
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
