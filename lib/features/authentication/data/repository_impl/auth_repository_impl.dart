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
      final request = LoginRequest(email, password);
      log(" repo impl ${request.email}");
      final response = await authDataSource.login(request);

      var data = response.body["data"];
      List values = data.values
          .toList(); //? token value doesn't have a "Key" in data map so, i should get all the values in a separate list
      appPreferences.setToken(values[1]);
      log("token${values[1]}");

      return Right(response);
    } catch (e) {
      return const Left("Not found");
    }
  }
}
