// ignore_for_file: constant_identifier_names

import 'package:project_zero/core/constants.dart';
import 'package:project_zero/core/extensions/custom_ext.dart';
import 'package:project_zero/core/extensions/dio_error.dart';
import 'package:project_zero/features/data/datasources/local_datasource/local_datasource.dart';
import 'package:project_zero/features/data/models/auth/login_model.dart';
import 'package:project_zero/main_common.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'auth_client.g.dart';

/// flutter pub run build_runner build --delete-conflicting-outputs
/// Use above command to generate the code

@RestApi()
abstract class AuthClient {
  factory AuthClient(
    final Dio dio,
    final LocalDataSource localDataSource,
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.addRequestOptions(localDataSource);
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          e.printErrorPath();
          return handler.next(e);
        },
      ),
    );

    return _AuthClient(
      dio,
      baseUrl: baseUrl,
    );
  }

  @POST("ENDPOINT")
  Future<LoginModel> login(
    @Field("status") String email,
    @Field("status") String password,
  );
}
