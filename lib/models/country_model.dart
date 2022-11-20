class CountryDataModel {
  String? imageUrl;
  String? currencyCode;
  String? countryName;
  bool? isBase;
  double? rate;

  CountryDataModel({required this.imageUrl, required this.currencyCode, required this.countryName});

  CountryDataModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['emojiFlag'];
    currencyCode = json['isoCode'];
    countryName = json['country'];
  }
}
