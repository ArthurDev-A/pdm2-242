import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rest_country/model/country_model.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late Future<List<Country>> countries;
  int currentPage = 0;
  static const int countriesPerPage = 25;

  @override
  void initState() {
    super.initState();
    countries = fetchCountries();
  }

  // Função para buscar dados da API
  Future<List<Country>> fetchCountries() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      List<Country> countryList = jsonResponse.map((data) => Country.fromJson(data)).toList();
      countryList.sort((a, b) => a.name.compareTo(b.name)); // Ordenação alfabética
      return countryList;
    } else {
      throw Exception('Erro ao carregar os países');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Países - Arthur e Vitória P.'),
        elevation: 10,
      ),
      body: FutureBuilder<List<Country>>(
        future: countries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            final countryList = snapshot.data!;
            final totalPages = (countryList.length / countriesPerPage).ceil();
            final start = currentPage * countriesPerPage;
            final end = (start + countriesPerPage).clamp(0, countryList.length);
            final currentCountries = countryList.sublist(start, end);

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: currentCountries.length,
                    itemBuilder: (context, index) {
                      final country = currentCountries[index];
                      return ListTile(
                        leading: Image.network(country.flagUrl, width: 50),
                        title: Text(country.name),
                        subtitle: Text('Capital: ${country.capital}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: currentPage > 0
                            ? () {
                                setState(() {
                                  currentPage--;
                                });
                              }
                            : null,
                      ),
                      Text('Página ${currentPage + 1} de $totalPages'),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: currentPage < totalPages - 1
                            ? () {
                                setState(() {
                                  currentPage++;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
