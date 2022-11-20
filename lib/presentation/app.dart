import 'package:currency_app/logger.dart';
import 'package:currency_app/presentation/screens/home_screen.dart';
import 'package:currency_app/provider/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late CountryProvider _countryProvider;

  @override
  void initState() {
    _countryProvider = Provider.of<CountryProvider>(context, listen: false);
    _countryProvider.setCountries().then((value) => logger.i('countries data sett'));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const HomePage(),
    );
  }
}
