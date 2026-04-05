import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

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
}
