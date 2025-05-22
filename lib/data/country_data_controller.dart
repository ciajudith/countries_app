// lib/presentation/controllers/country_controller.dart

import 'package:countries_app/data/country_remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:countries_app/core/errors/exceptions.dart';
import 'package:countries_app/models/country.dart';

enum CountryStatus { initial, loading, success, error }

class CountryController with ChangeNotifier {
  final CountryRemoteDataSource _remoteDs;
  CountryController(this._remoteDs);

  CountryStatus _status = CountryStatus.initial;
  CountryStatus get status => _status;

  Country? _country;
  Country? get country => _country;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> fetchCountry(String name) async {
    _status = CountryStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _remoteDs.fetchByName(name.trim());
      _country = result;
      _status = CountryStatus.success;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      _status = CountryStatus.error;
    } catch (e) {
      _errorMessage = 'Erreur inattendue : $e';
      _status = CountryStatus.error;
    }
    notifyListeners();
  }
}
