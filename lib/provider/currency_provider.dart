import 'dart:convert';

import 'package:currency_app/data/exceptions/currency_exception.dart';
import 'package:currency_app/logger.dart';
import 'package:currency_app/data/repositories/currency_repository.dart';
import 'package:currency_app/services/app_message_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/currency.dart';

class CurrencyProvider with ChangeNotifier {
  final CurrencyRepository _currencyRepository;
  late SharedPreferences _prefs;
  List<String> userCurrencies = [];

  CurrencyProvider({
    required CurrencyRepository currencyRepository,
    required SharedPreferences prefs,
  })  : _currencyRepository = currencyRepository,
        _prefs = prefs;

  late bool _isLoading = false;

  int _enteredAmount = 1;

  late bool _hasError = false;

  late String _errorMessage;

  final List<Currency> _currencies = [];

  final List<Currency> _addedCurrencyList = [];

  late Currency? _baseCurrency;

  List<Currency> get addedCurrencyList => _addedCurrencyList;

  List<Currency> get currencies => _currencies;

  bool get isLoading => _isLoading;

  bool get hasError => _hasError;

  String get errorMessage => _errorMessage;

  Currency? get baseCurrency => _baseCurrency;

  int get enteredAmount => _enteredAmount;

  set setEnteredAmount(int amount) => _enteredAmount = amount;

  bool isBaseCurrency(Currency currency) {
    if (_baseCurrency!.currencyCode == currency.currencyCode) {
      return true;
    }
    return false;
  }

  Future<void> loadCurrencies() async {
    _isLoading = true;
    final String response = await rootBundle.loadString('assets/final-new.json');

    final data = await json.decode(response);

    for (final country in data) {
      final countryObj = Currency.fromJsonInitial(country);

      _currencies.add(countryObj);

      final result = _prefs.getStringList('user_currencies');

      if (result != null) {
        userCurrencies = result;

        if (userCurrencies.contains(countryObj.currencyCode)) {
          _addedCurrencyList.add(countryObj);
        }
      } else {
        if (countryObj.currencyCode == 'USD' || countryObj.currencyCode == 'EUR') {
          _addedCurrencyList.add(countryObj);

          userCurrencies.add(countryObj.currencyCode);
          if (countryObj.currencyCode == 'USD') {
            _baseCurrency = countryObj;
          }
        }
      }
    }
    _baseCurrency = _addedCurrencyList.first;
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

  String getSingleRate(Currency currency) {
    final rates = _baseCurrency?.rates;
    String result = '';
    rates?.forEach((key, value) {
      if (key == currency.currencyCode) {
        result = value.toString();
      }
    });
    return result * _enteredAmount;
  }

  Future<void> getCurrencyRates() async {
    _isLoading = true;
    try {
      final result = await _currencyRepository.getCurrencyRate(baseCurrency: _baseCurrency);
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

  Future<void> addToList(Currency currency) async {
    _addedCurrencyList.add(currency);
    userCurrencies.add(currency.currencyCode);
    await _prefs.setStringList('user_currencies', userCurrencies);

    notifyListeners();
  }

  Future<void> removeFromList(Currency currency) async {
    _addedCurrencyList.remove(currency);
    if (currency == _baseCurrency) changeBaseCurrency(_addedCurrencyList.first);
    userCurrencies.remove(currency.currencyCode);
    await _prefs.setStringList('user_currencies', userCurrencies);
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
