import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/data/repository/search_repo/search_repository.dart';
import 'package:social_app/models/user_model.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository _searchRepository;

  SearchBloc({required SearchRepository searchRepository})
      : _searchRepository = searchRepository,
        super(SearchInitial()) {
    on<OnSearchBarChangeEvent>(_getSearchResult);

    on<PeopleSearchResultsEvent>(_updatePeopleSearchResult);
  }

  FutureOr<void> _getSearchResult(
      OnSearchBarChangeEvent event, Emitter<SearchState> emit) async {
    emit(LoadingSearchDataState());
    var searchData =
        await _searchRepository.getSearchResult(value: event.value);
    add(PeopleSearchResultsEvent(searchResult: searchData));
  }
}

FutureOr<void> _updatePeopleSearchResult(
    PeopleSearchResultsEvent event, Emitter<SearchState> emit) {
  if (event.searchResult.isEmpty) {
    emit(SearchListEmptyResultState());
  } else if (event.searchResult.isNotEmpty) {
    emit(UpdateSearchResultState(event.searchResult));
  } else {
    emit(ErrorSearchResultState());
  }
}
