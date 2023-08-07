import 'dart:developer';

import 'package:crud_local_testing_app/core/app_service_client.dart';
import 'package:crud_local_testing_app/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/requests/login_request.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/responses/responses.dart';

class AuthRemoteDataSourceImpl implements AuthenticationDataSource {
  final AppServiceClient _appServiceClient;
  AuthRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    log(" data source  impl ${request.email}");
    return await _appServiceClient.login(request);
  }
}
