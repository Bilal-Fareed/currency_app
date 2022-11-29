import 'dart:async';

import 'package:currency_app/data/repositories/currency_repository.dart';
import 'package:currency_app/logger.dart';
import 'package:currency_app/provider/currency_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    logger.e(details.summary, details.exceptionAsString(), details.stack);
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      await Firebase.initializeApp();
      runApp(
        ChangeNotifierProvider(
          create: (context) => CurrencyProvider(currencyRepository: CurrencyRepository(), prefs: prefs),
          child: await builder(),
        ),
      );
    },
    (error, stackTrace) {
      logger.e('Exception', error, stackTrace);
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
