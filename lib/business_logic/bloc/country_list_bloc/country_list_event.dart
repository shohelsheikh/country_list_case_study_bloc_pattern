part of 'country_list_bloc.dart';

@immutable
abstract class CountrylistEvent {}

// this event is for showing the list
class GetCountryList extends CountrylistEvent {
  GetCountryList();
}

// this event is for searching the list
class GetCountrySearch extends CountrylistEvent {

  final String searchText;
  GetCountrySearch({required this.searchText});


}
