import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/network/network_error_mapper.dart';
import '../datasources/auth_remote_data_source.dart';

@lazySingleton
class AuthRepository {
  const AuthRepository(
    this._remoteDataSource,
    this._errorMapper,
    this._preferences,
  );

  final AuthRemoteDataSource _remoteDataSource;
  final NetworkErrorMapper _errorMapper;
  final SharedPreferences _preferences;

  static const _accessTokenKey = 'auth_access_token';
  static const _userNameKey = 'auth_user_name';

  Future<void> login({required String email, required String password}) async {
    try {
      final tokens = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      if (tokens.accessToken.isEmpty || tokens.refreshToken.isEmpty) {
        throw const AuthFailure('Received invalid auth token payload');
      }

      final profile = await _remoteDataSource.fetchProfile(
        accessToken: tokens.accessToken,
      );
      final userName = profile.name.trim();
      if (userName.isEmpty) {
        throw const AuthFailure('Received invalid user profile payload');
      }

      await _preferences.setString(_accessTokenKey, tokens.accessToken);
      await _preferences.setString(_userNameKey, userName);
    } catch (error) {
      if (error is AuthFailure) {
        rethrow;
      }

      throw AuthFailure(_errorMapper.toMessage(error));
    }
  }

  String? getSavedUserName() {
    final value = _preferences.getString(_userNameKey);
    if (value == null) {
      return null;
    }

    final normalized = value.trim();
    return normalized.isEmpty ? null : normalized;
  }

  Future<void> logout() async {
    await _preferences.remove(_accessTokenKey);
    await _preferences.remove(_userNameKey);
  }
}

class AuthFailure implements Exception {
  const AuthFailure(this.message);

  final String message;
}
