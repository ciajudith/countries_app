class Country {
  final String name;
  final List<String> capitals;
  final int population;
  final double area;
  final List<String> languages;
  final String flagUrl;

  Country({
    required this.name,
    required this.capitals,
    required this.population,
    required this.area,
    required this.languages,
    required this.flagUrl,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'] as String,
      capitals: (json['capital'] as List).cast<String>(),
      population: json['population'] as int,
      area: (json['area'] as num).toDouble(),
      languages: (json['languages'] as Map<String, dynamic>)
          .values
          .cast<String>()
          .toList(),
      flagUrl: json['flags']['png'] as String,
    );
  }
}
