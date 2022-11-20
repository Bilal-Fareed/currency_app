import 'package:currency_app/logger.dart';
import 'package:currency_app/presentation/app.dart';
import 'package:currency_app/provider/country_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  FlutterError.onError = (details) {
    logger.e(details.summary, details.exceptionAsString(), details.stack);
  };

   WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CountryProvider(),
      child: const MyApp(),
    ),
  );
}
