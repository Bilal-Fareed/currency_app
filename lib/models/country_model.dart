class CountryDataModel {
  String? imageUrl;
  String? currencyCode;
  String? countryName;

  CountryDataModel({required this.imageUrl,required this.currencyCode,required this.countryName});

  CountryDataModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['flag'];
    currencyCode = json['currency']['code'];
    countryName = json['name'];
  }
}


// class Movie{
//   final String title;
//   final String? duration;

//   Movie({required this.title,required this.duration});
// }
