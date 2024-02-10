import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:project_zero/core/constants.dart';
import 'package:project_zero/features/data/datasources/local_datasource/local_datasource.dart';

extension RequestOptionsFunction on RequestOptions {
  RequestOptions addRequestOptions(
    final LocalDataSource localDataSource, {
    String? token,
  }) {
    final accessToken = token ?? localDataSource.getAccessToken();
    log(accessToken, name: "Bearer");
    if (accessToken.isNotEmpty) {
      headers[Constants.authorization] = "Bearer $accessToken";
    }
    return this;
  }
}
