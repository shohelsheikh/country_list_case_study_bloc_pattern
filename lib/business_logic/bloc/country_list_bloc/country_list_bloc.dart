import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:country_list_case_study_bloc_pattern/data/localdb/database/table_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:country_list_case_study_bloc_pattern/data/dataproviders/network/api_call.dart';

import '../../../data/localdb/hive_db_manager.dart';
import '../../../data/model/country_list_response.dart';

part 'country_list_event.dart';

part 'country_list_state.dart';

// Business logic of country list
class CountrylistBloc extends Bloc<CountrylistEvent, CountrylistState> {

  // set to initial state as default
  CountrylistBloc() : super(CountrylistInitial());
  List<CountryListResponse>? countryListNew=[];  // Used to get the list of records from api
  List<CountryListResponse>? countryList=[]; // Added this extra list for searching the records

  // handle the list of events
  @override
  Stream<CountrylistState> mapEventToState(
    CountrylistEvent event,
  ) async* {
    if (event is GetCountryList) {
      yield CountrylistLoading();
      countryList?.clear();  // clears the list of records
      countryListNew?.clear(); // clears the list of records

      var result = HiveDBManager.instance.read(TableConstant.tableCountries); // read from local db
      if(result != null) {
        // if data exist in table then fetch from it
        for (var element in result) {
          countryList?.add(CountryListResponse.fromJson(element));
          countryListNew?.add(CountryListResponse.fromJson(element));
        }
      }
    else{
      // else it will fetch from api
      countryList = await Api.getCountryList();
      countryListNew ?.addAll(countryList!);
      HiveDBManager.instance.save(TableConstant.tableCountries, countryListNew); // save list to hive db
    }
      if (countryList?.length==0) {
        yield CountrylistFailed();
      } else {
        yield CountrylistLoaded(brakingList: countryListNew);
      }

    }
    // search functionality logic
    else if(event is GetCountrySearch)
    {
      countryListNew?.clear();
      if(event.searchText.trim().length==0){
        countryListNew?.addAll(countryList??[]);
        yield CountrylistLoaded(brakingList: countryListNew);
      }else{
        for (int i = 0; i < countryList!.length; i++) {
          String? name = countryList![i].name?.common;
          if (name == null) {
            name = "";
          }
          if (name.trim().toLowerCase().contains(event.searchText.toLowerCase())) {
            countryListNew?.add(countryList![i]);
            yield CountrylistLoaded(brakingList: countryListNew);
          }
          else
            {
              yield CountrylistLoaded(brakingList: countryListNew);
            }
        }
      }
    }



  }



}
