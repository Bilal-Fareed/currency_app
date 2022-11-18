import 'package:currency_app/provider/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:currency_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<CountryProvider>(
    child: const MyApp(),
    create: (_) => CountryProvider(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        appBarTheme: const AppBarTheme().copyWith(backgroundColor: Colors.white, foregroundColor: Colors.black)
      ),
      home: const HomePage(),
    );
  }
}

