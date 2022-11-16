part of 'country_list_bloc.dart';

@immutable
abstract class CountrylistState {}

// list initial state that is default one
class CountrylistInitial extends CountrylistState {}

// list loading state when it start fetching data from server
class CountrylistLoading extends CountrylistState {}

// when data is loaded
class CountrylistLoaded extends CountrylistState {
  final List<CountryListResponse>?  brakingList;
  CountrylistLoaded({this.brakingList});
}

// if failed to load the data.
class CountrylistFailed extends CountrylistState {}
