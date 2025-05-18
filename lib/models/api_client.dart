import 'package:countries_app/core/errors/exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  final Dio _dio;

  ApiClient._(this._dio) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (opts, handler) {
          return handler.next(opts);
        },
        onResponse: (resp, handler) {
          return handler.next(resp);
        },
        onError: (DioException err, handler) {
          if (err.type == DioExceptionType.connectionTimeout ||
              err.type == DioExceptionType.receiveTimeout ||
              err.type == DioExceptionType.sendTimeout) {
            return handler.reject(
              ApiException('Délai de connexion dépassé'),
            );
          } else if (err.response != null) {
            return handler.reject(
              ApiException(
                'Erreur ${err.response!.statusCode} : '
                '${err.response!.statusMessage}',
                statusCode: err.response!.statusCode,
              ),
            );
          } else {
            return handler.reject(
              ApiException('Erreur réseau : ${err.message}'),
            );
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

  Dio get instance => _dio;
}
