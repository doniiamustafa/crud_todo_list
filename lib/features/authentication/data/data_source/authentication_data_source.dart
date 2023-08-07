import 'package:crud_local_testing_app/features/authentication/data/network/requests/login_request.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/responses/responses.dart';

abstract class AuthenticationDataSource {
  Future<LoginResponse> login(LoginRequest loginRequest);
}
