import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projet/fetch/fetch_search.dart';

abstract class SearchEvent {}

class SearchTextChanged extends SearchEvent {
  final String searchTerm;

  SearchTextChanged({required this.searchTerm});
}
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final Map<String, dynamic> searchResults;

  SearchSuccess({required this.searchResults});
}

class SearchFailure extends SearchState {
  final String error;

  SearchFailure({required this.error});
}



class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchTextChanged>((event, emit) async {
      if (event.searchTerm.isEmpty) {
        emit(SearchInitial());
        return;
      }
      emit(SearchLoading());
      try {
        final results = await ApiService().searchComicVine(event.searchTerm);
        emit(SearchSuccess(searchResults: results));
      } catch (error) {
        emit(SearchFailure(error: error.toString()));
      }
    });
  }
}

