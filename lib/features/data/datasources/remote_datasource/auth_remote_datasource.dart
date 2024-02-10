import 'package:dio/dio.dart';
import 'package:project_zero/core/constants.dart';
import 'package:project_zero/core/extensions/dio_error.dart';
import 'package:project_zero/core/failures_and_exceptions.dart';
import 'package:project_zero/features/data/client/auth/auth_client.dart';
import 'package:project_zero/features/data/datasources/local_datasource/local_datasource.dart';
import 'package:project_zero/features/data/models/auth/login_model.dart';

abstract class AuthRemoteDatasource {
  Future<LoginModel> login({required String email, required String password});
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final AuthClient client;
  final LocalDataSource localDataSource;

  AuthRemoteDatasourceImpl(
      this.client, this.localDataSource);

  void _processDio(err) {
    if (err is DioException) {
      throw ServerException(
        message: err.getErrorFromDio(
            validateAuthentication: true, localDataSource: localDataSource),
      );
    } else {
      throw ServerException(message: Constants.errorUnknown);
    }
  }

  @override
  Future<LoginModel> login(
      {required String email, required String password}) async {
    try {
      return await client.login(email, password).catchError((err) {
        _processDio(err);
      });
    } on Exception {
      rethrow;
    }
  }
}
