import 'package:crud_local_testing_app/features/authentication/data/network/requests/login_request.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/responses/responses.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<void, LoginResponse>> login(String email, String password);
}
