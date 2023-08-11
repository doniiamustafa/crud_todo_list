import 'dart:developer';

import 'package:crud_local_testing_app/features/authentication/data/network/responses/responses.dart';
import 'package:crud_local_testing_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase {
  final AuthRepository _authRepository;
  LoginUsecase(this._authRepository);

  Future<Either<void, LoginResponse>> call(
      String email, String password) async {
    log(" usecase ${email}");

    return await _authRepository.login(email, password);
  }
}
