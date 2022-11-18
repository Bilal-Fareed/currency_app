import 'package:flutter/cupertino.dart';
import '../models/country_model.dart';

final List<CountryDataModel> initialData = List.generate(
  50, 
  (index) => CountryDataModel(
    // imageUrl: "${initialData[index].imageUrl}",
    // currencyCode: "${initialData[index].currencyCode}" ,
    // countryName: "${initialData[index].countryName}"
    imageUrl: "Country Image URL $index",
    countryName: "Country Name URL $index",
    currencyCode: "Country Code $index",

    )
);

class CountryProvider with ChangeNotifier{
  
  final List<CountryDataModel> _countries = initialData;
  List<CountryDataModel> get countries => _countries; 
  
  final List<CountryDataModel> _addedCourrencyList = [];
  List<CountryDataModel> get addedCourrencyList => _addedCourrencyList; 

  void addToList(CountryDataModel movie){
    _addedCourrencyList.add(movie); 
    notifyListeners();
  }

  void removeFromList(CountryDataModel movie){
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