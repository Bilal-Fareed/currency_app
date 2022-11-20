import 'dart:convert';
import 'dart:developer';

import 'package:currency_app/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../models/country_model.dart';

class CountryProvider with ChangeNotifier {
  final List<CountryDataModel> _countries = [];
  List<CountryDataModel> get countries => _countries;

  Future<void> setCountries() async {
    final String response = await rootBundle.loadString('assets/final.json');
    final data = await json.decode(response);
    for (final country in data) {
      _countries.add(CountryDataModel.fromJson(country));
    }
    notifyListeners();
  }

  final List<CountryDataModel> _addedCourrencyList = [];
  List<CountryDataModel> get addedCourrencyList => _addedCourrencyList;

  void addToList(CountryDataModel movie) {
    _addedCourrencyList.add(movie);
    notifyListeners();
  }

  void removeFromList(CountryDataModel movie) {
    _addedCourrencyList.remove(movie);
    notifyListeners();
  }
}



















// import 'dart:math';
// import 'package:flutter/cupertino.dart';

// import '../models/movie.dart';

// final List<Movie> initialData = List.generate(
//   50, 
//   (index) => Movie(
//     title: "Movie $index",
//     duration: "${Random().nextInt(100)+60} minutes" 
//     )
// );

// class MovieProvider with ChangeNotifier{
  
//   final List<Movie> _movies = initialData;
//   List<Movie> get movies => _movies; 
  
//   final List<Movie> _myList = [];
//   List<Movie> get myList => _myList; 

//   // final List<Movie> _tempList = [];
//   // List<Movie> get tempList => _tempList; 

//   void addToList(Movie movie){
//     _myList.add(movie); 
//     notifyListeners();
//   }

//   // void addToTempList(Movie movie){
//   //   _myList.add(movie);
//   //   notifyListeners();
//   // }
  
//   // void removeFromTempList(Movie movie){
//   //   _myList.add(movie);
//   //   notifyListeners();
//   // }

//   void removeFromList(Movie movie){
//     _myList.remove(movie); 
//     notifyListeners();
//   }
// }