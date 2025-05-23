import 'package:countries_app/models/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:provider/provider.dart';

import 'package:countries_app/data/country_remote_data_source.dart';
import 'package:countries_app/data/country_data_controller.dart';
import 'package:countries_app/models/country.dart';
import 'package:countries_app/widgets/country_detailled_widget.dart';
import 'package:countries_app/constants/colors.dart';
import 'package:countries_app/constants/poppins_text_style.dart';

class CountrySearchScreen extends StatefulWidget {
  const CountrySearchScreen({super.key});

  @override
  State<CountrySearchScreen> createState() => _CountrySearchScreenState();
}

class _CountrySearchScreenState extends State<CountrySearchScreen> {
  List<Country> _allCountries = [];
  bool _isLoading = true;
  String? _error;
  final CountryRemoteDataSource dataSource =
      CountryRemoteDataSourceImpl(ApiClient());

  @override
  void initState() {
    super.initState();
    _loadAllCountries();
  }

  Future<void> _loadAllCountries() async {
    try {
      final list = await dataSource.fetchAll();
      setState(() {
        _allCountries = list;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<CountryController>(context);

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_error != null) {
      return Scaffold(
        body: Center(child: Text('Erreur : $_error')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Rechercher un pays')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TypeAheadField<Country>(
              builder:
                  (ctx, TextEditingController controller, FocusNode focusNode) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: 'Nom du pays',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              },
              suggestionsCallback: (pattern) {
                return _allCountries
                    .where((c) =>
                        c.name.toLowerCase().startsWith(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (ctx, Country country) {
                return ListTile(
                  leading: Image.network(country.flagUrl, width: 32),
                  title: Text(country.name),
                );
              },
              // plus de noItemsFoundBuilder, on utilise emptyBuilder
              emptyBuilder: (ctx) => const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Aucun pays trouvé'),
              ),
              // à la sélection, on déclenche fetchCountry()
              onSelected: (Country country) {
                ctrl.fetchCountry(country.name);
              },
            ),

            const SizedBox(height: 20),

            // état de chargement / erreur / success
            if (ctrl.status == CountryStatus.loading)
              const CircularProgressIndicator(),
            if (ctrl.status == CountryStatus.error)
              Text(
                ctrl.errorMessage ?? 'Erreur',
                style: PoppinsTextStyle.medium.copyWith(
                  color: AppColors.accent,
                ),
              ),
            if (ctrl.status == CountryStatus.success && ctrl.country != null)
              // ton CountryDetailledWidget gère déjà son propre Expanded
              CountryDetailledWidget(country: ctrl.country!),
          ],
        ),
      ),
    );
  }
}
