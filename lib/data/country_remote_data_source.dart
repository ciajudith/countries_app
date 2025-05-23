import 'package:countries_app/core/errors/exceptions.dart';
import 'package:countries_app/models/country.dart';

import 'package:countries_app/models/api_client.dart';
import 'package:dio/dio.dart';

abstract class CountryRemoteDataSource {
  Future<Country> fetchByName(String name);
  Future<List<Country>> fetchAll();
}

class CountryRemoteDataSourceImpl implements CountryRemoteDataSource {
  final ApiClient _apiClient;

  CountryRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Country> fetchByName(String name) async {
    try {
      final resp = await _apiClient.client.get(
        '/name/$name',
        queryParameters: {'fullText': true},
      );
      final list = resp.data as List<dynamic>;
      if (list.isEmpty) {
        throw ApiException('Pays non trouvé', statusCode: resp.statusCode);
      }
      return Country.fromJson(list.first as Map<String, dynamic>);
    } on DioException catch (dioErr) {
      if (dioErr.type == DioException.connectionTimeout ||
          dioErr.type == DioException.receiveTimeout) {
        throw ApiException('Délai de connexion dépassé');
      }
      if (dioErr.response != null) {
        throw ApiException(
          dioErr.response?.statusMessage ?? 'Erreur serveur',
          statusCode: dioErr.response!.statusCode,
        );
      }
      throw ApiException(
          dioErr.message ??
              dioErr.response?.statusMessage ??
              dioErr.response?.statusCode.toString() ??
              'Erreur réseauqqq',
          statusCode: dioErr.response?.statusCode);
    } catch (e) {
      throw ApiException('Erreur inattendue : $e');
    }
  }

  @override
  Future<List<Country>> fetchAll() async {
    try {
      final resp = await _apiClient.client.get(
        '/all',
        queryParameters: {
          'fields': 'name,flags,capital,population,area,languages'
        },
      );
      final list = resp.data as List<dynamic>;
      return list
          .map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (dioErr) {
      if (dioErr.type == DioException.connectionTimeout ||
          dioErr.type == DioException.receiveTimeout) {
        throw ApiException('Délai de connexion dépassé');
      }
      if (dioErr.response != null) {
        throw ApiException(
          dioErr.response?.statusMessage ?? 'Erreur serveur',
          statusCode: dioErr.response!.statusCode,
        );
      }
      throw ApiException(
        dioErr.message ?? 'Erreur réseau',
        statusCode: dioErr.response?.statusCode,
      );
    } catch (e) {
      throw ApiException('Erreur inattendue : $e');
    }
  }
}
