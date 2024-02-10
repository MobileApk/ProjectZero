import 'package:dartz/dartz.dart';
import 'package:project_zero/core/constants.dart';
import 'package:project_zero/core/failures_and_exceptions.dart';
import 'package:project_zero/core/network_info.dart';
import 'package:project_zero/features/data/datasources/local_datasource/local_datasource.dart';
import 'package:project_zero/features/data/datasources/remote_datasource/auth_remote_datasource.dart';
import 'package:project_zero/features/data/models/auth/login_model.dart';
import 'package:project_zero/features/data/repositories/repository_conv.dart';
import 'package:project_zero/features/domain/entities/auth/login_entity.dart';
import 'package:project_zero/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final LocalDataSource localDataSource;
  final AuthRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(
      this.localDataSource, this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, LoginEntity>> login(
      {required String email, required String password}) async {
    try {
      if (await networkInfo.isConnected) {
        final result =
            await remoteDataSource.login(email: email, password: password);

        Result? data = result.result;

        if (data != null) {
          /// Here you can save accesstoken to local data source
          // localDataSource.saveAccessToken(data.token!);
        }
        return Right(RepositoryConv.loginModelToEntityConv(result));
      } else {
        return const Left(ServerFailure(message: Constants.errorNoInternet));
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
