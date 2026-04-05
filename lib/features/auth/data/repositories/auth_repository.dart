import 'package:injectable/injectable.dart';

import '../../../../core/network/network_error_mapper.dart';
import '../datasources/auth_remote_data_source.dart';

@lazySingleton
class AuthRepository {
  const AuthRepository(this._remoteDataSource, this._errorMapper);

  final AuthRemoteDataSource _remoteDataSource;
  final NetworkErrorMapper _errorMapper;

  Future<void> login({required String email, required String password}) async {
    try {
      final tokens = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      if (tokens.accessToken.isEmpty || tokens.refreshToken.isEmpty) {
        throw const AuthFailure('Received invalid auth token payload');
      }
    } catch (error) {
      if (error is AuthFailure) {
        rethrow;
      }

      throw AuthFailure(_errorMapper.toMessage(error));
    }
  }
}

class AuthFailure implements Exception {
  const AuthFailure(this.message);

  final String message;
}
