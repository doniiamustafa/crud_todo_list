import 'package:crud_local_testing_app/config/app_constants.dart';
import 'package:crud_local_testing_app/core/api_end_points.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/requests/login_request.dart';
import 'package:crud_local_testing_app/features/authentication/data/network/responses/responses.dart';
import 'package:dio/dio.dart';

import 'package:retrofit/retrofit.dart';

part 'app_service_client.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST(ApiEndPoints.login)
  Future<LoginResponse> login(LoginRequest loginRequest);
}
