import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio dio() => Dio(BaseOptions(baseUrl: AppConstants.apiBaseUrl));

  @preResolve
  Future<SharedPreferences> sharedPreferences() async =>
      SharedPreferences.getInstance();
}
