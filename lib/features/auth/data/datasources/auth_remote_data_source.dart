import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../models/auth_profile_dto.dart';
import '../models/login_tokens_dto.dart';

@lazySingleton
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<LoginTokensDto> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );

    final data = response.data ?? <String, dynamic>{};
    return LoginTokensDto.fromJson(data);
  }

  Future<AuthProfileDto> fetchProfile({required String accessToken}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/auth/profile',
      options: Options(
        headers: <String, String>{'Authorization': 'Bearer $accessToken'},
      ),
    );

    final data = response.data ?? <String, dynamic>{};
    return AuthProfileDto.fromJson(data);
  }
}
