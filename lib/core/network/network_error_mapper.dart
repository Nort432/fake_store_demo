import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NetworkErrorMapper {
  const NetworkErrorMapper();

  String toMessage(Object error) {
    if (error is DioException) {
      final statusCode = error.response?.statusCode;
      if (statusCode == 401) {
        return 'Invalid credentials';
      }
      if (statusCode != null && statusCode >= 500) {
        return 'Server is unavailable. Try again later.';
      }
    }

    return 'Something went wrong. Please try again.';
  }
}
