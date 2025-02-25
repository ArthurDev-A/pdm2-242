// by Arthur e Vitória

import 'package:flutter/material.dart';
import 'package:rest_country/View/country_list_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REST Countries API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CountryListScreen(),
    );
  }
}