import 'package:countries_app/constants/text.dart';
import 'package:countries_app/models/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
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
      return Scaffold(
        body: Center(
          child: LottieBuilder.asset(
            AppStrings.loadingJsonPath,
            width: 110,
            height: 110,
          ),
        ),
      );
    }
    if (_error != null) {
      return Scaffold(
        body: Center(child: Text('Erreur : $_error')),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,
          surfaceTintColor: AppColors.gold.withValues(alpha: 0.1),
          title: Text(
            AppStrings.searchCountry,
            style: PoppinsTextStyle.medium.copyWith(
              color: AppColors.green,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back,
                color: AppColors.green, size: 24),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TypeAheadField<Country>(
                builder: (ctx, TextEditingController controller,
                    FocusNode focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      hintText: AppStrings.searchCountryHint,
                      hintStyle: PoppinsTextStyle.regular.copyWith(
                        color: AppColors.gray,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.goldDark,
                        size: 20,
                        weight: 4,
                      ),
                    ),
                    onSubmitted: (controller) {
                      FocusScope.of(context).unfocus();
                    },
                  );
                },
                suggestionsCallback: (pattern) {
                  return _allCountries
                      .where((c) => c.name
                          .toLowerCase()
                          .startsWith(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (ctx, Country country) {
                  return ListTile(
                    leading: Image.network(country.flagUrl, width: 32),
                    title: Text(country.name),
                  );
                },
                emptyBuilder: (ctx) => Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    AppStrings.noCountryFound,
                    style: PoppinsTextStyle.regular.copyWith(
                      color: AppColors.gray,
                      fontSize: 14,
                    ),
                  ),
                ),
                onSelected: (Country country) {
                  FocusScope.of(context).unfocus();
                  ctrl.fetchCountry(country.name);
                },
              ),
              const SizedBox(height: 20),
              if (ctrl.status == CountryStatus.loading)
                Expanded(
                  child: Center(
                    child: LottieBuilder.asset(
                      AppStrings.loadingJsonPath,
                      width: 110,
                      height: 110,
                    ),
                  ),
                ),
              if (ctrl.status == CountryStatus.error)
                Text(
                  ctrl.errorMessage ?? AppStrings.genericError,
                  style: PoppinsTextStyle.medium.copyWith(
                    color: AppColors.accent,
                  ),
                ),
              if (ctrl.status == CountryStatus.success && ctrl.country != null)
                CountryDetailledWidget(country: ctrl.country!),
            ],
          ),
        ),
      ),
    );
  }
}
