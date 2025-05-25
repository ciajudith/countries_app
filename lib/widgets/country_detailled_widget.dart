import 'package:countries_app/constants/colors.dart';
import 'package:countries_app/constants/poppins_text_style.dart';
import 'package:countries_app/constants/text.dart';
import 'package:countries_app/models/country.dart';
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
            Text(
              widget.country.name,
              style: PoppinsTextStyle.medium.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray.withValues(alpha: 0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _InfoRow(
                      label: AppStrings.capital,
                      value: widget.country.capitals.join(', ')),
                  _InfoRow(
                      label: AppStrings.population,
                      value: '${widget.country.population}'),
                  _InfoRow(
                      label: AppStrings.area,
                      value: '${widget.country.area} ${AppStrings.km2}'),
                  _InfoRow(
                      label: AppStrings.languages,
                      value: widget.country.languages.join(', ')),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.interactiveMap,
              style: PoppinsTextStyle.medium.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
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
                  AppStrings.upcoming,
                  textAlign: TextAlign.center,
                  style: PoppinsTextStyle.medium.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
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
          Text('$label : ',
              style: PoppinsTextStyle.medium
                  .copyWith(fontWeight: FontWeight.w600)),
          Expanded(
              child: Text(value,
                  style: PoppinsTextStyle.medium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ))),
        ],
      ),
    );
  }
}
