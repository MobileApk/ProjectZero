import 'package:project_zero/core/constants.dart';

abstract class Failure {
  final String message;

  const Failure({this.message = Constants.errorUnknown});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

class ServerException implements Exception {
  String message;

  ServerException({required this.message});
}

class CacheException implements Exception {}
