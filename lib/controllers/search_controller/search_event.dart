part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class OnSearchBarChangeEvent extends SearchEvent {
  final String value;

  const OnSearchBarChangeEvent(this.value);
  @override
  List<Object?> get props => [value];
}

class PeopleSearchResultsEvent extends SearchEvent {
  final List<UserModel> searchResult;

  const PeopleSearchResultsEvent({this.searchResult = const []});
  @override
  List<Object?> get props => [searchResult];
}
