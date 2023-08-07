import 'dart:developer';

import 'package:crud_local_testing_app/config/app_constants.dart';
import 'package:crud_local_testing_app/config/app_pref.dart';
import 'package:crud_local_testing_app/core/dependency_injection.dart';
import 'package:dio/dio.dart' show Dio, BaseOptions;
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart' show PrettyDioLogger;

class DioFactory {
  final AppPreferences appPreferences = instance<AppPreferences>();

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String? token = await appPreferences.getToken();
    log("token auth: $token");

    Map<String, String> headers = {
      "authorization": "$token",

      AppConstants.contentType: AppConstants.applicationJson,
      AppConstants.accept: AppConstants.applicationJson,
    };
    dio.options = BaseOptions(
      baseUrl: AppConstants.baseUrl,
      headers: headers,
      receiveTimeout: 60 * 1000,
      connectTimeout: 60 * 1000,
      sendTimeout: 60 * 1000,
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
    return dio;
  }
}
