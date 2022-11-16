import 'package:dio/dio.dart';
import '../../model/country_list_response.dart';

class Api {

  static const baseUrl = "https://restcountries.com/v3.1";
  static const all_country_list =  "/all";

  // taking data from api
  static Future<List<CountryListResponse>?> getCountryList() async {
    List<CountryListResponse> _countryList = [];

    // added try catch for catching the exception.
    try {
      const requestUrl = baseUrl + all_country_list;
      Response response = await Dio().get(requestUrl); // dio is for http call
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        for (var element in jsonList) {
          _countryList.add(CountryListResponse.fromJson(element));
        }
        return _countryList;
      } else {
        return _countryList;
      }
    } catch (e) {
      // here we can add multiple catch exceptions
      print(e.toString());
      return _countryList;
    }
  }


}
