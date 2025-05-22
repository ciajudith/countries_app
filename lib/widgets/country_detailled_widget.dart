import 'package:countries_app/models/country.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryDetailledWidget extends StatefulWidget {
  const CountryDetailledWidget({super.key, required this.country});
  final Country country;

  @override
  State<CountryDetailledWidget> createState() => _CountryDetailledWidgetState();
}

class _CountryDetailledWidgetState extends State<CountryDetailledWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero sur le drapeau pour une belle transition
            Hero(
              tag: 'flag_${widget.country.name}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.country.flagUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Nom du pays
            Text(
              widget.country.name,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),

            // Card animée des infos clés
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                      label: 'Capitale',
                      value: widget.country.capitals.join(', ')),
                  _InfoRow(
                      label: 'Population',
                      value: '${widget.country.population}'),
                  _InfoRow(
                      label: 'Superficie', value: '${widget.country.area} km²'),
                  _InfoRow(
                      label: 'Langues',
                      value: widget.country.languages.join(', ')),
                ],
              ),
            ),

            const SizedBox(height: 24),
            // Placeholder pour la carte interactive
            Text(
              'Carte interactive',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'Intégrer ici votre widget `flutter_map`',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
            ),

            const SizedBox(height: 24),
            // Section pour infos complémentaires
            // ExpansionTile(
            //   title: Text('Informations complémentaires'),
            //   children: [
            //     ListTile(
            //       leading: Icon(Icons.info_outline),
            //       title: Text('Statut indépendant'),
            //       subtitle: Text(widget.country.independent ? 'Oui' : 'Non'),
            //     ),
            //     ListTile(
            //       leading: Icon(Icons.public),
            //       title: Text('Membre de l’ONU'),
            //       subtitle: Text(widget.country.unMember ? 'Oui' : 'Non'),
            //     ),
            //     if (widget.country.gini.isNotEmpty)
            //       ListTile(
            //         leading: Icon(Icons.bar_chart),
            //         title: Text('Indice de Gini (${widget.country.gini.keys.first})'),
            //         subtitle: Text('${widget.country.gini.values.first}'),
            //       ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text('$label : ', style: TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
