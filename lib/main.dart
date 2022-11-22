import 'package:currency_app/data/repositories/currency_repository.dart';
import 'package:currency_app/logger.dart';
import 'package:currency_app/presentation/app.dart';
import 'package:currency_app/provider/currency_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  FlutterError.onError = (details) {
    logger.e(details.summary, details.exceptionAsString(), details.stack);
  };
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CurrencyProvider(
        currencyRepository: CurrencyRepository(),
        prefs: prefs,
      ),
      child: const MyApp(),
    ),
  );
}
