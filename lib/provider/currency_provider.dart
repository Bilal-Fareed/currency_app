import 'dart:convert';

import 'package:currency_app/data/exceptions/currency_exception.dart';
import 'package:currency_app/logger.dart';
import 'package:currency_app/data/repositories/currency_repository.dart';
import 'package:currency_app/services/app_message_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../models/currency.dart';

class CurrencyProvider with ChangeNotifier {
  late bool _isLoading = false;
  late bool _hasError = false;

  late String _errorMessage;

  late CurrencyRepository currencyRepository;

  final List<Currency> _currencies = [];

  final List<Currency> _addedCurrencyList = [];

  late Currency? _baseCurrency;

  List<Currency> get addedCurrencyList => _addedCurrencyList;

  List<Currency> get currencies => _currencies;

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  String get errorMessage => _errorMessage;

  Currency? get baseCurrency => _baseCurrency;

  Future<void> loadCurrencies() async {
    _isLoading = true;
    final String response = await rootBundle.loadString('assets/final-new.json');

    final data = await json.decode(response);

    for (final country in data) {
      final countryObj = Currency.fromJsonInitial(country);

      _currencies.add(countryObj);

      if (countryObj.currencyCode == 'USD' || countryObj.currencyCode == 'EUR') {
        _addedCurrencyList.add(countryObj);

        if (countryObj.currencyCode == 'USD') {
          _baseCurrency = countryObj;
        }
      }
    }
    await getCurrencyRates();
    _isLoading = false;
    notifyListeners();
  }

  bool contains({required Currency countryToCheck}) {
    for (final country in _addedCurrencyList) {
      if (country.currencyCode == countryToCheck.currencyCode) {
        return true;
      }
    }
    return false;
  }

  String check(Currency currency) {
    final rates = _baseCurrency?.rates;
    String result = '';
    rates?.forEach((key, value) {
      if (key == currency.currencyCode) {
        result = value.toString();
      }
    });
    return result;
  }

  Future<void> getCurrencyRates() async {
    _isLoading = true;
    currencyRepository = CurrencyRepository();
    try {
      final result = await currencyRepository.getCurrencyRate(baseCurrency: _baseCurrency);
      _baseCurrency?.rates = result;
    } on CurrencyException catch (error) {
      logger.e('Currency Exception: $error');
      _hasError = true;

      _errorMessage = error.message;
    } catch (error) {
      logger.e('Exception: $error');

      _hasError = true;
      _errorMessage = AppMessageService.genericErrorMessage;
    }

    _isLoading = false;
    notifyListeners();
  }

  void addToList(Currency currency) {
    _addedCurrencyList.add(currency);
    notifyListeners();
  }

  void removeFromList(Currency currency) {
    _addedCurrencyList.remove(currency);
    if (currency == _baseCurrency) changeBaseCurrency(_addedCurrencyList.first);
    notifyListeners();
  }

  Future<void> changeBaseCurrency(Currency newBaseCurrency) async {
    _isLoading = true;
    _baseCurrency = newBaseCurrency;
    await getCurrencyRates();
    _isLoading = false;
    notifyListeners();
  }
}
