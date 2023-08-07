import 'package:crud_local_testing_app/config/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  final SharedPreferences sharedPreferences;

  AppPreferences({required this.sharedPreferences});

  void setToken(String token) {
    sharedPreferences.setString(AppConstants.tokenKey, token);
  }

  String? getToken() {
    return sharedPreferences.getString(AppConstants.tokenKey);
  }
}
