import 'package:countries_app/data/country_data_controller.dart';
import 'package:countries_app/widgets/country_detailled_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Dans votre widget :

class CountrySearchScreen extends StatelessWidget {
  const CountrySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Provider.of<CountryController>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Rechercher un pays')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nom du pays'),
              onSubmitted: ctrl.fetchCountry,
            ),
            SizedBox(height: 20),
            if (ctrl.status == CountryStatus.loading)
              CircularProgressIndicator(),
            if (ctrl.status == CountryStatus.error)
              Text(ctrl.errorMessage ?? 'Erreur',
                  style: TextStyle(color: Colors.red)),
            if (ctrl.status == CountryStatus.success && ctrl.country != null)
              CountryDetailledWidget(country: ctrl.country!),
          ],
        ),
      ),
    );
  }
}
