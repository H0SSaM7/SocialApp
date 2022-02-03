part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchInitial extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchListEmptyResultState extends SearchState {
  @override
  List<Object> get props => [];
}

class UpdateSearchResultState extends SearchState {
  final List<UserModel> searchResult;

  const UpdateSearchResultState(this.searchResult);
  @override
  List<Object> get props => [];
}

class ErrorSearchResultState extends SearchState {
  @override
  List<Object> get props => [];
}

class LoadingSearchDataState extends SearchState {
  @override
  List<Object> get props => [];
}
