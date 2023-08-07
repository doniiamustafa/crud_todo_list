import 'dart:developer';

import 'package:crud_local_testing_app/config/app_pref.dart';
import 'package:crud_local_testing_app/core/dependency_injection.dart';
import 'package:crud_local_testing_app/features/authentication/data/data_source/authentication_data_source.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/requests/login_request.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/responses/responses.dart';
import 'package:crud_local_testing_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AppPreferences appPreferences = instance<AppPreferences>();

  final AuthenticationDataSource authDataSource;
  AuthRepositoryImpl(this.authDataSource);
  @override
  Future<Either<void, LoginResponse>> login(
      String email, String password) async {
    try {
      log(" repo impl ${email}");

      final request = LoginRequest(email, password);
      final response = await authDataSource.login(request);

      final token = response.body["token"];  // incase token located in response body
      appPreferences.setToken(token);

      return Right(response);
    } catch (e) {
      log(e.toString());
      return const Left("Not found");
    }
  }
}
