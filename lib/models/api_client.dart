import 'package:countries_app/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final Dio _dio;

  ApiClient._(this._dio) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          if (error.response != null) {
            final statusCode = error.response?.statusCode;
            final message = error.response?.data['message'] ?? 'Unknown error';
            throw ApiException(message, statusCode: statusCode);
          } else {
            throw ApiException('Network error',
                statusCode: error.response?.statusCode);
          }
        },
      ),
    );
  }

  factory ApiClient() {
    final baseUrl = dotenv.env['API_URL'] ?? '';
    assert(
      Uri.parse(baseUrl).scheme == 'https',
      'La variable API_URL doit commencer par "https://"',
    );

    final dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
      },
      followRedirects: false,
      contentType: 'application/json',
      validateStatus: (status) =>
          status != null && status >= 200 && status < 300,
    ));

    return ApiClient._(dio);
  }

  Dio get client => _dio;
}
