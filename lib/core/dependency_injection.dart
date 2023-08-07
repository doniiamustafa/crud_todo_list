import 'dart:developer';

import 'package:crud_local_testing_app/config/app_pref.dart';
import 'package:crud_local_testing_app/core/app_service_client.dart';
import 'package:crud_local_testing_app/core/dio_factory.dart';
import 'package:crud_local_testing_app/features/authentication/data/data_source/auth_remote_data_source_impl.dart';
import 'package:crud_local_testing_app/features/authentication/data/repository_impl/auth_repository_impl.dart';
import 'package:crud_local_testing_app/features/authentication/domain/usecases/auth_usecase.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initApp() async {
  log("initApp");

  // shared preferences
  final shared = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => shared);
  instance.registerLazySingleton<AppPreferences>(
      () => AppPreferences(sharedPreferences: instance<SharedPreferences>()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  // app service client
  Dio dio = await instance<DioFactory>().getDio();

  if (!GetIt.I.isRegistered<AppServiceClient>()) {
    instance.registerLazySingleton<AppServiceClient>(
      () => AppServiceClient(dio),
    );
  }

  // data source
  if (!GetIt.I.isRegistered<AuthRemoteDataSourceImpl>()) {
    instance.registerLazySingleton<AuthRemoteDataSourceImpl>(
      () => AuthRemoteDataSourceImpl(instance<AppServiceClient>()),
    );
  }

  // repository
  if (!GetIt.I.isRegistered<AuthRepositoryImpl>()) {
    instance.registerLazySingleton<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(
        instance<AuthRemoteDataSourceImpl>(),
      ),
    );
  }

  // usecases
  if (!GetIt.I.isRegistered<LoginUsecase>()) {
    instance.registerFactory<LoginUsecase>(
      () => LoginUsecase(
        instance<AuthRepositoryImpl>(),
      ),
    );
  }
}

// initHome() {
//   log("initHome");

//    //bloc
//   if (!GetIt.I.isRegistered<HomeBloc>()) {
//     instance.registerFactory<HomeBloc>(
//       () => HomeBloc(
//         homeUseCase: instance<HomeUseCase>(),
//       ),
//     );
//   }
// }
