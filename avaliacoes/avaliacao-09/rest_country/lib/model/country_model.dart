class Country {
  final String name;
  final String capital;
  final String flagUrl;

  Country({required this.name, required this.capital, required this.flagUrl});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      capital: (json['capital'] != null && json['capital'].isNotEmpty) ? json['capital'][0] : 'No Capital',
      flagUrl: json['flags']['png'],
    );
  }
}