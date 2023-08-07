import 'dart:developer';

import 'package:crud_local_testing_app/features/authentication/domain/usecases/auth_usecase.dart';

class LoginController {
  final LoginUsecase loginUseCase;

  LoginController({
    required this.loginUseCase,
  });

  void login(
    String email,
    String password,
  ) {
    log(email);
    loginUseCase.call(email, password);
  }
}
