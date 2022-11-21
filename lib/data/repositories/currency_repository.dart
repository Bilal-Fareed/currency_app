import 'dart:convert';

import 'package:currency_app/data/exceptions/currency_exception.dart';
import 'package:currency_app/logger.dart';
import 'package:currency_app/models/currency.dart';
import 'package:http/http.dart' as http;

class CurrencyRepository {
  Future<Map<String, dynamic>> getCurrencyRate({required Currency? baseCurrency}) async {
    Map<String, dynamic> rates;

    final response = await http.get(
      Uri.parse('http://192.168.0.105:3500/v1/currencyRate/${baseCurrency!.currencyCode}'),
      // headers: <String, String>{
      //   'Content-Type': 'application/json;charset=UTF-8',
      //   'Charset': 'utf-8',
      // },
    );

    if (response.statusCode != 200) {
      final data = json.decode(response.body);
      throw CurrencyException(data['data']['error']);
    } else {
      Map<String, dynamic> data = json.decode(response.body);
      rates = data['data'];
      return rates;
    }
  }
}
