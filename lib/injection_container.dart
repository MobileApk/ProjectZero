import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:project_zero/core/config/my_shared_pref.dart';
import 'package:project_zero/core/constants.dart';
import 'package:project_zero/core/network_info.dart';
import 'package:project_zero/features/data/datasources/local_datasource/local_datasource.dart';
import 'package:project_zero/features/data/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:project_zero/features/data/repositories/auth_repository_impl.dart';
import 'package:project_zero/features/domain/repositories/auth_repository.dart';
import 'package:project_zero/features/domain/usecases/auth/login_usecase.dart';
import 'package:project_zero/features/presentation/auth/cubit/login_cubit.dart';

/// Using GetIt for dependency Injection

final sl = GetIt.instance;

Future<void> init() async {
  /// Injecting Blocks and Cubits

  sl.registerFactory(() => LoginCubit(sl()));

  /// Injecting Usecases
  sl.registerLazySingleton(() => LoginUsecase(sl()));

  /// Injecting Repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl(), sl(), sl()));

  /// DataSource
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sl(), sl()));
  sl.registerLazySingleton<AuthRemoteDatasource>(
      () => AuthRemoteDatasourceImpl(sl(), sl()));

  /// core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<MySharedPref>(() => MySharedPref(sl()));

  /// initializing dio
  final dio = Dio(
    BaseOptions(
      baseUrl: Constants.baseUrl,
      connectTimeout: const Duration(milliseconds: 500000),
      receiveTimeout: const Duration(milliseconds: 500000),
      sendTimeout: const Duration(milliseconds: 500000),
    ),
  );
  dio.interceptors.add(
    LogInterceptor(
      request: true,
      responseHeader: true,
      logPrint: (value) => log(value.toString()),
      responseBody: true,
      requestBody: true,
      requestHeader: true,
      error: true,
    ),
  );
}
